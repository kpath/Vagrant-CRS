# Use this script to start the ATG Publishing server on JBoss with the proper memory footprint
# The user.timezone setting is required to connect to the DB

export "JAVA_OPTS=-Duser.timezone=UTC -server -Xms512m -Xmx1024m -XX:MaxPermSize=256m -XX:MaxNewSize=128m -Dsun.rmi.dgc.client.gcInterval=3600000 -Dsun.rmi.dgc.server.gcInterval=3600000 -Dorg.jboss.resolver.warning=true -Djava.net.preferIPv4Stack=true -Djboss.socket.binding.port-offset=100"
echo JAVA_OPTS=$JAVA_OPTS

/home/vagrant/jboss/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 -c ATGPublishing.xml
