#!/bin/bash
# check for the presence of required software

echo "Checking for the presence of required third-party software installers ..."

declare -a files=(
"p13390677_112040_Linux-x86-64_1of7.zip"
"p13390677_112040_Linux-x86-64_2of7.zip"
)

for file in "${files[@]}"
do
	echo "Checking for the presence of $file in the software directory"
	if [ ! -f /vagrant/software/$file ]; then
		echo "ERROR! Missing third-party software: $file."
		exit 1
	fi
done

echo "All required third-party software found."