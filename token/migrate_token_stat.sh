#!/bin/bash
CLEOS="cleos -u $1";
SOURCE_CONTRACT=$2;
TARGET_CONTRACT=$3;

# get all scopes
$CLEOS get scope $SOURCE_CONTRACT -l 5000 | jq -r '.rows[] | select(.table=="stat") | .scope' | uniq > _stat_scopes

while IFS= read line
do
	SYMBOL=$($CLEOS get table bes.token $line stat -l 1 | jq ".rows[0].supply")
	echo "Migrating $line >> $SYMBOL"
	$CLEOS push action $TARGET_CONTRACT mstat "[$SYMBOL]" -p $TARGET_CONTRACT"@active"
	sleep 0.1;
done <"_stat_scopes"
