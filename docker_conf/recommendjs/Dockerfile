FROM centos:7
MAINTAINER Zhangqx  zhangqx@ss.pku.edu.cn

LABEL Discription="hadoop base of centos7" version="1.0"

#安装必备的软件包
RUN yum -y install net-tools
RUN yum -y install which
RUN yum -y install openssh-server openssh-clients
RUN yum clean all

#添加测试文件及程序
COPY ./script/hadoop-mkdir.sh /hadoop-mkdir.sh
RUN chmod 700 /hadoop-mkdir.sh
COPY ./script/spark-test.sh /spark-test.sh
RUN chmod 700 /spark-test.sh
COPY ./tools/sparkwordcount-1.0-SNAPSHOT.jar /sparkwordcount-1.0-SNAPSHOT.jar
COPY ./tools/GoneWiththeWind.txt /GoneWiththeWind.txt
COPY ./script/installnodejs.sh /installnodejs.sh
RUN chmod 700 /installnodejs.sh
COPY ./script/recommendstart.sh /recommendstart.sh
RUN chmod 700 /recommendstart.sh
ADD ./tools/recommend.tar /usr/local/
COPY ./tools/film-recommend-1.0-SNAPSHOT.jar /film-recommend-1.0-SNAPSHOT.jar
COPY ./tools/ratings.dat /input_spark/ratings.dat

#配置SSH免密登录
RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -q -t dsa -f /etc/ssh/ssh_host_ed25519_key  -N ''
RUN ssh-keygen -f /root/.ssh/id_rsa -N ''
RUN touch /root/.ssh/authorized_keys
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN echo "root:ss123456" | chpasswd
COPY ./configs/ssh_config /etc/ssh/ssh_config

#添加JDK 增加JAVA_HOME环境变量
ADD ./tools/jdk-8u212-linux-x64.tar.gz /usr/local/
ENV JAVA_HOME /usr/local/jdk1.8.0_212/
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

#添加Hadoop并设置环境变量
ADD ./tools/hadoop-2.8.5.tar.gz /usr/local
ENV HADOOP_HOME /usr/local/hadoop-2.8.5

#添加Spark并设置环境变量
ADD ./tools/spark-2.4.5-bin-hadoop2.7.tgz /usr/local
ENV SPARK_HOME=/usr/local/spark-2.4.5-bin-hadoop2.7

#添加Pig并设置环境变量
ADD ./tools/pig-0.17.0.tar.gz /usr/local
ENV PIG_HOME=/usr/local/pig-0.17.0
ENV PIG_CLASSPATH=$HADOOP_HOME/etc/hadoop

#添加Scala并设置环境变量
ADD ./tools/scala-2.11.0-M2.tgz /usr/local
ENV SCALA_HOME=/usr/local/scala-2.11.0-M2

#添加Sqoop并设置环境变量
ADD ./tools/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz /usr/local
ENV SQOOP_HOME=/usr/local/sqoop-1.4.7.bin__hadoop-2.6.0

#将环境变量添加到系统变量中
ENV PATH $HADOOP_HOME/bin:$JAVA_HOME/bin:$PATH:$SPARK_HOME/bin:$PIG_HOME/bin:$PIG_HOME/conf:$SCALA_HOME/bin:$SQOOP_HOME/bin

#拷贝Hadoop相关的配置文件到镜像中
COPY ./configs/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh
COPY ./configs/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
COPY ./configs/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
COPY ./configs/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml
COPY ./configs/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
COPY ./configs/master $HADOOP_HOME/etc/hadoop/master
COPY ./configs/slaves $HADOOP_HOME/etc/hadoop/slaves
COPY ./script/start-hadoop.sh $HADOOP_HOME/start-hadoop.sh
COPY ./script/restart-hadoop.sh $HADOOP_HOME/restart-hadoop.sh

#拷贝spark相关的配置文件到镜像中
COPY ./configs/spark-slaves $SPARK_HOME/conf/slaves
COPY ./configs/spark-env.sh $SPARK_HOME/conf/spark-env.sh

#增加执行权限
RUN chmod 700 $HADOOP_HOME/start-hadoop.sh
RUN chmod 700 $HADOOP_HOME/restart-hadoop.sh

#创建数据目录
RUN mkdir -p /data/hadoop/dfs/data && \
    mkdir -p /data/hadoop/dfs/name && \
    mkdir -p /data/hadoop/tmp 

#开启SSH 22 端口
EXPOSE 22

#启动容器时执行的脚本文件
CMD ["/usr/sbin/sshd","-D"]

