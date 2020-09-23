#!/bin/bash
CLEOS="cleos -u http://192.168.10.201:18888"

# get all scopes
$CLEOS get scope bes.token -l 5000 | jq -r '.rows[] | select(.table=="accounts") | .scope' | uniq > _acct_scopes

while IFS= read line
do
	echo Migrating "$line"...
	$CLEOS push action bes2.token macct '["'${line}'"]' -p bes2.token
done <"_acct_scopes"
