FROM debian:8.7

MAINTAINER takara

WORKDIR /root

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt-get -y install net-tools git make apache2 vim curl chkconfig gcc libpcre3-dev unzip locales
ENV DEBIAN_FRONTEND dialog

# tty停止
COPY asset/ttystop /etc/init.d/
RUN chkconfig --add ttystop
RUN chkconfig ttystop on

RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8



EXPOSE 80

CMD ["/sbin/init", "3"]
