#/!bin/bash

#Modify these variables!!
HOSTED_ZONE="YOUR_HOSTED_ZONE_HERE"
NAME="DNS_RECORD_NAME"

#Setting IP to public IP
IP=$(curl ifconfig.me)
IP2=$(<ip)

if [ $IP == $IP2 ];
then
        echo "The IP has not changed"
else
        INPUT_JSON=$( cat ./update-route53-A.json | sed "s/127\.0\.0\.1/$IP/" | sed "s/example\.com/$NAME/" )
        INPUT_JSON="{ \"ChangeBatch\": $INPUT_JSON }"
        aws route53 change-resource-record-sets --hosted-zone-id "$HOSTED_ZONE" --cli-input-json "$INPUT_JSON"
        echo $IP > ip
fi