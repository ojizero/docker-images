#!/bin/sh
set -e

CRON_FILE='/var/spool/cron/crontabs/root'
EXECUTER_PATH='/bin/execute'

REDIRECT_STDOUT="> /proc/${$}/fd/1"
REDIRECT_STDERR="2> /proc/${$}/fd/2"

MAIN_COMMAND="( ${@} ) ${REDIRECT_STDOUT} ${REDIRECT_STDERR}"

echo '#!/bin/sh' > "${EXECUTER_PATH}"
echo "${MAIN_COMMAND}" >> "${EXECUTER_PATH}"
chmod +x "${EXECUTER_PATH}"

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
echo "${CRON_SPEC} ${EXECUTER_PATH}" > $CRON_FILE
echo '' >> $CRON_FILE

# Add cron file
crontab "${CRON_FILE}"

# Cron options
# : -f run in foreground
CRON_OPTS='-f'

${CRON_DAEMON} ${CRON_OPTS}
