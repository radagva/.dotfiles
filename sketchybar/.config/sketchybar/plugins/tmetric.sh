ACCOUNT_ID="105889"
TOKEN="9AD3959AF3914D6D58499E5427E6D7F095992D24D4968C1A5C30214B550184B2"

current_task=$(curl -s -X GET "https://app.tmetric.com/api/accounts/$ACCOUNT_ID/timeentries/recent?includeEmpty=true" \
  -H "Accept: application/json" \
  -H "Authorization: Bearer $TOKEN" | jq '.[0].details.description')

sketchybar --set tmetric label="$current_task"

