#!/bin/bash

exec sudo -u oracle /bin/bash -l << eof
	
	# make sure we've got the right environment variables
	source /home/oracle/.bash_profile

	netca -silent -responseFile /opt/oracle/product/11.2.0.4/dbhome_1/assistants/netca/netca.rsp

	dbca -silent -createDatabase -responseFile /vagrant/scripts/db11g/dbca.rsp

eof