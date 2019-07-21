FROM arm32v7/debian:stretch-slim
MAINTAINER chwba <22568014+chwba@users.noreply.github.com>

ENV SQUEEZE_VOL /srv/squeezebox
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV PACKAGE_VERSION_URL=http://www.mysqueezebox.com/update/?version=7.9.1&revision=1&geturl=1&os=debarm

RUN printf "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d \
    && chmod +x /usr/sbin/policy-rc.d
RUN apt-get update && apt-get -y install --no-install-recommends apt-utils
RUN apt-get update && \
	apt-get -y install curl wget faad flac lame sox libio-socket-ssl-perl tzdata && \
	apt-get clean

RUN url=$(curl "$PACKAGE_VERSION_URL") && \
	curl -Lsf -o /tmp/logitechmediaserver.deb $url && \
	apt-get update && dpkg -i /tmp/logitechmediaserver.deb && \
	rm -f /tmp/logitechmediaserver.deb && \
	apt-get clean

# This will be created by the entrypoint script.
RUN userdel squeezeboxserver

VOLUME $SQUEEZE_VOL
EXPOSE 3483 3483/udp 9000 9090

COPY entrypoint.sh /entrypoint.sh
COPY start-squeezebox.sh /start-squeezebox.sh
RUN chmod 755 /entrypoint.sh /start-squeezebox.sh
ENTRYPOINT ["/entrypoint.sh"]
