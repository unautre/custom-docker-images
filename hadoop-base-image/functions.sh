#!/bin/bash

#########################
# $1 name               #
# $2 value              #
# $3 configuration file #
#########################
setPropertyXml() {
	xmlstarlet ed -L -P \
		-s '/configuration' -t elem -n propertyTmp \
		-s '//propertyTmp' -t elem -n name -v "$1" \
		-s '//propertyTmp' -t elem -n value -v "$2" \
		-r '//propertyTmp' -v 'property' \
		$3
}

#########################
# $1 prefix             #
# $2 config file        #
#########################
configureXml(){
	echo "[-] Configuring $2"
	env | grep "^$1" | while IFS='=' read rawname value ; do
		name=$(echo ${rawname#${1}_} | sed 's/___/-/g' | sed 's/__/@/g' | sed 's/_/./g')
		echo "    [-] Setting $name to $value"
		setPropertyXml $name $value $2
	done

	mv ${2} ${2}.old
	xmlstarlet fo ${2}.old > ${2}
	rm ${2}.old
}

############################
# $1 tcp tuple to wait for #
############################
waitForIt(){
	local serviceport=$1
	local service=${serviceport%%:*}
	local port=${serviceport#*:}
	
	for((i = 0; i < 100; i++)); do
		echo "[-] Checking service ${serviceport}, try ${i}/100..."
		nc -z $service $port
		if [ $? -eq 0 ]; then
			echo "[+] ${serviceport} is available." ;
			break
		fi
		sleep 5
	done
}

for i in ${SERVICE_PRECONDITION[@]} ; do
	waitForIt ${i}
done
