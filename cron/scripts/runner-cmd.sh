#!/bin/sh
set -e

if [ $(echo "$STAGE" | egrep 'prod(uction)?') ]; then
    /opt/scripts/production-run.sh
else
    ${CRON_EXEC} ${EXEC_OPTS} >> "${LOGS_PATH}"
fi
