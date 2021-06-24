FROM alpine:3.13

ENV BRANCH master

ENV HOME /root

RUN echo https://mirror.yandex.ru/mirrors/alpine/v3.13/main/       > /etc/apk/repositories \
 && echo https://mirror.yandex.ru/mirrors/alpine/v3.13/community/ >> /etc/apk/repositories \
 && apk --update add \
    gcc \
    git \
    linux-headers \
    musl-dev \
    py3-pip \
    python3-dev \
 \
 && mkdir /var/www \
 && cd /var/www \
 && git clone -b $BRANCH --depth 1 https://github.com/tutorin-tech/tit-landing.git \
 \
 && adduser --disabled-password --home /var/www www-data \
 && chown -R www-data:www-data /var/www \
 \
 && cd tit-landing \
 && pip3 install -r requirements.txt \
 \
 && apk del \
    gcc \
    git \
 && rm -rf /var/cache/apk/*

USER www-data

WORKDIR /var/www/tit-landing

COPY tit-landing/config/uwsgi.ini  /var/www/tit-landing/uwsgi.ini

COPY tit-landing/docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
