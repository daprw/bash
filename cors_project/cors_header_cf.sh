#!/bin/bash

# Title: cors_header_cf.sh
#
# Description: This script seeks to allow users to enable CORS (Cross Origin Resource Sharing) on all containers for a given region.
#              The goal is the have the user enter username && api key, the script takes over and authenticates against the identity
#              endpoint (https://identity.api.rackspacecloud.com/v2.0/tokens). Then we want to get relevant details so the cloud files
#              endpoints for storage operations and then the AUTH TOKEN generated as part of the identity call we just made.
#
# Usage - ./cors_header_cf.sh <region> --> 1st argument can for region can be dfw, ord, iad, syd, or hkg.
#

# Get the user credentials, store them silently.
read -sp 'Enter the primary username for the account: ' APIUSER
echo ""
read -sp 'Enter the api key for the primary user: ' APIKEY
echo ""
echo "Thank you, we will begin pulling the relevant Cloud Files details for your account"
sleep 2s

# Authenticate to the identity endpoint and pull auth token, as well as the storage endpoint urls.
curl https://identity.api.rackspacecloud.com/v2.0/tokens  \
 -X POST \
 -d '{"auth":{"RAX-KSKEY:apiKeyCredentials":{"username":"'$APIUSER'","apiKey":"'$APIKEY'"}}}' \
 -H "Content-type: application/json" | python -m json.tool | grep -E "storage101|id" > service_catalog_cf

echo "Successfully created 'service_catalog_cf' file in users home directory."
echo "Running cleanup of extraneous file lines.."
sleep 2s

# Clean up extra lines in the created files and remove commas and quotes.
sed -i '14,24d' service_catalog_cf
sed -i 's/\"//g' service_catalog_cf
sed -i 's/\,//g' service_catalog_cf
echo "Done cleaning."
sleep 2s

echo "Retrieving container list.."
sleep 3s

# If/else statements to store urls from grepped output in vars, give user the auth token to be stored as part of the curl to list containers for the account.
if [ $1 = "dfw" ]
then
	DFW_CF=$(grep -io 'https://storage101.dfw1.*' service_catalog_cf)
	grep -i 'id:' service_catalog_cf
	echo "Please copy the auth token above (text only, leave out spaces).."
	read -sp 'Enter the authentication token: ' AUTHTOKEN
	DFW_CONTAINERS=$(curl -H "X-Auth-Token: $AUTHTOKEN" $DFW_CF)
	echo $DFW_CONTAINERS
	echo ""

	# for loop to run through the containers and apply the CORS header to each container.
	for i in $DFW_CONTAINERS
	do
		curl -i -X POST $DFW_CF/$i -H "X-Auth-Token: $AUTHTOKEN" -H "X-Container-Meta-Access-Control-Allow-Origin: *"
	done
	echo ""
	echo"Finished adding CORS headers to your containers!"
	echo "Check container header with 'curl -I -X HEAD $SYD_CF/<container-name> -H X-Auth-Token: <authtoken>'"

elif [ $1 = "ord" ]
then
	ORD_CF=$(grep -io 'https://storage101.ord1.*' service_catalog_cf)
	grep -i 'id:' service_catalog_cf
	echo "Please copy the auth token above (text only, leave out spaces).."
	read -sp 'Enter the authentication token: ' AUTHTOKEN
	ORD_CONTAINERS=$(curl -H "X-Auth-Token: $AUTHTOKEN" $ORD_CF)
	echo $ORD_CONTAINERS
	echo ""

	for i in $ORD_CONTAINERS
	do
		curl -i -X POST $ORD_CF/$i -H "X-Auth-Token: $AUTHTOKEN" -H "X-Container-Meta-Access-Control-Allow-Origin: *"
	done
	echo ""
	echo"Finished adding CORS headers to your containers!"
	echo ""
	echo "Check container header with 'curl -I -X HEAD $SYD_CF/<container-name> -H X-Auth-Token: <authtoken>'"
	

elif [ $1 = "iad" ]
then
	IAD_CF=$(grep -io 'https://storage101.iad3.*' service_catalog_cf)
	grep -i 'id:' service_catalog_cf
	echo "Please copy the auth token above (text only, leave out spaces).."
	read -sp 'Enter the authentication token: ' AUTHTOKEN
	IAD_CONTAINERS=$(curl -H "X-Auth-Token: $AUTHTOKEN" $IAD_CF)
	echo $IAD_CONTAINERS
	echo ""

	for i in $IAD_CONTAINERS
	do
		curl -i -X POST $IAD_CF/$i -H "X-Auth-Token: $AUTHTOKEN" -H "X-Container-Meta-Access-Control-Allow-Origin: *"
	done
	echo ""
	echo"Finished adding CORS headers to your containers!"
	echo ""
	echo "Check container header with 'curl -I -X HEAD $IAD_CF/<container-name> -H X-Auth-Token: <authtoken>'"
	

elif [ $1 = "hkg" ]
then
	HKG_CF=$(grep -io 'https://storage101.hkg1.*' service_catalog_cf)
	grep -i 'id:' service_catalog_cf
	echo "Please copy the auth token above (text only, leave out spaces).."
	read -sp 'Enter the authentication token: ' AUTHTOKEN
	HKG_CONTAINERS=$(curl -H "X-Auth-Token: $AUTHTOKEN" $HKG_CF)
	echo $HKG_CONTAINERS
	echo ""

	for i in $HKG_CONTAINERS
	do
		curl -i -X POST $HKG_CF/$i -H "X-Auth-Token: $AUTHTOKEN" -H "X-Container-Meta-Access-Control-Allow-Origin: *"
	done
	echo ""
	echo"Finished adding CORS headers to your containers!"
	echo ""
	echo "Check container header with 'curl -I -X HEAD $HKG_CF/<container-name> -H X-Auth-Token: <authtoken>'"
	

elif [ $1 = "syd" ]
then
	SYD_CF=$(grep -io 'https://storage101.syd2.*' service_catalog_cf)
	grep -i 'id:' service_catalog_cf
	echo "Please copy the auth token above (text only, leave out spaces).."
	read -sp 'Enter the authentication token: ' AUTHTOKEN
	SYD_CONTAINERS=$(curl -H "X-Auth-Token: $AUTHTOKEN" $SYD_CF)
	echo $SYD_CONTAINERS
	echo ""

	for i in $SYD_CONTAINERS
	do
		curl -i -X POST $SYD_CF/$i -H "X-Auth-Token: $AUTHTOKEN" -H "X-Container-Meta-Access-Control-Allow-Origin: *"
	done
	echo ""
	echo"Finished adding CORS headers to your containers!"
	echo ""
	echo "Check container header with 'curl -I -X HEAD $SYD_CF/<container-name> -H X-Auth-Token: <authtoken>'"
	
fi
