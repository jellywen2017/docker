##使用文档
#编译
docker build -t centos75-php72-nginx114:v1.0 .

#使用
docker run -itd -p 88:80 --name centos bash