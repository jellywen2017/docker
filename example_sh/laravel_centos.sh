#!/bin/bash

#安装
docker run -tid -p 8002:80 -h mdl --name mdl -v /Users/jelly/work/docker_volume/laravel_centos/www:/data/www jellywen/centos75-php74-nginx114-node14:v1.0 bash

#访问
# http://local.comsvc.cn:8002

#删除
#docker rm -f mdl