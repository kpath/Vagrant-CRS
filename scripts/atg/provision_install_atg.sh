# do this as vagrant
exec sudo -u vagrant /bin/bash -l << eof

	# jboss
	unzip -n /vagrant/software/jboss-eap-6.1.0.zip -d /home/vagrant
	ln -s /home/vagrant/jboss-eap-6.1 /home/vagrant/jboss

	# install the ojdbc driver
	mkdir -p /home/vagrant/jboss/modules/com/oracle/ojdbc7/main
	cp /vagrant/software/ojdbc7.jar /home/vagrant/jboss/modules/com/oracle/ojdbc7/main
	cp /vagrant/scripts/atg/module.xml /home/vagrant/jboss/modules/com/oracle/ojdbc7/main

	# atg
	echo "installing ATG Platform 11.1 ..."
	/vagrant/software/OCPlatform11.1.bin -i silent -f /vagrant/scripts/atg/OCPlatform11.1.properties
	echo "ATG Platform 11.1 installation complete"

	# atg
	echo "installing ATG CRS 11.1 ..."
	/vagrant/software/OCReferenceStore11.1.bin -i silent
	echo "ATG CRS 11.1 installation complete"

	echo "installation done"

eof