#!/bin/bash

mkdir -p /vagrant/software/db12c
unzip -n /vagrant/software/linuxamd64_12102_database_1of2.zip -d /vagrant/software/db12c
unzip -n /vagrant/software/linuxamd64_12102_database_2of2.zip -d /vagrant/software/db12c
chown -R oracle.oinstall /vagrant/software/db12c

# run this part as oracle
exec sudo -u oracle /bin/bash -l << eof
	/vagrant/software/db12c/database/runInstaller -waitforcompletion -silent -ignorePrereq -responseFile /vagrant/scripts/db12c/db_install.rsp 
eof