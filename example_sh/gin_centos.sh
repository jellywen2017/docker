#!/bin/bash

#安装
docker run -tid -p 8001:8000 -h mdg --name mdg -v /Users/jelly/work/docker_volume/go_centos/www:/data/www jellywen/centos83-go16-nginx1201:v1.0 bash

#访问
# http://local.comsvc.cn:8001/hello

#删除
#docker rm -f mdg