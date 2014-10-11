echo "setting up endeca services"

mkdir -p /home/vagrant/scripts
chown vagrant.vagrant /home/vagrant/scripts

cp /vagrant/scripts/atg/endeca/endecaplatform /etc/init.d/endecaplatform
chmod 750 /etc/init.d/endecaplatform
chkconfig --add endecaplatform

cp /vagrant/scripts/atg/endeca/endecaworkbench /etc/init.d/endecaworkbench
chmod 750 /etc/init.d/endecaworkbench
chkconfig --add endecaworkbench

cp /vagrant/scripts/atg/endeca/endecacas /etc/init.d/endecacas
chmod 750 /etc/init.d/endecacas
chkconfig --add endecacas

# start all services
/vagrant/scripts/atg/start_endeca_services.sh

echo "endeca service setup complete"