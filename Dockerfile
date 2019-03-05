FROM ubuntu:16.04

ARG PRITUNL_VERSION="1.29.1999.88"
ENV PRITUNL_VERSION=${PRITUNL_VERSION}

ARG MONGODB_VERSION="3.2"
ENV MONGODB_VERSION=${MONGODB_VERSION}

LABEL MAINTAINER="Dmitry Malinin <dmitry@malinin.com>"

COPY --chown=root:root ["docker-install.sh", "/root"]
RUN bash /root/docker-install.sh

ADD start-pritunl /bin/start-pritunl

EXPOSE 80
EXPOSE 443
EXPOSE 1194
EXPOSE 1194/udp

ENTRYPOINT ["/bin/start-pritunl"]

CMD ["/usr/bin/tail", "-f","/var/log/pritunl.log"]
