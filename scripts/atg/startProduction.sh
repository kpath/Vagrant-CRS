# Use this script to start the ATG Production server on JBoss with the proper memory footprint
# The user.timezone setting is required to connect to the DB

export "JAVA_OPTS=-Duser.timezone=UTC -server -Xms1024m -Xmx2048m -XX:MaxPermSize=512m -XX:MaxNewSize=512m -Dsun.rmi.dgc.client.gcInterval=3600000 -Dsun.rmi.dgc.server.gcInterval=3600000 -Dorg.jboss.resolver.warning=true -Djava.net.preferIPv4Stack=true -Djboss.socket.binding.port-offset=0"
echo JAVA_OPTS=$JAVA_OPTS

/home/vagrant/jboss/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 -c ATGProduction.xml
