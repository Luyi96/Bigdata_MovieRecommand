#!/bin/bash
docker build -t="mysql:5.7" .
docker run -p 3306:3306 --name mysql5.7 -e MYSQL_ROOT_PASSWORD=123456 -d mysql:5.7
docker cp setupstart.sh mysql5.7:/mysql/setup.sh