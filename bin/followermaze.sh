#! /bin/bash

export logLevel='debug'
export totalEvents=1000
export numOfClients=10

time java -server -Xmx1G -jar ./bin/follower-maze-2.0.jar
