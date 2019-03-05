# Pritunl + Docker + LinuxServer.io = <3

## Pull the image

    docker pull bashninja/docker-pritunl

## Run Pritunl

    docker run -d --privileged \
        -v {path}:/config \
        -p 1194:1194/udp \
        -p 1194:1194/tcp \
        -p 9700:443/tcp \
        -p 9699:80/tcp \
        --name Pritunl \
        bashninja/docker-pritunl

## Configure Pritunl

* Open https://`youripaddress`:9700
* Get your default creds (run on docker host via a shell): `docker exec -it Pritunl pritunl default-password`
* Fun