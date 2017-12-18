ARG RUNNER=node
ARG VERSION=9
ARG FLAVOUR=stretch
ARG TAG=${VERSION}-${FLAVOUR}

FROM ${RUNNER}:${TAG}

ENV STAGE 'development'

ENV CRON_SPEC '* * * * *'
ENV CRON_EXEC 'echo "\\033[0;31mNo executable provided !" ; exit 1'
ENV EXEC_OPTS ''
ENV LOGS_PATH '/opt/app/run.log'
ENV APP_DIR   '/opt/app'

WORKDIR /opt/scripts

ADD scripts .
RUN chmod +x *
RUN ./cron-installer.sh

CMD [ "/opt/scripts/runner-cmd.sh" ]
