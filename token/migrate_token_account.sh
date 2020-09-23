#!/bin/bash
CLEOS="cleos -u $1";
SOURCE_CONTRACT=$2;
TARGET_CONTRACT=$3;

# get all scopes
$CLEOS get scope $SOURCE_CONTRACT -l 5000 | jq -r '.rows[] | select(.table=="accounts") | .scope' | uniq > _acct_scopes

while IFS= read line
do
	echo Migrating "$line"...
	$CLEOS push action $TARGET_CONTRACT macct '["'${line}'"]' -p $TARGET_CONTRACT"@active"
	sleep 0.1;
done <"_acct_scopes"
