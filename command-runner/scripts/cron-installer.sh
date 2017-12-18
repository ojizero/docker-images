#!/bin/sh
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NOCOLOR='\033[0m'

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
else
    echo "${RED}Failed to detect package manager${NOCOLOR}" >&2
    exit 1
fi

echo "${GREEN}Detected package manager '${BLUE}${PACKAGE_MANAGER}${GREEN}'${NOCOLOR}"

${PACKAGE_MANAGER} ${UPDATE_COMMAND} ${UPDATE_OPTS}
${PACKAGE_MANAGER} ${INSTALL_COMMAND} ${INSTALL_OPTS} ${PACKAGES}
