#!/bin/sh

set -eua

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <client|server>" >&2
  exit 2
fi

WSTUNNEL_MODE=${1}

case "${WSTUNNEL_MODE}" in
  client|server)
  ;;
  *)
    echo "Invalid mode: ${WSTUNNEL_MODE} (expected client or server)" >&2
    exit 2
  ;;
esac

CONFIG=~/.config/wstunnel-${WSTUNNEL_MODE}
SYSTEM_CONFIG="/etc/default/wstunnel-${WSTUNNEL_MODE}"

if [ -r "${CONFIG}" ]; then
  . "${CONFIG}"
elif [ -r "${SYSTEM_CONFIG}" ]; then
  . "${SYSTEM_CONFIG}"
else
  echo "No configuration found for ${WSTUNNEL_MODE}" >&2
  exit 1
fi

if [ -z "${WSTUNNEL_ARGS}" ]; then
  echo "WSTUNNEL_ARGS is empty" >&2
  exit 1
fi

exec /usr/bin/wstunnel "${WSTUNNEL_MODE}" ${WSTUNNEL_ARGS}
