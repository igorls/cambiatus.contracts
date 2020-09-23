#!/bin/bash
CLEOS="cleos -u $1";
SOURCE_CONTRACT=$2;
TARGET_CONTRACT=$3;
TABLE_NAME="community";

# count source rows
SOURCE_ROWS=$($CLEOS get table $SOURCE_CONTRACT $SOURCE_CONTRACT $TABLE_NAME --limit 1000 | jq ".rows[].id" | wc -l)

function migrate {
    echo "From $1";
    $CLEOS push action $TARGET_CONTRACT mcommunity "[$1,100,false]" -p $TARGET_CONTRACT"@active" -j | jq -r ".processed.action_traces[].console"
    sleep 1;
}

migrate 0
migrate 100
migrate 200

TARGET_ROWS=$($CLEOS get table $TARGET_CONTRACT $TARGET_CONTRACT $TABLE_NAME --limit 1000 | jq ".rows[].id" | wc -l)

echo "Source: $SOURCE_ROWS | Target: $TARGET_ROWS";