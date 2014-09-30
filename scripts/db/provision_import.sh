# move the data dump to the builtin data_pump_dir
unzip /vagrant/scripts/db/crs_artifacts/atg_crs.dmp.zip -d /opt/oracle/admin/orcl/dpdump
chown oracle:oinstall /opt/oracle/admin/orcl/dpdump/atg_crs.dmp

# do this as oracle
exec sudo -u oracle /bin/sh - << eof
	# get the env
	source /home/oracle/.bash_profile

	# run the import
	impdp system/oracle@orcl schemas=crs_core,crs_pub,crs_cata,crs_catb directory=data_pump_dir dumpfile=atg_crs.dmp logfile=atgdmp.log

eof