#!/bin/sh
set -e

if [ $(echo "$STAGE" | egrep 'prod(uction)?') ]; then
    echo "Production stage running scheduler"
    /opt/scripts/production-run.sh
else
    echo "Non production stage '${STAGE}' running once"
    ${CRON_EXEC} ${EXEC_OPTS} | tee -a "${LOGS_PATH}"
fi
