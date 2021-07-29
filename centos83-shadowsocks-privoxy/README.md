## 使用文档
# 编译
docker build -t centos83-shadowsocks-privoxy:v1.0 .

# 推到dockerhub
- docker login
- docker tag [ImageId] jellywen/centos83-shadowsocks-privoxy:[镜像版本号]
- docker push jellywen/centos83-shadowsocks-privoxy:[镜像版本号]

# build机器上使用
- docker run -itd -p 8118:8118 -h ssp --name ssp --env S_SERVER_IP="47.241.67.116" --env S_PASSWORD="密码" centos83-shadowsocks-privoxy:v1.0 bash

# 非build机器上使用
- docker run -itd -p 8118:8118 -h ssp --name ssp --env S_SERVER_IP="47.241.67.116" --env S_PASSWORD="密码" jellywen/centos83-shadowsocks-privoxy:v1.0 bash

# 使用的地方设置代理
export http_proxy=http://本容器运行的宿主机ip地址:8118
export https_proxy=http://本容器运行的宿主机ip地址:8118
export ftp_proxy=http://本容器运行的宿主机ip地址:8118
##例如：
export http_proxy=http://192.168.1.5:8118;export https_proxy=http://192.168.1.5:8118;

#测试
curl cip.cc
#正常打印如下
IP	: 47.241.67.116
地址	: 中国  香港  阿里云

数据二	: 新加坡 | 阿里云

数据三	: 新加坡 | 阿里云

URL	: http://www.cip.cc/47.241.67.116

