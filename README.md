# ATG CRS Quickstart Guide

### About

This document describes a quick and easy way to install and play with ATG CRS.  By following this guide, you'll be able to focus on learning about ATG CRS, without debugging common gotchas.

If you get lost, you can consult the [ATG CRS Installation and Configuration Guide](http://docs.oracle.com/cd/E52191_01/CRS.11-1/ATGCRSInstall/html) for help.

### Conventions

Throughout this document, the top-level directory that you checked out from git will be referred to as `{ATG-CRS}`

### Product versions used in this guide:

- Oracle Linux Server release 6.5 (Operating System) - [All Licenses](https://oss.oracle.com/linux/legal/pkg-list.html)
- Oracle Database (choose either 11g or 12c)
  - Oracle Database 11.2.0.4.0 Enterprise Edition - [license](http://docs.oracle.com/cd/E11882_01/license.112/e47877/toc.htm)
  - Oracle Database 12.1.0.2.0 Enterprise Edition - [license](http://docs.oracle.com/database/121/DBLIC/toc.htm)
- Oracle ATG Web Commerce 11.1 - [license](http://docs.oracle.com/cd/E52191_02/Platform.11-1/ATGLicenseGuide/html/index.html)
- JDK 1.7 - [Oracle BCL license](http://www.oracle.com/technetwork/java/javase/terms/license/index.html)
- ojdbc7.jar - driver [OTN license](http://www.oracle.com/technetwork/licenses/distribution-license-152002.html)
- Jboss EAP 6.1 - [LGPL license](http://en.wikipedia.org/wiki/GNU_Lesser_General_Public_License)

### Other software dependencies

- Vagrant - [MIT license](https://github.com/mitchellh/vagrant/blob/master/LICENSE)
- VirtualBox - [License FAQ](https://www.virtualbox.org/wiki/Licensing_FAQ) - [GPL](http://www.gnu.org/licenses/old-licenses/gpl-2.0.html)
- vagrant-vbguest plugin - [MIT license](https://github.com/dotless-de/vagrant-vbguest/blob/master/LICENSE)
- Oracle SQL Developer - [license](http://www.oracle.com/technetwork/licenses/sqldev-license-152021.html)

### Technical Requirements

This product stack is pretty heavy.  It's a DB, three endeca services and two ATG servers.  You're going to need:

- 16 gigs RAM

## Download Required Database Software

The CRS demo works with either Oracle 11g or Oracle 12c.  Pick one and follow the download and provisioning instructions for the one you picked.

### Oracle 11g (11.2.0.4.0) Enterprise Edition

The first step is to download the required installers.  In order to download Oracle database software you need an Oracle Support account.

- Go to [Oracle Support](http://support.oracle.com)
- Click the "patches and updates" tab
- On the left of the page look for "patching quick links". If it's not expanded, expand it.
- Within that tab, under "Oracle Server and Tools", click "Latest Patchsets"
- This should bring up a popup window.  Mouse over Product->Oracle Database->Linux x86-64 and click on 11.2.0.4.0
- At the bottom of that page, click the link "13390677" within the table, which is the patch number
- Only download parts 1 and 2.

Even though it says it's a patchset, it's actually a full product installer.  

**IMPORTANT:** Put the zip files parts 1 and 2, in the `{ATG-CRS}/software`directory at the top level of this project (it's the directory that has a `readme.txt`file telling you how to use the directory).

### Oracle 12c (12.1.0.2.0) Enterprise Edition

- Go to [Oracle Database Software Downloads](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index-092322.html)
- Accept the license agreement
- Under the section "(12.1.0.2.0) - Enterprise Edition" download parts 1 and 2 for Linux x86-64

**IMPORTANT:** Put the zip files parts 1 and 2, in the `{ATG-CRS}/software`directory at the top level of this project (it's the directory that has a `readme.txt`file telling you how to use the directory).

### Oracle SQL Developer

You will also need a way to connect to the database.  I recommend [Oracle SQL Developer](http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html).

## Download required ATG server software

### ATG 11.1

- Go to [Oracle Edelivery](http://edelivery.oracle.com)
- Accept the restrictions
- On the search page Select the following options: 
  - Product Pack -> ATG Web Commerce
  - Platform -> Linux x86-64
- Click Go
- Click the top search result "Oracle Commerce (11.1.0), Linux"
- Download the following parts:
  - Oracle Commerce Platform 11.1 for UNIX
  - Oracle Commerce Reference Store 11.1 for UNIX
  - Oracle Commerce MDEX Engine 6.5.1 for Linux
  - Oracle Commerce Content Acquisition System 11.1 for Linux
  - Oracle Commerce Experience Manager Tools and Frameworks 11.1 for Linux
  - Oracle Commerce Guided Search Platform Services 11.1 for Linux

**NOTE**  The Experience Manager Tools and Frameworks zipfile (V46389-01.zip) expands to a `cd` directory containing an installer.  It's not strictly required to unzip this file.  If you don't unzip V46389-01.zip the provisioner will do it for you.

### JDK 1.7

- Go to the [Oracle JDK 7 Downloads Page](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html)
- Download "jdk-7u72-linux-x64.rpm"

### JBoss EAP 6.1

- Go to the [JBoss product downloads page](http://www.jboss.org/products/eap/download/)
- Click "View older downloads"
- Click on the zip downloader for 6.1.0.GA

### OJDBC Driver

- Go to the [Oracle 12c driver downloads page](http://www.oracle.com/technetwork/database/features/jdbc/jdbc-drivers-12c-download-1958347.html)
- Download ojdbc7.jar

All oracle drivers are backwards compatible with the officially supported database versions at the time of the driver's release.  You can use ojdbc7 to connect to either 12c or 11g databases.

**IMPORTANT:** Move everything you downloaded to the `{ATG-CRS}/software`directory at the top level of this project.

## Software Check

Before going any further, make sure your software directory looks like one of the following:

If you seclected Oracle 11g:

```
software/
├── OCPlatform11.1.bin
├── OCReferenceStore11.1.bin
├── OCcas11.1.0-Linux64.sh
├── OCmdex6.5.1-Linux64_829811.sh
├── OCplatformservices11.1.0-Linux64.bin
├── V46389-01.zip
├── jboss-eap-6.1.0.zip
├── jdk-7u72-linux-x64.rpm
├── ojdbc7.jar
├── p13390677_112040_Linux-x86-64_1of7.zip
├── p13390677_112040_Linux-x86-64_2of7.zip
└── readme.txt
```

if you selected Oracle 12c:

```
software/
├── OCPlatform11.1.bin
├── OCReferenceStore11.1.bin
├── OCcas11.1.0-Linux64.sh
├── OCmdex6.5.1-Linux64_829811.sh
├── OCplatformservices11.1.0-Linux64.bin
├── V46389-01.zip
├── jboss-eap-6.1.0.zip
├── jdk-7u72-linux-x64.rpm
├── linuxamd64_12102_database_1of2.zip
├── linuxamd64_12102_database_2of2.zip
├── ojdbc7.jar
└── readme.txt
```

## Install Required Virtual Machine Software

Install the latest versions of [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](http://www.vagrantup.com/downloads.html).  Also get the [vagrant-vbguest plugin](https://github.com/dotless-de/vagrant-vbguest).  You install it by typing from the command line:

`vagrant plugin install vagrant-vbguest`

## Create the database vm

This project comes with two databases vm definitions.  Pick either Oracle 11g or 12c.  They both run on the same private IP address, so ATG will connect to either one the same way.

For 11g, type

`vagrant up db11g`

For 12c type

`vagrant up db12c`

This will set in motion an amazing series of events, *and can take a long time*, depending on your RAM, processor speed, and internet connection speed.  The scripts will:

- download an empty centos machine
- switch it to Oracle Linux (an officially supported platform for Oracle 11g and ATG 11.1)
- install all prerequisites for the oracle database
- install and configure the oracle db software
- create an empty db name `orcl`
- import the CRS tables and data

To get a shell on the db vm, type

`vagrant ssh db11g|db12c`

You'll be logged in as the user "vagrant".  This user has sudo privileges (meaning you can run `somecommand`as root by typing `sudo somecommand`). To su to root (get a root shell), type `su -`.  The root password is "vagrant".  If you want to su to the oracle user, the easiest thing to do is to su to root and then type `su - oracle`.  The "oracle" user is the user that's running oracle and owns all the oracle directories.  The project directory will be mounted at `/vagrant`.  You can copy files back and forth between your host machine and the VM using that directory.

Key Information:

- The db vm has the private IP 192.168.70.4.  This is defined at the top of the Vagrantfile.
- The system username password combo is system/oracle
- The ATG schema names are crs_core,crs_pub,crs_cata,crs_catb.  Passwords are the same as schema name.
- The SID (database name) is orcl
- It's running on the default port 1521
- You can control the oracle server with a service: "sudo service dbora stop|start"



## Create the "atg" vm

`vagrant up atg`

When it's done you'll have a vm created that is all ready to install and run ATG CRS.  It will have installed jdk7 at /usr/java/jdk1.7.0_72 and jboss at /home/vagrant/jboss/.  You'll also have the required environment variables set in the .bash_profile of the "vagrant" user.

To get a shell on the atg vm, type

`vagrant ssh atg`

Key Information:

- The atg vm has the private IP 192.168.70.5.  This is defined at the top of the Vagrantfile.
- java is installed in `/usr/java/jdk1.7.0_72`
- jboss is installed at `/home/vagrant/jboss`
- Your project directory is mounted at `/vagrant`.  You'll find the installers you downloaded at `/vagrant/software`from within the atg vm
- All the endeca software is installed under `/usr/local/endeca`and your CRS endeca project is installed under `/usr/local/endeca/Apps`

## Run the ATGPublishing and ATGProduction servers

For your convenience, this project contains scripts that start the ATG servers with the correct options.  Use `vagrant ssh atg`to get a shell on the atg vm, and then run:

`/vagrant/scripts/atg/startPublishing.sh`

and then in a different shell

`/vagrant/scripts/atg/startProduction.sh`

Both servers start in the foreground.  To stop them either press control-c or close the window.

Key Information:

- The ATGProduction server's primary HTTP port is 8080.  You access its dynamo admin at: http://192.168.70.5:8080/dyn/admin
- The ATGPublishing server's primary HTTP port is 8180.  You access its dynamo admin at: http://192.168.70.5:8180/dyn/admin.  It's started with the JBoss option `-Djboss.socket.binding.port-offset=100`so every port is 100 more than the corresponding ATGProduction port.
- The ATG admin username and password is: admin/Admin123.  This applies to both ATGPublishing and ATGProduction.  Use this to log into Dynamo Admin and the BCC
- The various endeca components are installed as the following services. From within the atg vm, you can use the scripts `/vagrant/scripts/atg/start_endeca_services.sh`and `/vagrant/scripts/atg/stop_endeca_services.sh`to start|stop all the endeca services at once:
  - endecaplatform
  - endecaworkbench
  - endecacas

## Run initial full deployment

At this point, you can pick up the ATG CRS documentation from the [Configuring and Running a Full Deployment](http://docs.oracle.com/cd/E52191_01/CRS.11-1/ATGCRSInstall/html/s0214configuringandrunningafulldeploy01.html) section.  Your publishing server has all the CRS data, but nothing has been deployed to production.  You need to:

- Deploy the crs data
- Check the Endeca baseline index status
- Promote the CRS content from the command line

### Deploy the crs data

Do this from within the BCC by following the [docs](http://docs.oracle.com/cd/E52191_01/CRS.11-1/ATGCRSInstall/html/s0214configuringthedeploymenttopology01.html)

### Check the baseline index status

Do this from within the Dynamo Admin by following the [docs](http://docs.oracle.com/cd/E52191_01/CRS.11-1/ATGCRSInstall/html/s0215checkingthebaselineindexstatus01.html)

### Promote the endeca content

Do this from the command line from within the atg vm:

`vagrant ssh atg`

`/usr/local/endeca/Apps/CRS/control/promote_content.sh`

### Access the storefront

The CRS application is live at: 

http://192.168.70.5:8080/crs

