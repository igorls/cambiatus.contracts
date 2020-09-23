#!/bin/bash
CLEOS="cleos -u http://192.168.10.201:18888"

SOURCE_CONTRACT="bes.cmm";
TARGET_CONTRACT="bes4.cmm";
TABLE_NAME="indexes";

# print source singleton
$CLEOS get table $SOURCE_CONTRACT $SOURCE_CONTRACT $TABLE_NAME -b

function migrate {
    $CLEOS push action $TARGET_CONTRACT mindexes "[]" -p $TARGET_CONTRACT"@active"
}

migrate;

# print target singleton
$CLEOS get table $TARGET_CONTRACT $TARGET_CONTRACT $TABLE_NAME -b