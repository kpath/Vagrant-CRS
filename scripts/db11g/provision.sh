#!/bin/bash
# Provision the db vm

ALL_PROVISIONERS="check setup install postinstall netcadbca import service"

if [[ $@ ]]; then
    PROVISIONERS=$@
else
    PROVISIONERS=$ALL_PROVISIONERS
fi

echo "running provisioners $PROVISIONERS"
for p in $PROVISIONERS
do
    case "$p" in 
        check)
            # check for required software
            source /vagrant/scripts/db11g/provision_check_software.sh
            ;;
        setup)
            # provisioning script converts to oracle linux and installs db prereqs
            /vagrant/scripts/db11g/provision_setup.sh
            ;;
        install)
            # installs oracle 11.2.0.4
            /vagrant/scripts/db11g/provision_install.sh
            ;;
        postinstall)
            # runs oracle postinstallation tasks as root
            /vagrant/scripts/db11g/provision_postinstall.sh
            ;;
        netcadbca)
            # installs tns listener and creates empty db
            /vagrant/scripts/db11g/provision_netca_dbca.sh
            ;;
        import)
            # imports the ATG db dump
            /vagrant/scripts/db11g/provision_import.sh
            ;;
        service)
            # sets up the init.d service
            /vagrant/scripts/db11g/provision_service_setup.sh
            ;;
        none)
            echo "No provisioners run"
            ;;
        *)
            echo "Invalid provisioning arg $p.  Valid args are: $ALL_PROVISIONERS"
    esac
done

