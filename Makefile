NAME=nginx_rtmp
VERSION=v1.0
DOCKER_RUN_OPTIONS= \
	--privileged \
	--net=docker-lan \
	--ip=192.168.100.104 \
	-v `pwd`/movie:/usr/local/nginx/html/movie

#	-p 80:80 \
	-p 1935:1935 \


include docker.mk
