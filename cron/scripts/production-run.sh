#!/bin/sh
set -e

ENV_FILE='/etc/environment'
CRON_FILE='/var/spool/cron/crontabs/root'

# Specify binary of cron
if [ $(which cron) ]; then

    CRON_DAEMON="$(which cron)"
    CRON_FILE='/var/spool/cron/crontabs/root'

elif [ $(which crond) ]; then

    CRON_DAEMON="$(which crond)"
    CRON_FILE='/etc/crontabs/root'

else

    echo 'neither `cron` nor `crond` is installed' >&2
    exit 1

fi

# Create environment file
env > $ENV_FILE
# Inject cron spec, before running
# command source the environment
echo "${CRON_SPEC} . ${ENV_FILE} && ${CRON_EXEC} ${EXEC_OPTS} >> ${LOGS_PATH}" > $CRON_FILE
echo '' >> $CRON_FILE

# Add cron file
crontab ${CRON_FILE}

# Cron options
# : -f run in foreground
CRON_OPTS='-f'

${CRON_DAEMON} ${CRON_OPTS}
