## 使用文档
# 编译
docker build -t centos75-php74-nginx114:v1.0 .

# 推到dockerhub
- docker login
- docker tag [ImageId] jellywen/centos75-php74-nginx114:[镜像版本号]
- docker push jellywen/centos75-php74-nginx114:[镜像版本号]

# build机器上使用
- docker run -itd -p 88:80 --name centos centos75-php74-nginx114:v1.0 bash

# 非build机器上使用
- docker run -itd -p 88:80 --name centos jellywen/centos75-php74-nginx114:v1.0 bash

# 本地访问
- http://localhost:88
- http://localhost:88/index.php
- http://localhost:88/index.html

