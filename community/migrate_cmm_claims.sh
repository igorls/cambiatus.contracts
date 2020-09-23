#!/bin/bash
CLEOS="cleos -u http://192.168.10.201:18888"

SOURCE_CONTRACT="bes.cmm";
TARGET_CONTRACT="bes4.cmm";
TABLE_NAME="claim";

# count source rows
SOURCE_ROWS=$($CLEOS get table $SOURCE_CONTRACT $SOURCE_CONTRACT $TABLE_NAME --limit 1000 | jq ".rows[].id" | wc -l)

function migrate {
    echo "From $1";
    $CLEOS push action $TARGET_CONTRACT mclaim "[$1,100,false]" -p $TARGET_CONTRACT"@active" -j | jq -r ".processed.action_traces[].console"
    sleep 0.5;
}

migrate 0
migrate 100
migrate 200
migrate 300

TARGET_ROWS=$($CLEOS get table $TARGET_CONTRACT $TARGET_CONTRACT $TABLE_NAME --limit 1000 | jq ".rows[].id" | wc -l)

echo "Source: $SOURCE_ROWS | Target: $TARGET_ROWS";