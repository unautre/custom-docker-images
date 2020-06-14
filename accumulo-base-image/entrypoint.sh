#!/bin/bash

. /functions.sh

configureXml HDFS_SITE /usr/local/hadoop/etc/hadoop/hdfs-site.xml
configureXml CORE_SITE /usr/local/hadoop/etc/hadoop/core-site.xml

configureXml ACCUMULO_SITE /usr/local/accumulo/conf/accumulo-site.xml

exec "$@"
