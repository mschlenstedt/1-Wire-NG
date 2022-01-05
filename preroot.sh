#!/bin/bash

# To use important variables from command line use the following code:
COMMAND=$0    # Zero argument is shell command
PTEMPDIR=$1   # First argument is temp folder during install
PSHNAME=$2    # Second argument is Plugin-Name for scipts etc.
PDIR=$3       # Third argument is Plugin installation folder
PVERSION=$4   # Forth argument is Plugin version
#LBHOMEDIR=$5 # Comes from /etc/environment now. Fifth argument is
              # Base folder of LoxBerry
PTEMPPATH=$6  # Sixth argument is full temp path during install (see also $1)

# Combine them with /etc/environment
PCGI=$LBPCGI/$PDIR
PHTML=$LBPHTML/$PDIR
PTEMPL=$LBPTEMPL/$PDIR
PDATA=$LBPDATA/$PDIR
PLOG=$LBPLOG/$PDIR # Note! This is stored on a Ramdisk now!
PCONFIG=$LBPCONFIG/$PDIR
PSBIN=$LBPSBIN/$PDIR
PBIN=$LBPBIN/$PDIR

if [ -e /etc/apt/sources.list.d/testing.list ] && [ -e /etc/apt/apt.conf.d/99myDefaultRelease ]; then
	echo "<INFO> We are in Upgrade mode of a broken release. Repairing broken apt configuration from earlier version."
	rm /etc/apt/sources.list.d/testing.list
	rm /etc/apt/apt.conf.d/99myDefaultRelease
	export APT_LISTCHANGES_FRONTEND=none
	export DEBIAN_FRONTEND=noninteractive
	APT_LISTCHANGES_FRONTEND=none DEBIAN_FRONTEND=noninteractive apt-get -q -y --allow-unauthenticated --allow-downgrades --allow-remove-essential --allow-change-held-packages update
	APT_LISTCHANGES_FRONTEND=none DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::=--force-confdef --no-install-recommends -q -y --allow-unauthenticated --fix-broken --reinstall --allow-downgrades --allow-remove-essential --allow-change-held-packages remove owfs owserver owhttpd owftpd owfs-fuse owfs-common owserver libow-3.2-3 libftdi1-2
	dpkg --configure -a
fi

exit 0
