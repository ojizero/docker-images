ARG RUNNER=node
ARG VERSION=9
ARG FLAVOUR=alpine
ARG TAG=${VERSION}-${FLAVOUR}

FROM ${RUNNER}:${TAG}

ENV STAGE 'development'

ENV CRON_SPEC '* * * * *'
ENV CRON_EXEC ''
ENV EXEC_OPTS ''
ENV LOGS_PATH '/opt/app/run.log'

WORKDIR /opt/scripts

ADD scripts .
RUN chmod +x *
RUN ./cron-installer.sh

CMD [ "/opt/scripts/runner-cmd.sh" ]
