#!/bin/sh
WORK_PATH=$1
java -Xmx8g -Xms8g -XX:+UseG1GC \
    -jar $WORK_PATH/swarm-client.jar \
    -master https://jenkins.hcqis.org/hqr-master/ \
    -username le8023 \
    -passwordFile $WORK_PATH/jenkins-token \
    -labelsFile $WORK_PATH/jenkins-labels \
    -e no_proxy=127.0.0.1,localhost \
    -e PATH+LOCAL_BIN=/usr/local/bin:/usr/local/go/bin \
    -e GOPATH=/root/go \
    -e GOCACHE=/root/.cache/go-build \
    -e GOENV=/root/.config/go/env \
    -executors 2 \
    -webSocket \
    -retry 5
