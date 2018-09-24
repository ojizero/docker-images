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
    echo ${ALP_CLR} "${RED}No executable provided.${NOCOLOR}"
    exit 1
fi

TMP_ENV="/tmp/env_temp_${$}"

# Manage escaping empty variables
# to ensure the ability to source
# the ENV_FILE, the process is done
# in two steps in order to have the
# env variables interpolated
env | awk -F'=' '{
    key = $1 ;
    val = $2 ;

    for (i=3; i<=NF; i++) val = val"="$i ;

    val = gensub(/"/, "\\\"", "g", val) ;
    val = gensub(/`/, "\\`", "g", val) ;

    val = "\""val"\"" ;
    print "export "key"="val ;
}' | tee "$TMP_ENV" > /dev/null

# Source temporary file overriding the current
# environment with interpolated version of
# itself, then create the main environment file

. "$TMP_ENV"

env | awk -F'=' "{ print \$1\"='\"\$2\"'\" }" | tee "$ENV_FILE" > /dev/null

# Create main command
MAIN_COMMAND=". ${ENV_FILE} && ${CRON_EXEC} ${EXEC_OPTS}"
if [ "${MAIN_COMMAND}" != *';' ]; then
    MAIN_COMMAND="${MAIN_COMMAND};"
fi

/opt/scripts/hooks-runner.sh ONSTART 1>&1 2>&2
echo

if [ $(echo "$STAGE" | egrep -i 'prod(uction)?') ]; then

    echo ${ALP_CLR} "${GREEN}Production stage, running scheduler${NOCOLOR}"
    echo
    echo ${ALP_CLR} "${BLUE}STDOUT:${NOCOLOR}"
    echo

    /opt/scripts/production-run.sh "${MAIN_COMMAND}"

else

    echo ${ALP_CLR} "${GREEN}Non production stage '${BLUE}${STAGE}${GREEN}', running once${NOCOLOR}"
    echo ${ALP_CLR} "${GREEN}evaluating the command '${BLUE}${MAIN_COMMAND}${GREEN}'${NOCOLOR}"
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

/opt/scripts/hooks-runner.sh CLEANUP 1>&1 2>&2
echo
