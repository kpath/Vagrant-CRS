# check for the presence of required software

echo "Checking for the presence of required third-party software installers ..."

declare -a files=(
"jboss-eap-6.1.0.zip"
"jdk-7u67-linux-x64.rpm"
"OCcas11.1.0-Linux64.sh"
"OCmdex6.5.1-Linux64_829811.sh" 
"OCPlatform11.1.bin"
"OCplatformservices11.1.0-Linux64.bin"
"OCReferenceStore11.1.bin"
"ojdbc7.jar"
"p13390677_112040_Linux-x86-64_1of7.zip"
"p13390677_112040_Linux-x86-64_2of7.zip"
"V46389-01.zip")

for file in "${files[@]}"
do
	echo "Checking for the presence of $file in the software directory"
	if [ ! -f /vagrant/software/$file ]; then
		echo "Missing third-party software: $file."
		exit 1
	fi
done

echo "All required third-party software found."