#!/bin/bash

net_provider() {
  [ -z ${network_provider} ] && network_provider="auto"

  if [ "${network_provider}" = "auto" ]; then
    if systemctl -q is-active systemd-networkd; then
      network_provider="systemd-networkd"
    else
      network_provider="network"
    fi
  fi

  echo ${network_provider}
}

# called by dracut
check() {
  #check for sshd
  require_binaries sshd || return 1

  return 0
}

# called by dracut
depends() {
  echo $(net_provider)
  return 0
}

# called by dracut
install() {
  [ -z ${authorized_keys} ] && authorized_keys="/root/.ssh/authorized_keys"
  [ -z ${sshd_opts} ] && sshd_opts="-e -p 22"
  [ -z ${dsa_host_key} ] && dsa_host_key="/etc/ssh/ssh_host_dsa_key"
  [ -z ${ecdsa_host_key} ] && ecdsa_host_key="/etc/ssh/ssh_host_ecdsa_key"
  [ -z ${ed25519_host_key} ] && ed25519_host_key="/etc/ssh/ssh_host_ed25519_key"
  [ -z ${rsa_host_key} ] && rsa_host_key="/etc/ssh/ssh_host_rsa_key"
  [ -z ${systemd_networkd_files} ] && systemd_networkd_files="/etc/systemd/network/*"

  local keytype keyfile
  for keytype in dsa ecdsa ed25519 rsa; do
    case ${keytype} in
      dsa) keyfile=${dsa_host_key} ;;
      ecdsa) keyfile=${ecdsa_host_key} ;;
      ed25519) keyfile=${ed25519_host_key} ;;
      rsa) keyfile=${rsa_host_key} ;;
    esac

    [ -f ${keyfile} ] && inst_simple "${keyfile}" /etc/ssh/ssh_host_${keytype}_key
  done

  inst_simple "${moddir}/sshd_config" /etc/ssh/sshd_config
  inst_simple "${moddir}/sshd-banner" /etc/ssh/sshd-banner
  inst_simple "$(which sshd)"

  inst_simple "${moddir}/sshd.service" ${systemdsystemunitdir}/sshd.service
  mkdir -p "${initdir}/etc/sysconfig"
  echo "SSHD_OPTS=\"${sshd_opts}\"" > "${initdir}/etc/sysconfig/sshd"

  if [ ! -r "${authorized_keys}" ]; then
    dfatal "No authorized_keys found!"
    return 1
  fi

  inst_simple ${authorized_keys} /root/.ssh/authorized_keys

  getent passwd sshd >> "${initdir}/etc/passwd"
  getent group sshd >> "${initdir}/etc/group"

  mkdir -p -m 0755 "${initdir}$(getent passwd sshd | cut -d':' -f6)"

  systemctl -q --root "${initdir}" enable sshd

  mkdir -p -m 0755 "${initdir}/var/log"
  touch "${initdir}/var/log/lastlog"

  local nf
  if [ "$(net_provider)" = "systemd-networkd" ]; then
    for nf in ${systemd_networkd_files}; do
      inst_simple "${nf}"
    done
  fi

  return 0
}
