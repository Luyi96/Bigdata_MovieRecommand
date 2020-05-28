#!/bin/bash
spark-submit --master spark://172.18.0.2:7077 --class com.bolingcavalry.sparkwordcount.WordCount --executor-memory 512m --total-executor-cores 1 /sparkwordcount-1.0-SNAPSHOT.jar 172.18.0.2 9000 GoneWiththeWind.txt

