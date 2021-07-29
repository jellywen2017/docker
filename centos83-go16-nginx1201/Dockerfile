FROM centos:8.3.2011
MAINTAINER jellywen <1307553378@qq.com>

ENV NGINX_VERSION 1.20.1
ENV GO_VERSION 1.16.6.linux-amd64
#防止宽度高度不足
ENV LC_ALL zh_CN.utf8
ENV COLUMNS 204
ENV LINES 50
#修复中文乱码(直接登录) 使用 export 不生效
ENV LC_ALL=zh_CN.utf8
#go环境变量
ENV GOROOT=/usr/local/go
ENV PATH=$PATH:$GOROOT/bin

#Create web folder
VOLUME ["/data/www/simple","/usr/local/nginx/logs", "/usr/local/nginx/conf/ssl", "/usr/local/nginx/conf/vhost"]

ADD nginx-$NGINX_VERSION.tar.gz /home/temp/
ADD go$GO_VERSION.tar.gz /usr/local/
#Add supervisord conf
ADD supervisord.conf /etc/
ADD supervisor.d/ /etc/supervisor.d/
#Update nginx config
ADD nginx.conf /usr/local/nginx/conf/
ADD simple/nginx-simple-server.conf /usr/local/nginx/conf/vhost/nginx-simple-server.conf
ADD extfile/logrotate.d/ /etc/logrotate.d/
#go test file
ADD simple/main.go /data/www/simple/main.go
#Start
ADD start.sh /

RUN set -x && \
    yum install -y gcc \
    gcc-c++ \
    autoconf \
    automake \
    libtool \
    make \
    cmake && \

#Install PHP library
## libmcrypt-devel DIY
    rpm -ivh https://dl.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/e/epel-release-8-11.el8.noarch.rpm && \
    yum install -y epel-release \
    zlib \
    zlib-devel \
    glibc-locale-source \
    glibc-langpack-en \
    openssl \
    openssl-devel \
    pcre-devel \
    openssh-server \
    wget \
    rsync \
    lrzsz \
    git \
    python3-setuptools \
    supervisor \
    logrotate && \

# Install Other
    yum install -y vim \
    cronie \
    crontabs && \
    sed -i '/session    required   pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/crond && \

#Add user
    mkdir -p /data/{www/simple,phpext} && \
    useradd -r -s /sbin/nologin -d /data/www -m -k no www && \

#Download nginx & php
    mkdir -p /home/temp && cd $_ && \

#Install supervisor
#    easy_install supervisor && \
    mkdir -p /var/{log/supervisor,run/{sshd,supervisord}} && \

#Change Mod from webdir
    chown -R www:www /data/www && \
    mkdir -p /data/logs && \
    chown -R www:www /data/logs && \
    mkdir -p /home/www/.ssh && \
    chmod 700 /home/www/.ssh && \
    chown -R www:www /home/www && \

    #启用www用户
    usermod -s /bin/bash www && \
    #修改www的主目录
    usermod -d /home/www www && \

    #使用alias
    echo -e '#!/bin/bash\nls -al' > /usr/bin/ll && \
    chmod +x /usr/bin/ll && \

    #修复中文乱码
    localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 && \
    #校准时间
    \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \

    #防止提示
    rm -rf /etc/ssh/ssh_host_rsa_key && \
    rm -rf /etc/ssh/ssh_host_ecdsa_key && \
    rm -rf /etc/ssh/ssh_host_ed25519_key && \
    ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' && \
    ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' && \
    ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N '' && \
    /usr/sbin/sshd && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \

#下载gin框架
    cd /data/www/simple/ && \
    go env -w GOPATH=/data/go && \
    go env -w GO111MODULE=on && \
    go env -w GOPROXY=https://goproxy.cn,direct && \
#初始化测试项目
    go mod init github.com/jellywen/simple && \
#先初始化 再下载依赖
    go get -u github.com/gin-gonic/gin && \

#Make install nginx
    cd /home/temp/nginx-$NGINX_VERSION && \
    ./configure --prefix=/usr/local/nginx \
    --user=www --group=www \
    --error-log-path=/var/log/nginx_error.log \
    --http-log-path=/var/log/nginx_access.log \
    --pid-path=/var/run/nginx.pid \
    --with-pcre \
    --with-http_ssl_module \
    --without-mail_pop3_module \
    --without-mail_imap_module \
    --with-http_gzip_static_module && \
    make -j4 && make install && \

#Clean OS
    yum remove -y gcc \
    gcc-c++ \
    autoconf \
    automake \
    libtool \
    make \
    cmake && \
    yum clean all && \
    rm -rf /tmp/* /var/cache/{yum,ldconfig} /etc/my.cnf{,.d} && \
    mkdir -p --mode=0755 /var/cache/{yum,ldconfig} && \
    find /var/log -type f -delete && \
    rm -rf /home/temp && \
    rm -rf /home/extension && \
    rm -rf /data/phpext

#Set port
EXPOSE 80 443

#Start it
ENTRYPOINT ["/start.sh"]

#Start web server
#CMD ["/bin/bash", "/start.sh"]

