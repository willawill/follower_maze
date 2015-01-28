#! /bin/bash

export logLevel='debug'
export totalEvents=2000
export numOfUsers=100
# export timeout=20000

time java -server -Xmx1G -jar ./bin/follower-maze-2.0.jar
