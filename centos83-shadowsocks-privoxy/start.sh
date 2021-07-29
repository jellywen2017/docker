#!/bin/sh
#########################################################################
# File Name: start.sh
# Author: jellywen
# Email:  wwenjiulong@163.com
# Version:
# Created Time: 2021/07/29
#########################################################################

#开启nginx 服务
/usr/bin/supervisord -n -c /etc/supervisord.conf
