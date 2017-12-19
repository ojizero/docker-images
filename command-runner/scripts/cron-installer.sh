#!/bin/sh
set -e

if [ "${TERM}" = 'xterm-256color' ]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    NOCOLOR='\033[0m'
fi

if [ $(which apt-get) ]; then
    PACKAGE_MANAGER='apt-get'

    UPDATE_COMMAND='update'
    UPDATE_OPTS=''

    INSTALL_COMMAND='install'
    INSTALL_OPTS='-y'

    PACKAGES='cron'
elif [ $(which apk) ]; then
    PACKAGE_MANAGER='apk'

    UPDATE_COMMAND='update'
    UPDATE_OPTS=''

    INSTALL_COMMAND='add'
    INSTALL_OPTS=''

    PACKAGES='dcron'

    ALP_CLR='-e'
else
    echo ${ALP_CLR} "${RED}Failed to detect package manager${NOCOLOR}" >&2
    exit 1
fi

echo ${ALP_CLR} "${GREEN}Detected package manager '${BLUE}${PACKAGE_MANAGER}${GREEN}'${NOCOLOR}"

${PACKAGE_MANAGER} ${UPDATE_COMMAND} ${UPDATE_OPTS}
${PACKAGE_MANAGER} ${INSTALL_COMMAND} ${INSTALL_OPTS} ${PACKAGES}
