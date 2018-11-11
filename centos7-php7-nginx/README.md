## 使用文档
# 编译
- docker build -t centos7-php7-nginx:v1.1 .

# 使用
- docker run -itd -p 88:80 --name centos centos7-php7-nginx:v1.1 bash