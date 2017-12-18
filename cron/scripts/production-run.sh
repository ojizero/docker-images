#!/bin/sh
set -e

env > /tmp/environment
cat /tmp/environment > /etc/cron.d/main-cron
cat "${CRON_SPEC} ${CRON_EXEC} ${EXEC_OPTS} >> ${LOGS_PATH}" >> /etc/cron.d/main-cron

# Run cron in the forground should
# errors happen we detect that
# the container failed
if [ $(which cron) ]; then
    CRON_BIN="$(which cron)"
elif [ $(which crond) ];
    CRON_BIN="$(which crond)"
else
    echo 'neither cron nor crond is installed' >&2
    exit 1
fi

CRON_OPTS='-f'

${CRON_BIN} ${CRON_OPTS}
