FROM jellywen/centos7-php7-nginx:v1.0
MAINTAINER jellywen <jellywen@koudailc.com>

#自动解压
ADD node-v0.10.36-linux-x64.tar.gz /usr/
#自动解压
ADD node_modules.tar.gz /usr/lib/
#自动解压
ADD node-gyp-0.10.6.tar.gz /usr/

RUN ln -s /usr/node-v0.10.36-linux-x64/bin/node /usr/bin/node  && \
    mv /usr/lib/node_modules/node-gyp /usr/lib/node_modules/node-gyp_back  && \
    cp -R /usr/node-gyp-0.10.6 /usr/lib/node_modules/node-gyp  && \
    ln -s /usr/lib/node_modules/node-gyp/bin/node-gyp.js /usr/bin/node-gyp && \
    ln -s /usr/lib/node_modules/node-gyp/gyp/gyp /usr/bin/gyp && \

yum install -y gcc \
    gcc-c++ \
    autoconf \
    automake \
    libtool \
    make \
    cmake 

#Start
ADD start.sh /
RUN chmod +x /start.sh

#Set port
EXPOSE 80 443

#Start it
ENTRYPOINT ["/start.sh"]

#Start web server
#CMD ["/bin/bash", "/start.sh"]