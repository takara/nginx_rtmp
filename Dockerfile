FROM centos:centos7

MAINTAINER takara

WORKDIR /root

RUN yum -y update

RUN systemctl disable getty@tty1.service
RUN yum install -y wget gcc pcre-devel openssl openssl-devel git
RUN yum install -y epel-release
RUN rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
RUN rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm

RUN mkdir -p /root/storeaming
WORKDIR /root/storeaming

RUN git clone https://github.com/arut/nginx-rtmp-module.git

RUN wget http://nginx.org/download/nginx-1.14.0.tar.gz && \
    tar zxf nginx-1.14.0.tar.gz && \
    rm -rf nginx-1.14.0.tar.gz

WORKDIR /root/storeaming/nginx-1.14.0/
RUN ./configure --add-module=/root/storeaming/nginx-rtmp-module && \
    make install

RUN yum install -y ffmpeg

RUN mkdir -p /usr/local/nginx/html/movie && \
    chown nobody /usr/local/nginx/html/movie

COPY asset/nginx.conf /usr/local/nginx/conf/
COPY asset/nginx.service /usr/lib/systemd/system/
RUN systemctl enable nginx

ADD asset/html/* /usr/local/nginx/html/

EXPOSE 80
EXPOSE 1935

CMD ["/sbin/init"]
