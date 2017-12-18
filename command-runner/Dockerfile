ARG RUNNER=node
ARG VERSION=9
ARG FLAVOUR=stretch
ARG TAG=${VERSION}-${FLAVOUR}

FROM ${RUNNER}:${TAG}

LABEL maintainer='Ameer A. <ameer.a@yamsafer.me>'

ENV STAGE 'development'

ENV APP_DIR   '/opt/app'
ENV CRON_SPEC '* * * * *'
ENV CRON_EXEC ''
ENV EXEC_OPTS ''

ENV ENV_FILE  '/etc/environment'
ENV WRITE_ENV 'true'

WORKDIR /opt/scripts

ADD scripts .
RUN chmod +x *
RUN ./cron-installer.sh

CMD [ "/opt/scripts/runner-cmd.sh" ]
