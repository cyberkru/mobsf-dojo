#!/bin/bash


echo "Url mobsf: $MOBSF_URL"
echo "DojoURL: $DOJOURL"
echo "TagetFile: $TARGET_FILE"

sleep 5

response=`curl -F "file=@$TARGET_FILE" "${MOBSF_URL}api/v1/upload" -H "Authorization:12345"`
SCAN_TYPE=`echo $response | jq '.scan_type' | sed 's/"//g'`
FILE_NAME=`echo $response | jq '.file_name' | sed 's/"//g'`
HASH=`echo $response | jq '.hash' | sed 's/"//g'`

scan=`curl -X POST --url "${MOBSF_URL}api/v1/scan" --data "scan_type=$SCAN_TYPE&file_name=$FILE_NAME&hash=$HASH" -H "Authorization:12345"`
json=`curl -X POST --url "${MOBSF_URL}api/v1/report_json" --data "hash=$HASH" -H "Authorization:12345" > output/report.json`
pdf=`curl -X POST --url "${MOBSF_URL}api/v1/download_pdf" --data "hash=$HASH" -H "Authorization:12345" > output/report.pdf`

PRODID=$(curl -k -s -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Token ${DOJOKEY}" --url "${DOJOURL}/api/v2/products/?limit=1000" | jq -c '[.results[] | select(.name | contains('\"${PRODNAME}\"'))][0] | .id')
EGID=$(curl -k -s -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: Token $DOJOKEY" --url "${DOJOURL}/api/v2/engagements/?limit=1000" | jq -c "[.results[] | select(.product == ${PRODID})][0] | .id")
curl -X POST --header "Content-Type:multipart/form-data" --header "Authorization:Token $DOJOKEY" -F "engagement=${EGID}" -F "close_old_findings=true" -F "scan_type=MobSF Scan" -F 'file=@./output/report.json' --url "${DOJOURL}/api/v2/import-scan/"
