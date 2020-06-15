#!/bin/bash

. /functions.sh

configureXml HDFS_SITE /usr/local/hadoop/etc/hadoop/hdfs-site.xml
configureXml CORE_SITE /usr/local/hadoop/etc/hadoop/core-site.xml

configureXml ACCUMULO_SITE /usr/local/accumulo/conf/accumulo-site.xml

if [ ! -z "$ACCUMULO_SITE_instance_zookeeper_host" ]; then
	echo "[-] Forwarding instance.zookeeper.host to zookeepers=${ACCUMULO_SITE_instance_zookeeper_host}"
	sed -i "s/zookeepers=.*/zookeepers=${ACCUMULO_SITE_instance_zookeeper_host}/" proxy/proxy.properties
fi

if [ ! -z "$PROXY_instance_name" ]; then
	echo "[-] Setting instance=${PROXY_instance_name} in proxy/proxy.properties"
	sed -i "s/instance=.*/instance=${PROXY_instance_name}/" proxy/proxy.properties
fi

exec "$@"
