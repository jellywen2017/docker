FROM hhy5861/jsqb-build-php:1.0.3
MAINTAINER jellywen <jellywen@koudailc.com>

RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8
ENV LC_ALL zh_CN.utf8

# Install 日志管理工具
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - && \
    sudo apt-get install -y nodejs && \
	sudo npm install -g fis3@beta && \
	sudo npm install -g pngdefry && \
	sudo npm install -g fis3-postpackager-loader

