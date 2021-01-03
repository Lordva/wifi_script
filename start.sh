#!/bin/bash

OSTYPE="$( uname -s )"
DEVICE="en0"
CHANNEL="1"
if [ $OSTYPE != "Darwin" ]; then
	exit
fi

install(){
	echo "to do later"
}

if [ $EUID != 0 ]; then
	echo "You must be root to run this script"
	exit
fi

interface_list(){
	echo "[INFO] Listing interfaces..."
	echo ""
	if networksetup -listallhardwareports | grep -A 3 Wi-Fi ;then
		read -r -p "Enter device name[en0]: " key
		DEVICE=$key
	else 
		echo "[ERROR] Could not list hardware ports try networksetup -h"
		exit
	fi
}

scan(){
	echo "[INFO] Starting scan"
	echo ""
	if airport -s 2> error.log ;then
		read -r -p "Enter target SSID: " SSID
		read -r -p "Enter target Channel[1]: " CHANNEL
	else
		echo "[ERROR] could not start scan "
		cat error.log
		exit
	fi
	if [ -z "$SSID" ] || [ -z "$CHANNEL" ]; then
		clear
		echo "[Warning] SSID or Channel empty"
		echo "Rescaning..."
	sleep 3
		scan
	fi
}

capture(){
	if sudo airport -z; then
		echo "[LOG] Could not "
}
install
interface_list
scan

	
