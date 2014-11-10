#!/bin/bash
# check for the presence of required software

echo "Checking for the presence of required third-party software installers ..."

declare -a files=(
"jboss-eap-6.1.0.zip"
"jdk-7u72-linux-x64.rpm"
"OCPlatform11.1.bin"
"ojdbc7.jar"
"OCcas11.1.0-Linux64.sh"
"OCmdex6.5.1-Linux64_829811.sh"
"OCplatformservices11.1.0-Linux64.bin"
)

for file in "${files[@]}"
do
	echo "Checking for the presence of $file in the software directory"
	if [ ! -f /vagrant/software/$file ]; then
		echo "ERROR! Missing third-party software: $file."
		exit 1
	fi
done

if [ ! -f /vagrant/software/V46389-01.zip ] && [ ! -f /vagrant/software/cd/Disk1/install/runInstaller ]; then
	echo "ERROR! Missing Oracle Commerce Experience Manager Tools and Frameworks 11.1 for Linux - V46389-01.zip must be either present or expanded to in the software directory"
	exit 1
fi

echo "All required third-party software found."