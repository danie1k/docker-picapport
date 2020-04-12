# Inspired by https://hub.docker.com/r/whatever4711/picapport
FROM alpine:3.11.5

ARG UID="1000"
ARG GID="100"
ARG WORKDIR="/home/picapport"

ARG PICAPPORTDIR=".picapport"
ARG MEM_MIN="512m"
ARG MEM_MAX="1024m"
ENV MEM_MIN $MEM_MIN
ENV MEM_MAX $MEM_MAX

RUN apk add --update --no-cache libcap openjdk8-jre tini

# https://github.com/gliderlabs/docker-alpine/issues/166
# https://serverfault.com/questions/112795/how-to-run-a-server-on-port-80-as-a-normal-user-on-linux
RUN setcap 'cap_net_bind_service=+ep' $(readlink -f /usr/bin/java)
# https://github.com/docker-library/openjdk/issues/77#issuecomment-419404172
RUN cp /usr/lib/jvm/java-1.8-openjdk/jre/lib/amd64/jli/libjli.so /lib
# https://askubuntu.com/a/725386
RUN cp /usr/lib/jvm/java-1.8-openjdk/jre/lib/amd64/server/libjvm.so /lib

# Create a user & group
RUN getent group $GID || addgroup --gid $GID --system picapport \
 && adduser --uid $UID --ingroup $(getent group $GID | cut -d: -f1) \
    --home $WORKDIR --no-create-home --shell /bin/sh \
    --disabled-password --gecos "" \
    --system picapport \
 && mkdir -p $WORKDIR/$PICAPPORTDIR

# Add required files
ADD https://www.picapport.de/download/8-2-02/picapport-headless.jar $WORKDIR/picapport-headless.jar
RUN chown -R $UID:$GID $WORKDIR

EXPOSE 80
USER picapport
VOLUME $WORKDIR/$PICAPPORTDIR
WORKDIR $WORKDIR

# http://wiki.picapport.de/display/PICE/PicApport-Server+Guide
CMD tini -- java -Xms512m -Xmx1024m -Duser.home=/home/picapport -jar /home/picapport/picapport-headless.jar
