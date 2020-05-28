#!/bin/bash

echo stop containers 
docker stop hadoop-node1
docker stop hadoop-node2
docker stop hadoop-node3

echo start containers
docker start hadoop-node1
docker start hadoop-node2
docker start hadoop-node3

sleep 5

docker exec -it hadoop-node1 /usr/sbin/sshd
docker exec -it hadoop-node2 /usr/sbin/sshd
docker exec -it hadoop-node3 /usr/sbin/sshd

sleep 5

docker exec -it hadoop-node1 /usr/local/hadoop-2.8.5/restart-hadoop.sh
docker exec -it hadoop-node1 /usr/local/spark-2.4.5-bin-hadoop2.7/sbin/start-all.sh
docker exec -it hadoop-node1 /recommendstart.sh
echo  containers started

docker ps -a


