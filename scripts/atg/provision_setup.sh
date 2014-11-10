# this script runs once on provision

# verify centos release
cat /etc/centos-release

# fastestmirror plugin causes problems. just disable plugins
sed -i.bak 's/plugins=1/plugins=0/g' /etc/yum.conf

# silent install means assume yes for everything
if  ! grep -qe "^assumeyes" "/etc/yum.conf"; then
	echo "assumeyes=1" >> /etc/yum.conf
else
	sed -i.bak 's/assumeyes=0/assumeyes=1/g' /etc/yum.conf
fi

if [ ! -f /etc/oracle-release ]; then
	# convert into Oracle Linux 6
	curl -O https://linux.oracle.com/switch/centos2ol.sh
	sh centos2ol.sh; echo success
else
	echo "Already converted to Oracle Linux"
fi

# verify oracle release
cat /etc/oracle-release

# install some tools and libraries that are required
yum install -y unzip ant ant-nodeps ant-contrib libaio

# set environment variables
if  ! grep -qe "^export ENDECA_TOOLS_CONF=" "/home/vagrant/.bash_profile"; then
	echo "export JAVA_HOME=/usr/java/jdk1.7.0_72" >> /home/vagrant/.bash_profile \
	 && echo "export DYNAMO_HOME=/home/vagrant/ATG/ATG11.1/home" >> /home/vagrant/.bash_profile \
	 && echo "export JBOSS_HOME=/home/vagrant/jboss" >> /home/vagrant/.bash_profile \
	 && echo "export ATG_HOME=/home/vagrant/ATG/ATG11.1/home" >> /home/vagrant/.bash_profile \
	 && echo "export ATG_DIR=/root/ATG/ATG11.1" >> /home/vagrant/.bash_profile \
	 && echo "export JAVA_VM=/usr/java/jdk1.7.0_72/bin/java" >> /home/vagrant/.bash_profile \
	 && echo "export JAVA_ARGS=-Duser.timezone=UTC" >> /home/vagrant/.bash_profile \
	 && echo "export JAVA_OPTS=-Duser.timezone=UTC" >> /home/vagrant/.bash_profile \
	 && echo "export ENDECA_TOOLS_ROOT=/usr/local/endeca/ToolsAndFrameworks/11.1.0" >> /home/vagrant/.bash_profile \
	 && echo "export ENDECA_TOOLS_CONF=/usr/local/endeca/ToolsAndFrameworks/11.1.0/server/workspace" >> /home/vagrant/.bash_profile \
	 && echo "export PATH=/usr/java/jdk1.7.0_72/bin:$PATH" >> /home/vagrant/.bash_profile
fi

# jdk
rpm -Uvh /vagrant/software/jdk-7u72-linux-x64.rpm

# directories
mkdir -p /usr/local/endeca/Apps
chmod -R 755 /usr/local/endeca
chown -R vagrant:vagrant /usr/local/endeca

echo "setup done"