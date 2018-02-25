ARG RUNNER=node
ARG VERSION=9
ARG FLAVOUR=alpine
ARG TAG=${VERSION}-${FLAVOUR}

FROM ${RUNNER}:${TAG}

LABEL maintainer='Ameer A. <ameer.a@yamsafer.me>'

USER root

ENV STAGE    'development'
ENV NODE_ENV ${STAGE}

ENV APP_DIR  '/opt/app'
ENV APP_USER 'root'

ENV CRON_SPEC '* * * * *'
ENV CRON_EXEC ''
ENV EXEC_OPTS ''

ENV ENV_FILE  '${APP_DIR}/.env'

ENV TERM 'xterm-256color'

WORKDIR /opt/scripts

ADD scripts .
RUN chmod +x *
RUN ./cron-installer.sh

USER ${APP_USER}
WORKDIR ${APP_DIR}

CMD [ "/opt/scripts/runner-cmd.sh" ]
