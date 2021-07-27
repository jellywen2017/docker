FROM jellywen/centos75-php74-nginx114:v1.3
MAINTAINER jellywen <wwenjiulong@163.com>

ENV NODE_VERSION v14.17.3
ENV DISTRO linux-x64
#将nodej 加入环境变量
ENV PATH "/usr/local/lib/nodejs/node-$NODE_VERSION-$DISTRO/bin:$PATH"

ADD node-$NODE_VERSION-$DISTRO.tar.xz /usr/local/lib/nodejs/
#Start
ADD start.sh /

RUN chmod +x /start.sh

#Set port
EXPOSE 80 443

#Start it
ENTRYPOINT ["/start.sh"]

#Start web server
#CMD ["/bin/bash", "/start.sh"]