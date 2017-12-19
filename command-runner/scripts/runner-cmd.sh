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

if [ -z "${CRON_EXEC}" ]; then
    echo ${ALP_CLR} "${RED}No executable provided."
    exit 1
fi

if [ "${WRITE_ENV}" != 'false' ]; then
    # Create environment file it also encapsulates values
    # with singel quotes to fix sourcing the file
    env | awk -F'=' "{ print \$1\"=\"\"'\"\$2\"'\" }" | tee $ENV_FILE > /dev/null
fi

# Create main command
MAIN_COMMAND=". ${ENV_FILE} && ${CRON_EXEC} ${EXEC_OPTS}"

if [ $(echo "$STAGE" | egrep -i 'prod(uction)?') ]; then

    echo ${ALP_CLR} "${GREEN}Production stage, running scheduler${NOCOLOR}"
    echo
    echo ${ALP_CLR} "${BLUE}STDOUT:${NOCOLOR}"
    echo

    /opt/scripts/production-run.sh "${MAIN_COMMAND}"

else

    echo ${ALP_CLR} "${GREEN}Non production stage '${BLUE}${STAGE}${GREEN}', running once${NOCOLOR}"
    echo
    echo ${ALP_CLR} "${BLUE}STDOUT:${NOCOLOR}"
    echo

    eval "${MAIN_COMMAND}"

    STATUS="$?"

    echo
    echo ${ALP_CLR} "${BLUE}Command exited with status: ${STATUS}${NOCOLOR}"
    echo

    exit ${STATUS}

fi
