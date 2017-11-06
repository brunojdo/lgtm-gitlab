FROM alpine:3.5

ENV LGTM_VERSION=0.1.0
ENV LGTM_BINARY=lgtm-alpine-linux-amd64-v$LGTM_VERSION.tar.gz

COPY ${LGTM_BINARY} /

RUN apk add --no-cache --virtual .build_deps ca-certificates && \
    cd / && \
    tar -zxvf ${LGTM_BINARY} && \
    chmod +x lgtm && \
    mkdir /var/lib/lgtm && \
    rm -rf /var/cache/* && \
    rm -rf /tmp/*

ENV LGTM_NOTE=LGTM \
    LGTM_COUNT=1 \
    LGTM_PORT=8989 \
    LGTM_TOKEN= \
    LGTM_GITLAB_URL=http://git.epol.splab.ufcg.edu.br \
    LGTM_DB_PATH=/var/lib/lgtm/lgtm.data \
    LGTM_LOG_LEVEL=info

VOLUME /var/lib/lgtm

CMD ["sh", "-c",\
    "/lgtm -gitlab_url $LGTM_GITLAB_URL -token $LGTM_TOKEN -lgtm_count $LGTM_COUNT -lgtm_note $LGTM_NOTE -log_level $LGTM_LOG_LEVEL -db_path $LGTM_DB_PATH -port $LGTM_PORT"\
]

