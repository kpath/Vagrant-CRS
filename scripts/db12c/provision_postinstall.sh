#!/bin/bash

# verify that we're running as root
echo running postinstall actions as `whoami`

# oracle postinstall actions
/opt/oraInventory/orainstRoot.sh
/opt/oracle/product/12.1.0.2/dbhome_1/root.sh