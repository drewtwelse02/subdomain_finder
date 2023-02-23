#!/bin/bash

# get target name to create directoty 
target_name=$1 
if [ ! -d "$target_name" ]; then 
		mkdir $target_name
fi
if [ ! -d "$target_name/recon" ]; then 
	mkdir $target_name/recon 
fi 


if [ "$2" ]; then 
	echo "[+] Harvesting specific Subdomain with assetfinder"
	assetfinder -subs-only $target_name | cat >> $target_name/recon/$target_name.txt
else 
	# run assetfinder without subs-only parameters 
	echo "[+] Harvesting subdomain with assetfinder ( No subs-only) "
	assetfinder $target_name | cat >> $target_name/recon/$target_name.txt
fi

# Get subdomain using amass 
echo "[+] Harvesting subdomain with Amass" 
amass enum -d $target_name >> $target_name/recon/"amass_${target_name}.txt"



