#!/bin/bash


echo "Url mobsf: $MOBSF_URL"
echo "DojoIP: $DOJOIP"
echo "TagetPath: $TARGET_PATH"

response=`curl -F "file=@$TARGET_PATH" "${MOBSF_URL}api/v1/upload" -H "Authorization:12345"`
SCAN_TYPE=`echo $response | jq '.scan_type' | sed 's/"//g'`
FILE_NAME=`echo $response | jq '.file_name' | sed 's/"//g'`
HASH=`echo $response | jq '.hash' | sed 's/"//g'`

scan=`curl -X POST --url "${MOBSF_URL}api/v1/scan" --data "scan_type=$SCAN_TYPE&file_name=$FILE_NAME&hash=$HASH" -H "Authorization:12345"`
json=`curl -X POST --url "${MOBSF_URL}api/v1/report_json" --data "hash=$HASH" -H "Authorization:12345" > output/report.json`
pdf=`curl -X POST --url "${MOBSF_URL}api/v1/download_pdf" --data "hash=$HASH" -H "Authorization:12345" > output/report.pdf`


curl -X POST --header "Content-Type:multipart/form-data" --header "Authorization:Token $DOJOKEY" -F "engagement=${EGID}" -F "scan_type=MobSF Scan" -F 'file=@./output/report.json' --url "http://${DOJOIP}/api/v2/import-scan/"