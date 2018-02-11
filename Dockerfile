# -----------------------------------------------------------------------------
# docker-tvheadend
#
#
# Based on: tobbenb (https://registry.hub.docker.com/u/tobbenb/tvheadend-unstable/)
# Updated: 03.02.2015
# Require: Docker (http://www.docker.io/)
# -----------------------------------------------------------------------------

FROM debian:jessie-slim
MAINTAINER Mathieu Ruellan <mathieu.ruellan@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /


RUN \
	apt-get update -y && \
	apt-get install -y gnupg2 gnupg && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61
RUN echo deb http://dl.bintray.com/tvheadend/ubuntu stable main | tee -a /etc/apt/sources.list

RUN echo deb http://ftp.fr.debian.org/debian/ stable main contrib non-free | tee -a /etc/apt/sources.list
RUN echo deb http://ftp.fr.debian.org/debian/ testing main contrib non-free | tee -a /etc/apt/sources.list
RUN echo deb http://ftp.fr.debian.org/debian/ unstable main contrib non-free | tee -a /etc/apt/sources.list
RUN echo deb http://security.debian.org/debian-security testing/updates main | tee -a /etc/apt/sources.list


RUN \
	apt-get update -y && \
	apt-get install -y xmltv xmltv-util udev bzip2 && \
	apt-get install -y --force-yes tvheadend && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ADD tv_grab_fr_telerama /usr/bin/tv_grab_fr
RUN chmod a+x /usr/bin/tv_grab_fr

EXPOSE 9981 9982

VOLUME /config
VOLUME /recordings
VOLUME /data
VOLUME /logos
VOLUME /timeshift
VOLUME /.xmltv

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh
