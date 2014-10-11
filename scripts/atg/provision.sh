#!/bin/bash
# Provision the db vm

ALL_PROVISIONERS="check setup install-endeca endeca-service install-atg install-crs-artifacts"

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
            /vagrant/scripts/atg/provision_check_software.sh
            ;;
        setup)
            # provisioning script converts to oracle linux and installs db prereqs
            /vagrant/scripts/atg/provision_setup.sh
            ;;
        install-endeca)
            /vagrant/scripts/atg/provision_install_endeca.sh
            ;;
        endeca-service)
            /vagrant/scripts/atg/provision_service_setup_endeca.sh
            ;;
        install-atg)
            /vagrant/scripts/atg/provision_install_atg.sh
            ;;
        install-crs-artifacts)
            /vagrant/scripts/atg/provision_install_crs_artifacts.sh
            ;;
        none)
            echo "No provisioners run"
            ;;
        *)
            echo "Invalid provisioning arg $p.  Valid args are: $ALL_PROVISIONERS"
    esac
done