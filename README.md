# ATG CRS Quickstart Guide

### Product versions used in this guide:

- Oracle Linux Server release 6.5 (Operating System)
- Oracle Database 11.2.0.4.0 Enterprise Edition
- Oracle ATG Web Commerce 11.1
- JDK 1.7
- ojdbc7.jar driver
- Jboss EAP 6.1

### About

This document describes a quick and easy way to install and play with ATG CRS.  By following this guide, you'll be able to focus on learning about ATG CRS, without debugging common gotchas.  

You need to run these vms on a pretty robust machine - the ATG vm requires 6 gigs of ram to run, and the DB needs 2 gigs.

### Conventions

Throughout this document, the top-level directory that you checked out from git will be referred to as `${ATG-CRS}`

## Install Required Virtual Machine Software

Install the latest versions of [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](http://www.vagrantup.com/downloads.html)

## Download Required Database Software

The first step is to download the required installers.  In order to download Oracle database software you need an Oracle Support account.

### Oracle 11.2.0.4.0 Enterprise Edition

- Go to [Oracle Support](http://support.oracle.com)
- Click the "patches and updates" tab
- On the left of the page look for "patching quick links". If it's not expanded, expand it.
- Within that tab, under "Oracle Server and Tools", click "Latest Patchsets"
- This should bring up a popup window.  Mouse over Product->Oracle Database->Linux x86-64 and click on 11.2.0.4.0
- At the bottom of that page, click the link "13390677" within the table, which is the patch number
- Only download parts 1 and 2.

Even though it says it's a patchset, it's actually a full product installer.  

**IMPORTANT:** Put the zip files parts 1 and 2, in the `${ATG-CRS}/software` directory at the top level of this project (it's the directory that has a `readme.txt` file telling you how to use the directory).

### Oracle SQL Developer

You will also need a way to connect to the database.  I recommend [Oracle SQL Developer](http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html).

## Build the database vm

In the root directory of this project (the one that contains the Vagrantfile), type:

`$ vagrant up db`

This will set in motion an amazing series of events, and will take some time (~10-15 min, depending on download and machine speeds):

- download an empty centos machine
- switch it to Oracle Linux (an officially supported platform for Oracle 11g and ATG 11.1)
- install all prerequisites for Oracle 11.2.0.4.0
- install and configure the oracle db software
- create an empty db name `orcl`
- import the CRS tables and data

To get a shell on the db vm, type

`$ vagrant ssh db`

You'll be logged in as the user "vagrant".  This user has sudo privileges (meaning you can run `somecommand` as root by typing `$ sudo somecommand`). To su to root (get a root shell), type `su -`.  The root password is "vagrant".  If you want to su to the oracle user, the easiest thing to do is to su to root and then type `su - oracle`.  The "oracle" user is the user that's running oracle and owns all the oracle directories.  The project directory (the directory from which you ran `vagrant up db`) will be mounted at /vagrant.  You can copy files back and forth between your host machine and the VM using that directory.

Key Information:

- The db vm has the private IP 192.168.70.4.  This is defined at the top of the Vagrantfile.
- The system username password combo is system/oracle
- The ATG schema names are crs_core,crs_pub,crs_cata,crs_catb.  Passwords are the same as schema name.
- The SID (database name) is orcl
- It's running on the default port 1521
- You can control the oracle server with a service: "sudo service dbora stop|start"

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
- Unzip everything into the software `${ATG-CRS}/software` directory at the top of the project

### JDK 1.7

- Go to the [Oracle JDK 7 Downloads Page](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html)
- Download "jdk-7u67-linux-x64.rpm"

### JBoss EAP 6.1

- Go to the [JBoss product downloads page](http://www.jboss.org/products/eap/download/)
- Click "View older downloads"
- Click on the zip downloader for 6.1.0.GA

### OJDBC Driver

- Go to the [Oracle 12c driver downloads page](http://www.oracle.com/technetwork/database/features/jdbc/jdbc-drivers-12c-download-1958347.html)
- Download ojdbc7.jar

All oracle drivers are backwards compatible with the officially supported database versions at the time of the driver's release.  You can use ojdbc7 to connect to either 12c or 11g databases.

**IMPORTANT:** Move everything you downloaded to the `${ATG-CRS}/software` directory at the top level of this project.

## Create the "atg" vm

`$ vagrant up atg`

When it's done you'll have a vm created that is all ready to install and run ATG CRS.  It will have installed jdk7 at /usr/java/jdk1.7.0_67 and jboss at /home/vagrant/jboss/.  You'll also have the required environment variables set in the .bash_profile of the "vagrant" user.

To get a shell on the atg vm, type

`$ vagrant ssh atg`

Key Information:

- The atg vm has the private IP 192.168.70.5.  This is defined at the top of the Vagrantfile.
- java is installed in `/usr/java/jdk1.7.0_67`
- jboss is installed at `/home/vagrant/jboss`
- Your project directory is mounted at `/vagrant`.  You'll find the installers you downloaded at `/vagrant/software` from within the atg vm
- All the endeca software is installed under `/usr/local/endeca` and your CRS endeca project is installed under `/usr/local/endeca/Apps`

## Run the ATGPublishing and ATGProduction servers

For your convenience, this project contains scripts that start the ATG servers with the correct options.  Use `vagrant ssh atg` to get a shell on the atg vm, and then run:

`[vagrant@localhost]$ /vagrant/scripts/atg/startPublishing.sh`

and then in a different shell

`[vagrant@localhost]$ /vagrant/scripts/atg/startPublishing.sh`

Both servers start in the foreground.  To stop them either press control-c or close the window.

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

`$ vagrant ssh atg`

`[vagrant@localhost]$ /usr/local/endeca/Apps/CRS/control/promote_content.sh`

