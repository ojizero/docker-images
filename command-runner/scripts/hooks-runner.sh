#!/bin/sh
set -e

if [ "${TERM}" = 'xterm-256color' ]; then
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  BLUE='\033[0;34m'
  NOCOLOR='\033[0m'
fi

if [ "$(cat /etc/os-release | egrep -i 'alpine')" ]; then
  ALP_CLR='-e'
fi

. "${ENV_FILE}"

hook_name="${1}"
shift

# TODO: handle '*'
eval "hook=\"\$${hook_name}\""

if [[ ! -z "${hook}" ]]; then
  echo ${ALP_CLR} "${GREEN}Running ${hook_name} hook ...${NOCOLOR}"

  sh -c "${hook}" || ( echo ${ALP_CLR} "${RED}Hook ${hook_name} failed${NOCOLOR}" >&2 && exit 1 )

  echo ${ALP_CLR} "${GREEN}Hook ${hook_name} completed${NOCOLOR}"
  exit 0
fi
