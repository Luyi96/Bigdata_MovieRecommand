export SPARK_HOME=/usr/local/spark-2.4.5-bin-hadoop2.7
export JAVA_HOME=/usr/local/jdk1.8.0_212
export HADOOP_HOME=/usr/local/hadoop-2.8.5
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export SPARK_LIBARY_PATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$HADOOP_HOME/lib/native
export SPAR_MASTER_PORT=7077
export SPARK_MASTER_HOST=hadoop-node1
