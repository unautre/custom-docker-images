FROM unautre/hadoop-base-image

WORKDIR /usr/local/

RUN curl https://downloads.apache.org/zookeeper/zookeeper-3.6.1/apache-zookeeper-3.6.1-bin.tar.gz -O && \
	tar -zxvf apache-zookeeper-3.6.1-bin.tar.gz && \
	ln -s apache-zookeeper-3.6.1-bin zookeeper && \
	rm -rf apache-zookeeper-3.6.1-bin.tar.gz
ENV ZOOKEEPER_HOME /usr/local/zookeeper/

RUN curl https://downloads.apache.org/accumulo/1.9.3/accumulo-1.9.3-bin.tar.gz -O && \
	tar -zxvf accumulo-1.9.3-bin.tar.gz && \
	ln -s accumulo-1.9.3 accumulo && \
	rm -rf accumulo-1.9.3-bin.tar.gz
ENV ACCUMULO_HOME /usr/local/accumulo/
WORKDIR /usr/local/accumulo/

RUN bin/build_native_library.sh && \
	bin/bootstrap_config.sh -s 2GB -v 3 -n -o && \
	curl https://repo1.maven.org/maven2/commons-lang/commons-lang/2.6/commons-lang-2.6.jar -O && \
	mv commons-lang-2.6.jar $HADOOP_PREFIX/share/hadoop/common/lib/ && \
	xmlstarlet ed -L -P \
		-s '/configuration/property[./name/text()="general.classpaths"]/value' \
			-t text -n jars -v '$HADOOP_PREFIX/share/hadoop/common/lib/[^.].*.jar' \
			conf/accumulo-site.xml

ADD entrypoint.sh /
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
