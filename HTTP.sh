#!/bin/bash


help() {
        echo -e "
  `basename $0` is used to manage HTTP server (running in docker container).
  You can start the container directly using docker CLI, but why would you?\n
\tUSAGE:\n\033[1m\t\t`basename $0` [ option ] [ <parameter> ] \033[0m\n
\t<options>
\t\t-h | --help | help | ?\tDisplay this help
\t\tstart [-i]\t\tStart simple_http.
\t\tstop [ all | <name> ]\tStop yours|all|particular instance.
\t\tstatus\t\t\tList current simple_http instances. (running and stopped).\n

\tEXAMPLES:
\033[1m\t\t`basename $0` start\033[0m
\t\t  Start HTTP server serving current directory\n
\033[1m\t\t`basename $0` start -i\033[0m
\t\t  Start HTTP server in interactive mode
\t\t  It will ask you to set port/dirctory\n
\033[1m\t\t`basename $0` status\033[0m
\t\t  Show running simple_http instances (filtered docker ps)\n
\033[1m\t\t`basename $0` stop\033[0m
\t\t  Stop and remove your simple_http instance\n
\033[1m\t\t`basename $0` stop <name>\033[0m
\t\t  Stop and remove provided simple_http instance
\t\t  Use `basename $0` status to get names\n
\033[1m\t\t`basename $0` stop all\033[0m
\t\t  Stop and remove all simple_http instances\n

Use https://github.com/marekruzicka/docker-simple_http to report bugs, or check for updates.
"
}


settings() {
  read -p "Set HTTP directory [$PWD]: " HTTP_DIR
  read -p "Set HTTP port [80]: " HTTP_PORT
}

show_settings() {
  echo -e "
  HTTP server is running with following settings:\n
\tListening on: 0.0.0.0:$HTTP_PORT
\tServing directory: $HTTP_DIR
"
}

start() {
  if [[ $1 == '-i' ]]; then
    shift
    settings
  fi

  # defaults
  HTTP_PORT=${HTTP_PORT:-80}
  HTTP_DIR=${HTTP_DIR:-$PWD}


  if [[ $# -eq 0 ]]; then
    docker run -d --rm -p $HTTP_PORT:80 -v $HTTP_DIR:/app/http_root --name simple_http-$USER \
        simple_http:latest \
        && show_settings
  else
    echo -e "\n\tERROR: $@ unsupported parameters\n"
  fi
}

stop() {
  if [[ $# -eq 0 ]]; then
    echo -e "\n  Stopping and removing your own simple_http instance\n"
    docker stop simple_http-$USER
  elif
    [[ $1 -eq all ]]; then
    echo -e "\n  Stopping and removing all simple_http instances\n"
    docker ps -aq --filter "name=simple_http-" | xargs docker stop
  else
    echo -e "\n  Stopping and removing container(s): $@\n" 
    docker stop $@
  fi
}


status() {
  docker ps -a --filter "name=simple_http-"
}


case $1 in
  help | -h | --help | "" | '?')
    help
    exit 0;;
  start)
    shift
    start $@;;
  stop)
    shift
    stop $@;;
  status)
    status;;
esac

