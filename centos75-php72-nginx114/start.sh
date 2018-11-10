#!/bin/sh
#########################################################################
# File Name: start.sh
# Author: jellywen
# Email:  jellywen@koudailc.com
# Version:
# Created Time: 2017/09/16
#########################################################################

Nginx_Install_Dir=/usr/local/nginx
DATA_DIR=/data/www

set -e
chown -R www.www $DATA_DIR

if [[ -n "$PROXY_WEB" ]]; then

    [ -f "${Nginx_Install_Dir}/conf/ssl" ] || mkdir -p $Nginx_Install_Dir/conf/ssl
    [ -f "${Nginx_Install_Dir}/conf/vhost" ] || mkdir -p $Nginx_Install_Dir/conf/vhost

    if [ -z "$PROXY_DOMAIN" ]; then
            echo >&2 'error:  missing PROXY_DOMAIN'
            echo >&2 '  Did you forget to add -e PROXY_DOMAIN=... ?'
            exit 1
    fi

    if [ -z "$PROXY_CRT" ]; then
         echo >&2 'error:  missing PROXY_CRT'
         echo >&2 '  Did you forget to add -e PROXY_CRT=... ?'
         exit 1
     fi

     if [ -z "$PROXY_KEY" ]; then
             echo >&2 'error:  missing PROXY_KEY'
             echo >&2 '  Did you forget to add -e PROXY_KEY=... ?'
             exit 1
     fi

     if [ ! -f "${Nginx_Install_Dir}/conf/ssl/${PROXY_CRT}" ]; then
             echo >&2 'error:  missing PROXY_CRT'
             echo >&2 "  You need to put ${PROXY_CRT} in ssl directory"
             exit 1
     fi

     if [ ! -f "${Nginx_Install_Dir}/conf/ssl/${PROXY_KEY}" ]; then
             echo >&2 'error:  missing PROXY_CSR'
             echo >&2 "  You need to put ${PROXY_KEY} in ssl directory"
             exit 1
     fi

fi

#启动crond
/usr/sbin/crond start

#开启nginx php-fpm 服务
/usr/bin/supervisord -n -c /etc/supervisord.conf
