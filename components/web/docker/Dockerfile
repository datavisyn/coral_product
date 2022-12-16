ARG DATAVISYN_NGINX_BASE_IMAGE
FROM ${DATAVISYN_NGINX_BASE_IMAGE}

ENV TDP_ICNATIVEWS_SERVER=_ic_nativews:8080 \
    TDP_ICFSECLIENT_SERVER=_icfse_client:8090 \
    TDP_MARVINJS_SERVER=_marvinjs:8095 \
    # Real address of the ES index. Will be passed as Host header as a forward proxy might not set it correctly.
    ELASTICSEARCH_HOST="0...eu-central-1.aws.cloud.es.io" \
    # Real address of the ES index or proxy url.
    ELASTICSEARCH_URL="http://localhost" \
    ELASTICSEARCH_AUTHORIZATION="Basic ..." \
    ES_CACHE_DIRECTORY=/app/visyn/tmp/es_cache \
    ES_CACHE_MAX_SIZE=50g

COPY ./bundles /app/visyn/html
COPY ./docker/server.conf.template /app/visyn/templates/