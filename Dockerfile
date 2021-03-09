FROM node:15-alpine3.10

# default config
#ENV HTTP_USER http_user
#ENV HTTP_PASS http_pass
ENV HTTP_PORT 80

RUN npm install --global http-server
RUN mkdir -pv /app/http_root

VOLUME /app/http_root
WORKDIR /app

EXPOSE $HTTP_PORT

CMD http-server /app/http_root --no-dotfiles --log-ip -d -i

