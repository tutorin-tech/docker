FROM alpine:3.13

ENV BRANCH master

ENV HOME /root

RUN echo https://mirror.yandex.ru/mirrors/alpine/v3.13/main/       > /etc/apk/repositories \
 && echo https://mirror.yandex.ru/mirrors/alpine/v3.13/community/ >> /etc/apk/repositories \
 && apk --update add \
    bash \
    curl \
    gcc \
    git \
    linux-headers \
    musl-dev \
    nginx \
    postgresql-client \
    postgresql-dev \
    python3-dev \
    py3-pip \
 \
 && cd /var/www \
 && git clone -b $BRANCH --depth 1 https://github.com/tutorin-tech/tit-api.git \
 \
 && cd tit-api \
 && pip3 install -r requirements.txt \
 && env SECRET_KEY=secret python3 manage.py collectstatic --noinput --link \
 \
 && curl -O https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh \
 && chmod +x wait-for-it.sh \
 \
 && apk del \
    gcc \
    git \
 && rm -rf /var/cache/apk/*

WORKDIR /var/www/tit-api

COPY tit-api/config/default.conf /etc/nginx/conf.d/default.conf

COPY tit-api/config/uwsgi.ini /var/www/tit-api/

COPY tit-api/docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
