#!/bin/bash

exec sudo -u oracle /bin/bash -l << eof
	
	# make sure we've got the right environment variables
	source /home/oracle/.bash_profile

	netca -silent -responseFile /opt/oracle/product/12.1.0.2/dbhome_1/assistants/netca/netca.rsp

	dbca -silent -createDatabase -responseFile /vagrant/scripts/db12c/dbca.rsp

eof