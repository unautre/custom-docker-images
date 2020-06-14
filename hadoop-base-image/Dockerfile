FROM openjdk:8-slim

RUN apt update && apt install -y \
	g++ make \
	netcat curl \
	xmlstarlet \
	libsnappy-dev libssl-dev \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/

RUN curl https://downloads.apache.org/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz -O && \
	tar -zxvf hadoop-3.2.1.tar.gz && \
	rm -rf hadoop/share/doc && \
	ln -s hadoop-3.2.1 hadoop && \
	rm -rf hadoop-3.2.1.tar.gz

ENV HADOOP_HOME /usr/local/hadoop/
ENV HADOOP_PREFIX /usr/local/hadoop/
WORKDIR /usr/local/hadoop/

ADD entrypoint.sh functions.sh /
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
