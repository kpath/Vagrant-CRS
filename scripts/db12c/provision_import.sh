#!/bin/bash
# move the data dump to the builtin data_pump_dir
unzip -n /vagrant/scripts/db12c/crs_artifacts/atg_crs.dmp.zip -d /opt/oracle/admin/orcl/dpdump
chown oracle:oinstall /opt/oracle/admin/orcl/dpdump/atg_crs.dmp

# do this as oracle
exec sudo -u oracle /bin/bash -l << eof
	# run the import
	impdp system/oracle@orcl schemas=crs_pub,crs_core,crs_cata,crs_catb directory=data_pump_dir dumpfile=atg_crs.dmp logfile=atg_crsdmp.log

eof