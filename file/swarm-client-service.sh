#!/bin/sh
SERVICE_NAME=swarm-client
WORK_PATH=/var/jenkins
PID_PATH_NAME=/tmp/$SERVICE_NAME-pid

[ ! -d /var/log/swarm-client ] && mkdir -p /var/log/swarm-client

function start {
  echo "Starting $SERVICE_NAME ..."
  if [ ! -f $PID_PATH_NAME ]; then
    nohup $WORK_PATH/swarm-client.sh $WORK_PATH 2>> /var/log/swarm-client/err >> /var/log/swarm-client/out &
    echo $! > $PID_PATH_NAME
    echo "$SERVICE_NAME started ..."
  else
    echo "$SERVICE_NAME is already running ..."
  fi
}

function stop {
  if [ -f $PID_PATH_NAME ]; then
    PID=$(cat $PID_PATH_NAME);
    echo "$SERVICE_NAME stoping ..."
    kill $PID;
    echo "$SERVICE_NAME stopped ..."
    rm $PID_PATH_NAME
  else
    echo "$SERVICE_NAME is not running ..."
  fi
}

case $1 in
  start)
    start
  ;;
  stop)
    stop
  ;;
  restart)
    stop
    start
  ;;
esac
