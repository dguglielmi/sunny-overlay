#!/bin/bash

# called by dracut
check() {
  #check for sshd
  require_binaries sshd || return 1

  return 0
}

depends() {
  echo network
  return 0
}

install() {
  [ -z ${AUTHORIZED_KEYS} ] && AUTHORIZED_KEYS="/root/.ssh/authorized_keys"
  [ -z ${SSHD_OPTS} ] && SSHD_OPTS="-e -p 22"
  [ -z ${DSA_HOST_KEY} ] && DSA_HOST_KEY="/etc/ssh/ssh_host_dsa_key"
  [ -z ${ECDSA_HOST_KEY} ] && ECDSA_HOST_KEY="/etc/ssh/ssh_host_ecdsa_key"
  [ -z ${ED25519_HOST_KEY} ] && ED25519_HOST_KEY="/etc/ssh/ssh_host_ed25519_key"
  [ -z ${RSA_HOST_KEY} ] && RSA_HOST_KEY="/etc/ssh/ssh_host_rsa_key"

  local keytype keyfile
  for keytype in dsa ecdsa ed25519 rsa; do
    case ${keytype} in
      dsa) keyfile=${DSA_HOST_KEY} ;;
      ecdsa) keyfile=${ECDSA_HOST_KEY} ;;
      ed25519) keyfile=${ED25519_HOST_KEY} ;;
      rsa) keyfile=${RSA_HOST_KEY} ;;
    esac

    [ -f ${keyfile} ] && inst_simple "${keyfile}" /etc/ssh/ssh_host_${keytype}_key
  done

  inst_simple "${moddir}/sshd_config" /etc/ssh/sshd_config
  inst_simple "$(which sshd)"

  inst_simple "${moddir}/sshd.service" ${systemdsystemunitdir}/sshd.service
  mkdir -p "${initdir}/etc/sysconfig"
  echo "SSHD_OPTS=\"${SSHD_OPTS}\"" > "${initdir}/etc/sysconfig/sshd"

  if [ -f ${AUTHORIZED_KEYS} ]; then
    inst_simple ${AUTHORIZED_KEYS} /root/.ssh/authorized_keys
  else
    dfatal "No authorized_keys for root user found!"
    return 1
  fi

  getent passwd sshd >> "${initdir}/etc/passwd"
  getent group sshd >> "${initdir}/etc/group"

  mkdir -p -m 0755 "${initdir}$(getent passwd sshd | cut -d':' -f6)"

  systemctl -q --root "${initdir}" enable sshd

  mkdir -p -m 0755 "${initdir}/var/log"
  touch "${initdir}/var/log/lastlog"

  return 0
}
