FROM openjdk:8-slim

RUN apt update && apt install -y \
	g++ make \
	netcat curl \
	xmlstarlet \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/

RUN curl https://downloads.apache.org/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz -O && \
	tar -zxvf hadoop-3.2.1.tar.gz && \
	ln -s hadoop-3.2.1 hadoop && \
	rm -rf hadoop-3.2.1.tar.gz

WORKDIR /usr/local/hadoop/

ADD entrypoint.sh functions.sh /
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
