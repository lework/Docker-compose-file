FROM node:12-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && npm install -g yapi-cli --registry https://registry.npm.taobao.org

EXPOSE 3000 9090
