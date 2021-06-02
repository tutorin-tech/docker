FROM alpine:3.13

ENV BRANCH master

ENV HOME /root

COPY id_rsa "${HOME}"

COPY id_rsa.pub "${HOME}"

RUN echo https://mirror.yandex.ru/mirrors/alpine/v3.13/main/       > /etc/apk/repositories \
 && echo https://mirror.yandex.ru/mirrors/alpine/v3.13/community/ >> /etc/apk/repositories \
 && apk --update add \
    gcc \
    git \
    musl-dev \
    openssh \
    python3-dev \
    py3-pip \
 \
 && mkdir "${HOME}"/.ssh \
 && mv "${HOME}"/id_rsa "${HOME}"/.ssh \
 && mv "${HOME}"/id_rsa.pub "${HOME}"/.ssh \
 && ssh-keyscan github.com > "${HOME}"/.ssh/known_hosts \
 \
 && mkdir /var/www \
 && cd /var/www \
 && git clone -b $BRANCH --depth 1 git@github.com:tutorin-tech/tit-rpc-server.git \
 \
 && cd tit-rpc-server \
 && pip3 install -r requirements.txt \
 \
 && apk del \
    gcc \
    git \
 && rm -rf /var/cache/apk/*

WORKDIR /var/www/tit-rpc-server

COPY tit-rpc-server/docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
