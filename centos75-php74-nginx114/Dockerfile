FROM centos:7.5.1804
MAINTAINER jellywen <1307553378@qq.com>

ENV NGINX_VERSION 1.14.1
ENV PHP_VERSION 7.4.21
#ENV SWOOLE_VERSION 4.2.7
ENV MONGODB_VERSION 1.5.3
ENV REDIS_VERSION 4.1.1

ADD composer.phar /usr/local/bin/composer

ADD nginx-$NGINX_VERSION.tar.gz /home/nginx-php/
ADD php-$PHP_VERSION.tar.gz /home/nginx-php/
#ADD swoole-src-$SWOOLE_VERSION.tar.gz /home/extension/
ADD mongodb-$MONGODB_VERSION.tgz /home/extension/
ADD redis-$REDIS_VERSION.tgz /home/extension/

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
    rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-13.noarch.rpm && \
    yum install -y zlib \
    zlib-devel \
    openssl \
    openssl-devel \
    pcre-devel \
    libxml2 \
    libxml2-devel \
    libcurl \
    libcurl-devel \
    libpng-devel \
    libjpeg-devel \
    freetype-devel \
    libmcrypt-devel \
    openssh-server \
    sqlite-devel \
    oniguruma-devel \
    wget \
    rsync \
    lrzsz \
    git \
    supervisor \
    python-setuptools \
    logrotate && \

# Install Other
    yum install -y vim \
    cronie \
    crontabs && \
    sed -i '/session    required   pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/crond && \

#Add user
    mkdir -p /data/{www,phpext} && \
    useradd -r -s /sbin/nologin -d /data/www -m -k no www && \

#Download nginx & php
    mkdir -p /home/nginx-php && cd $_ && \

#Make install php
    cd /home/nginx-php/php-$PHP_VERSION && \
    ./configure --prefix=/usr/local/php \
    --with-config-file-path=/usr/local/php/etc \
    --with-config-file-scan-dir=/usr/local/php/etc/php.d \
    --with-fpm-user=www \
    --with-fpm-group=www \
    --with-mcrypt=/usr/include \
    --with-mysqli \
    --with-pdo-mysql \
    --with-openssl \
    --with-gd \
    --with-iconv \
    --with-zlib \
    --with-gettext \
    --with-curl \
    --with-png-dir \
    --with-jpeg-dir \
    --with-freetype-dir \
    --with-xmlrpc \
    --with-mhash \
    --enable-fpm \
    --enable-xml \
    --enable-shmop \
    --enable-sysvsem \
    --enable-inline-optimization \
    --enable-mbregex \
    --enable-mbstring \
    --enable-ftp \
    --enable-gd-native-ttf \
    --enable-mysqlnd \
    --enable-pcntl \
    --enable-sockets \
    --enable-zip \
    --enable-soap \
    --enable-session \
    --enable-opcache \
    --enable-bcmath \
    --enable-exif \
    --enable-fileinfo \
    --disable-rpath \
    --enable-ipv6 \
    --disable-debug \
    --without-pear && \
    make -j4 && make install && \

#Install php-fpm
    cd /home/nginx-php/php-$PHP_VERSION && \
    cp php.ini-production /usr/local/php/etc/php.ini && \
    cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf && \
    cp /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf && \

#for swoole
#    cd /home/extension/swoole-src-$SWOOLE_VERSION && \
#    /usr/local/php/bin/phpize && \
#    ./configure --with-php-config=/usr/local/php/bin/php-config && \
#    make -j8 && make install && \

#Add extension mongodb
    cd /home/extension/mongodb-$MONGODB_VERSION && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make -j4 && make install && \

#Install supervisor
#    easy_install supervisor && \
    mkdir -p /var/{log/supervisor,run/{sshd,supervisord}} && \

#Add extension redis
    cd /home/extension/redis-$REDIS_VERSION && \
    /usr/local/php/bin/phpize && \
    ./configure --with-php-config=/usr/local/php/bin/php-config && \
    make -j4 && make install && \

#Make install nginx
    cd /home/nginx-php/nginx-$NGINX_VERSION && \
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
    rm -rf /home/nginx-php && \
    rm -rf /home/extension && \
    rm -rf /data/phpext && \

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

    #修复中文乱码(直接登录)
    echo "export LC_ALL=zh_CN.utf8" >> /root/.bash_profile && \

    #修复中文乱码
    localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 && \
    export LC_ALL=zh_CN.utf8 && \

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

    #php链接
    rm -rf /usr/bin/php && \
    ln -s /usr/local/php/bin/php /usr/bin/php && \
    su www -c "composer config -g repo.packagist composer https://packagist.phpcomposer.com"

#防止宽度高度不足
ENV LC_ALL zh_CN.utf8
ENV COLUMNS 204
ENV LINES 50

#Add supervisord conf
ADD supervisord.conf /etc/
ADD supervisor.d/ /etc/supervisor.d/

#Create web folder
VOLUME ["/data/www/simple","/usr/local/nginx/logs", "/usr/local/nginx/conf/ssl", "/usr/local/nginx/conf/vhost", "/usr/local/php/log", "/usr/local/php/etc/php.d"]

ADD extini/ /usr/local/php/etc/php.d/
ADD php.ini /usr/local/php/etc/php.ini
ADD www.conf /usr/local/php/etc/php-fpm.d/www.conf

#Update nginx config
ADD nginx.conf /usr/local/nginx/conf/
ADD simple/nginx-simple-server.conf /usr/local/nginx/conf/vhost/nginx-simple-server.conf
ADD extfile/logrotate.d/ /etc/logrotate.d/

ADD simple/index.php /data/www/simple/index.php
ADD simple/index.html /data/www/simple/index.html

#Start
ADD start.sh /

#Set port
EXPOSE 80 443

#Start it
ENTRYPOINT ["/start.sh"]

#Start web server
#CMD ["/bin/bash", "/start.sh"]

