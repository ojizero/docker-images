#!/bin/sh
set -e

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

# Inject cron spec and command is
# provided as ARGs to the script
echo "${CRON_SPEC} ${@}" > $CRON_FILE
echo '' >> $CRON_FILE

# Add cron file
crontab "${CRON_FILE}"

# Cron options
# : -f run in foreground
CRON_OPTS='-f'

${CRON_DAEMON} ${CRON_OPTS}
