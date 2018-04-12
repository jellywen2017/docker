FROM jellywen/centos7-php7-nginx:v1.0
MAINTAINER jellywen <jellywen@koudailc.com>

ADD node-v0.10.36-linux-x64.tar.gz /usr/local/
#运行ctp需要的库
ADD libthostmduserapi.so /usr/lib/
ADD libthosttraderapi.so /usr/lib/
ADD thostmduserapi.so /usr/lib/
ADD thosttraderapi.so /usr/lib/

RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash - && \
    yum -y install nodejs && \
    npm install forever -g && \
    ln -s /usr/lib/libthostmduserapi.so /lib64/libthostmduserapi.so && \
    ln -s /usr/lib/libthosttraderapi.so /lib64/libthosttraderapi.so && \
    ln -s /usr/lib/thostmduserapi.so /lib64/thostmduserapi.so && \
    ln -s /usr/lib/thosttraderapi.so /lib64/thosttraderapi.so 

#Start
ADD start.sh /
RUN chmod +x /start.sh

#Set port
EXPOSE 80 443

#Start it
ENTRYPOINT ["/start.sh"]

#Start web server
#CMD ["/bin/bash", "/start.sh"]