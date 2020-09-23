#!/bin/bash
CLEOS="cleos -u http://192.168.10.201:18888"

# get all scopes
$CLEOS get scope bes.token -l 5000 | jq -r '.rows[] | select(.table=="stat") | .scope' | uniq > _stat_scopes

while IFS= read line
do
	SYMBOL=$($CLEOS get table bes.token $line stat -l 1 | jq ".rows[0].supply")
	echo "Migrating $line >> $SYMBOL"
	$CLEOS push action bes2.token mstat "[$SYMBOL]" -p bes2.token
done <"_stat_scopes"
