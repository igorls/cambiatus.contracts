#!/bin/bash
CLEOS="cleos -u $1";
SOURCE_CONTRACT=$2;
TARGET_CONTRACT=$3;
TABLE_NAME="indexes";

# print source singleton
$CLEOS get table $SOURCE_CONTRACT $SOURCE_CONTRACT $TABLE_NAME -b

function migrate {
    $CLEOS push action $TARGET_CONTRACT mindexes "[]" -p $TARGET_CONTRACT"@active"
}

migrate;

# print target singleton
$CLEOS get table $TARGET_CONTRACT $TARGET_CONTRACT $TABLE_NAME -b