#!/bin/sh
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NOCOLOR='\033[0m'

if [ -z "${CRON_EXEC}" ]; then
    echo "${RED}No executable provided."
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

    echo "${GREEN}Production stage, running scheduler${NOCOLOR}"
    echo
    echo "${BLUE}STDOUT:${NOCOLOR}"
    echo

    /opt/scripts/production-run.sh "${MAIN_COMMAND}"

else

    echo "${GREEN}Non production stage '${BLUE}${STAGE}${GREEN}', running once${NOCOLOR}"
    echo
    echo "${BLUE}STDOUT:${NOCOLOR}"
    echo

    eval "${MAIN_COMMAND}"

    STATUS="$?"

    echo
    echo "${BLUE}Command exited with status: ${STATUS}${NOCOLOR}"
    echo

    exit ${STATUS}

fi
