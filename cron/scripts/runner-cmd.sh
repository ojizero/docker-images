#!/bin/sh
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NOCOLOR='\033[0m'

if [ -z "${CRON_EXEC}"]; then
    echo "${RED}No executable provided."
    exit 1
fi

if [ $(echo "$STAGE" | egrep 'prod(uction)?') ]; then

    echo "${GREEN}Production stage, running scheduler${NOCOLOR}"
    /opt/scripts/production-run.sh

else

    echo "${GREEN}Non production stage '${BLUE}${STAGE}${GREEN}', running once${NOCOLOR}"
    ${CRON_EXEC} ${EXEC_OPTS} | tee -a "${LOGS_PATH}"

fi
