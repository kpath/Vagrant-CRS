#!/bin/bash

mkdir -p /vagrant/software/db11g
unzip -n /vagrant/software/p13390677_112040_Linux-x86-64_1of7.zip -d /vagrant/software/db11g
unzip -n /vagrant/software/p13390677_112040_Linux-x86-64_2of7.zip -d /vagrant/software/db11g
chown -R oracle.oinstall /vagrant/software/db11g

# run this part as oracle
exec sudo -u oracle /bin/bash -l << eof
	/vagrant/software/db11g/database/runInstaller -waitforcompletion -silent -ignorePrereq -responseFile /vagrant/scripts/db11g/db_install.rsp 
eof