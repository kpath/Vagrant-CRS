# install CRS application artifacts into ATG servers directory and jboss

# copy jboss application descriptors
cp /vagrant/scripts/atg/crs_artifacts/ATGProduction.xml /vagrant/scripts/atg/crs_artifacts/ATGPublishing.xml /home/vagrant/jboss/standalone/configuration

# create jboss deployments
/home/vagrant/ATG/ATG11.1/home/bin/runAssembler -server "ATGProduction" -jboss "/home/vagrant/jboss/standalone/deployments/ATGProduction/ATGProduction.ear" -m Store.EStore DafEar.Admin DPS DSS ContentMgmt DCS.PublishingAgent DCS.AbandonedOrderServices ContentMgmt.Endeca.Index DCS.Endeca.Index Store.Endeca.Index DAF.Endeca.Assembler PublishingAgent DCS.Endeca.Index.SKUIndexing Store.Storefront Store.Recommendations DCS.ClickToConnect Store.Fluoroscope Store.Fulfillment Store.KnowledgeBase
/home/vagrant/ATG/ATG11.1/home/bin/runAssembler -server "ATGPublishing" -jboss "/home/vagrant/jboss/standalone/deployments/ATGPublishing/ATGPublishing.ear" -m DCS-UI.Versioned BIZUI PubPortlet DafEar.Admin ContentMgmt.Versioned DCS-UI.SiteAdmin.Versioned SiteAdmin.Versioned DCS.Versioned DCS-UI Store.EStore.Versioned Store.Storefront ContentMgmt.Endeca.Index.Versioned DCS.Endeca.Index.Versioned Store.Endeca.Index.Versioned DCS.Endeca.Index.SKUIndexing Store.KnowledgeBase 

# make sure jboss knows to deploy
touch /home/vagrant/jboss/standalone/deployments/ATGProduction/ATGProduction.ear.dodeploy
touch /home/vagrant/jboss/standalone/deployments/ATGPublishing/ATGPublishing.ear.dodeploy

# copy ATG server configs
unzip -n /vagrant/scripts/atg/crs_artifacts/server-ATGProduction.zip -d /home/vagrant/ATG/ATG11.1/home/servers
unzip -n /vagrant/scripts/atg/crs_artifacts/server-ATGPublishing.zip -d /home/vagrant/ATG/ATG11.1/home/servers

# copy ATG version file store
unzip -n /vagrant/scripts/atg/crs_artifacts/versionFileStore.zip -d /home/vagrant/ATG/ATG11.1/home/Publishing

# initialize the CRS Eac artifacts
cp -r /home/vagrant/ATG/ATG11.1/CommerceReferenceStore/Store/Storefront/deploy /home/vagrant/deploy
/usr/local/endeca/ToolsAndFrameworks/11.1.0/deployment_template/bin/deploy.sh --app /home/vagrant/deploy/deploy.xml < /vagrant/scripts/atg/deploy_CRS_endeca_silent.txt
/usr/local/endeca/Apps/CRS/control/initialize_services.sh