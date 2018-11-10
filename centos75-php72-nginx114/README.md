##使用文档
#编译
docker build -t centos75-php72-nginx114:v1.0 .

#推到dockerhub
- docker login
- docker tag [ImageId] jellywen/centos75-php72-nginx114:[镜像版本号]
- docker push jellywen/centos75-php72-nginx114:[镜像版本号]

#使用
docker run -itd -p 88:80 --name centos centos75-php72-nginx114:v1.0 bash

