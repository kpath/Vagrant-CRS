# check for the presence of required software
echo "Checking for the presence of required third-party software installers ..."

# map of file name to expected md5 sum
declare -a files=(
"jboss-eap-6.1.0.zip:ff56dc5dc233dc4e0e153e3cfb2ecb1c"
"jdk-7u67-linux-x64.rpm:3209c90d10ca86e5c384f3aa6ad25bba"
"OCcas11.1.0-Linux64.sh:a1dde7b809b72600ab05831ff6ed3cdb"
"OCmdex6.5.1-Linux64_829811.sh:0f01314d5671ff4becd8880b94a26a4b" 
"OCPlatform11.1.bin:5144ff7c87afb032f343c23b220e5a86"
"OCplatformservices11.1.0-Linux64.bin:11b9c29a3285f9c5db3773a759e28c29"
"OCReferenceStore11.1.bin:7feb7192519cb18713d8d4c18c441218"
"ojdbc7.jar:b74ac7e10bbdde05dd03629788be2a1d"
"p13390677_112040_Linux-x86-64_1of7.zip:1616f61789891a56eafd40de79f58f28"
"p13390677_112040_Linux-x86-64_2of7.zip:67ba1e68a4f581b305885114768443d3")

get_checksum() {
  if [ $# -ne 1 ] ; then
    echo "Usage: $0 source" >&2
    return 1
  fi

  if type md5sum >/dev/null 2>&1 ; then
    echo $(md5sum -- "$1" | awk '{print $1}')
  elif type md5 >/dev/null 2>&1 ; then
    echo $(md5 "$1" | awk '{print $4}')
  elif type openssl >/dev/null 2>&1 ; then
    echo $(openssl md5 "$1" | awk '{print $2}')
  else
  	echo "No valid checksum software found - skipping checksum verification"
  fi
}

for file in "${files[@]}"
do
	FILENAME="${file%%:*}"

	echo "Checking for the presence of a valid $FILENAME in the software directory"
	if [ ! -f /vagrant/software/$FILENAME ]; then
		echo "ERROR! Missing third-party software: $FILENAME."
		exit 1
	fi

	MD5="${file##*:}"
	CALCULATED_MD5=$(get_checksum "/vagrant/software/$FILENAME")

	if [ $MD5 != $CALCULATED_MD5 ]; then
		echo "ERROR! Third-party software $FILENAME is corrupt.  File checksum $CALCULATED_MD5 does not equal the expected checksum of $MD5"
		exit 1
	fi
done

if [ ! -f /vagrant/software/V46389-01.zip ] && [ ! -f /vagrant/software/cd/Disk1/install/runInstaller ]; then
	echo "ERROR! Missing Oracle Commerce Experience Manager Tools and Frameworks 11.1 for Linux - /vagrant/software/V46389-01.zip must be either present or expanded in the software directory"
	exit 1
fi
echo "All required third-party software found."

echo "Making sure all third-party installers are executable."
chmod -R 755 /vagrant/software/*
echo "All third-party software permissions set to 755."


