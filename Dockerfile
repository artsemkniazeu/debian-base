 
FROM debian:10

LABEL maintainer="artsem.kniazeu@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm \
    container=docker

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install sudo supervisor rsyslog  \
    	wget curl unzip nano rsync tar git \
    	python3 \
    	apt-transport-https apt-utils software-properties-common ca-certificates build-essential  \
    && apt-get clean \
    && mkdir /install

COPY ./install/systemctl /usr/local/bin/systemctl
COPY ./install/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./install/init /usr/local/bin/init

    # systemctl replacing 
RUN wget https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py \
    -O /usr/local/bin/systemctl-replacement \
    && chmod +x /usr/local/bin/systemctl-replacement \
	&& chmod +x /usr/local/bin/systemctl

    # supervisor
RUN mkdir -p /supervisor/log \

    # custom init.d
    && mkdir -p /etc/my_init.d

CMD ["/usr/bin/supervisord"]