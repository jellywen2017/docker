#!/bin/sh
#########################################################################
# File Name: start.sh
# Author: jellywen
# Email:  jellywen@koudailc.com
# Version:
# Created Time: 2017/09/16
#########################################################################

DATA_DIR=/data/www

set -e
chown -R www.www $DATA_DIR

#启动crond
/usr/sbin/crond start

#开启nginx php-fpm 服务
/usr/bin/supervisord -n -c /etc/supervisord.conf
