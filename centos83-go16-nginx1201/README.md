## 使用文档
# 编译
docker build -t centos83-go16-nginx1201:v1.0 .

# 推到dockerhub
- docker login
- docker tag [ImageId] jellywen/centos83-go16-nginx1201:[镜像版本号]
- docker push jellywen/centos83-go16-nginx1201:[镜像版本号]

# build机器上使用
- docker run -itd -p 80:8000 -h cgo --name cgo centos83-go16-nginx1201:v1.0 bash

# 非build机器上使用
- docker run -itd -p 80:8000 -h cgo --name cgo jellywen/centos83-go16-nginx1201:v1.0 bash

# 本地访问
- http://localhost:80/hello

