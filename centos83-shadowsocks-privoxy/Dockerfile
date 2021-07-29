FROM centos:8.3.2011
MAINTAINER jellywen <1307553378@qq.com>

#shadowsocks环境变量
#加密方式
ENV S_METHOD chacha20
#服务器端口
ENV S_SERVER_PORT 100

#Add supervisord conf
ADD supervisord.conf /etc/
ADD supervisor.d/ /etc/supervisor.d/
COPY epel-release-8-11.el8.noarch.rpm /tmp/

ADD config /etc/privoxy/
#Start
ADD start.sh /

RUN set -x && \
    rpm -ivh /tmp/epel-release-8-11.el8.noarch.rpm && \
    yum install -y epel-release \
    libsodium.x86_64 \
    privoxy.x86_64 \
    python3-setuptools \
    supervisor && \
    pip3 install shadowsocks && \

    #Install supervisor
    mkdir -p /var/{log/supervisor,run/{sshd,supervisord}} && \

    #使用alias
    echo -e '#!/bin/bash\nls -al' > /usr/bin/ll && \
    chmod +x /usr/bin/ll && \

#Clean OS
    yum clean all && \
    rm -rf /tmp/* /var/cache/{yum,ldconfig} /etc/my.cnf{,.d} && \
    mkdir -p --mode=0755 /var/cache/{yum,ldconfig} && \
    find /var/log -type f -delete

#Set port
EXPOSE 8118

#Start it
ENTRYPOINT ["/start.sh"]

#Start web server
#CMD ["/bin/bash", "/start.sh"]

