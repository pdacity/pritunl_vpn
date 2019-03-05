FROM lsiobase/ubuntu:bionic
LABEL maintainer="Dmitry Malinin <dmitry@malinin.com>"

# set version label
#ARG BUILD_DATE
#ARG VERSION
#LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -yq && \
    apt-get install -yq software-properties-common apt-utils iptables && \
    echo "deb https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.0.list && \
    echo "deb http://repo.pritunl.com/stable/apt bionic main" > /etc/apt/sources.list.d/pritunl.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A && \
    apt-get --assume-yes update && \
    apt-get --assume-yes upgrade && \
    apt-get --assume-yes install pritunl mongodb-server && \
    # Cleanup
    apt-get clean -y && \
    apt-get autoremove -y && \
    rm -rfv /tmp/* /var/lib/apt/lists/* /var/tmp/* 

RUN \
    echo "* hard nofile 64000" >> /etc/security/limits.conf \
    echo "* soft nofile 64000" >> /etc/security/limits.conf \
    echo "root hard nofile 64000" >> /etc/security/limits.conf \
    echo "root soft nofile 64000" >> /etc/security/limits.conf

COPY root/ /
EXPOSE 1194 443 80
VOLUME /config
