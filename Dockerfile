FROM node:15-alpine3.10

ENV HTTP_PORT=80

RUN npm install --global http-server
RUN mkdir -p /app/http_root

VOLUME /app/http_root
WORKDIR /app

EXPOSE $HTTP_PORT

CMD http-server /app/http_root -p $HTTP_PORT --no-dotfiles --log-ip -c-1

