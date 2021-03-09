# docker-simple_http - docker container running node.js http-server
Very simple yet usefull web server based on node.js http-server.
Not really meant to be used as full-fledged web server, just a utility to run when you need one.

## General info:
Wrapper script 'HTTP.sh' is provided to quickly start the service, set the port, provide location for data and stop/remove the container.  
Name of the user that has started the container is added to the container name, so it is possible to run multiple instances by different users, provided they do not share the port.
I'm very sure someone will forget to turn it off, at least you'll know who.  

## USAGE
Clone it `git clone https://github.com/marekruzicka/docker-simple_http.git`  
build it `./build.sh`  
run it `./HTTP.sh start`

### quick run with default settings:
```
user@server:/tmp# HTTP.sh start
8d0f2857c45ff97e35e66942dd3cd171b677de224d8cae0bbe6ac70c626fea51

  HTTP server is running with following settings:

        Socket: 0.0.0.0:80
        Serving directory: /tmp
```
Runs the container with default port on current directory.

### interactive run to set basic parameters:
```
user@server:/tmp# HTTP.sh start -i
Set HTTP directory [/tmp]: /srv/http
Set HTTP port [80]: 8080
3cedc6e65fd48696a490cc7e61d7aef016f771fa4ae29f912e53d752e8868ac5

  HTTP server is running with following settings:

        Listening on: 0.0.0.0:8080
        Serving directory: /srv/http
```
### manual start:
```
docker run -d --rm -p 80:80 --name simple_http \
    -v <directory>:/app/http_root \
    simple_http:latest
```

# WORK in PROGRESS

## credits:
https://www.npmjs.com/package/http-server

