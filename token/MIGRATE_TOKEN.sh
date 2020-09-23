#!/bin/bash
API_URL="http://192.168.10.201:18888";
CLEOS="cleos -u $API_URL";
SOURCE_CONTRACT="bes.token";
TARGET_CONTRACT="test1.token";
PUBLIC_KEY="EOS6Gv6J4dwQUx8jzynAywpV1YZ6ghC1r15Unx3vzkAtUpLfjKxBf";

$CLEOS wallet unlock --password $(cat ~/local.wallet)

$CLEOS system newaccount eosio $TARGET_CONTRACT $PUBLIC_KEY --stake-net "100.0000 EOS" --stake-cpu "100.0000 EOS" --buy-ram-kbytes 2048

make

$CLEOS set contract $TARGET_CONTRACT ./ -p $TARGET_CONTRACT"@active"

sleep 1;

echo "migrate_token_stat";
sleep 2;
bash migrate_token_stat.sh $API_URL $SOURCE_CONTRACT $TARGET_CONTRACT

echo "migrate_token_account";
sleep 2;
bash migrate_token_account.sh $API_URL $SOURCE_CONTRACT $TARGET_CONTRACT