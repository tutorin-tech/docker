FROM alpine:3.13

ENV BRANCH master

ENV HOME /root

COPY id_rsa "${HOME}"

COPY id_rsa.pub "${HOME}"

RUN echo https://mirror.yandex.ru/mirrors/alpine/v3.13/main/       > /etc/apk/repositories \
 && echo https://mirror.yandex.ru/mirrors/alpine/v3.13/community/ >> /etc/apk/repositories \
 && apk --update add \
    git \
    nginx \
    openssh \
 \
 && mkdir "${HOME}"/.ssh \
 && mv "${HOME}"/id_rsa "${HOME}"/.ssh \
 && mv "${HOME}"/id_rsa.pub "${HOME}"/.ssh \
 && ssh-keyscan github.com > "${HOME}"/.ssh/known_hosts \
 \
 && cd /var/www \
 && git clone -b $BRANCH --depth 1 git@github.com:tutorin-tech/tit-theme.git \
 \
 && apk del \
    git \
    openssh \
 && rm -rf /var/cache/apk/*

WORKDIR /var/www/tit-theme

COPY tit-theme/config/default.conf /etc/nginx/conf.d/default.conf

COPY tit-theme/docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
