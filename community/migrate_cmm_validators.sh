#!/bin/bash
CLEOS="cleos -u $1";
SOURCE_CONTRACT=$2;
TARGET_CONTRACT=$3;
TABLE_NAME="validator";

# get all scopes
$CLEOS get scope $SOURCE_CONTRACT -l 1000 | jq -r '.rows[] | select(.table=="validator") | .scope' | uniq > _validator_scopes

while IFS= read line
do
	echo Migrating "$line"...
	$CLEOS push action $TARGET_CONTRACT mvalidator '["'${line}'",false]' -p $TARGET_CONTRACT"@active" -j | jq -r ".processed.action_traces[].console"
	sleep 0.1;
done <"_validator_scopes"
