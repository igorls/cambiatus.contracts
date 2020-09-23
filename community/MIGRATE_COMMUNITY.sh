#!/bin/bash
API_URL="http://192.168.10.201:18888";
CLEOS="cleos -u $API_URL";
SOURCE_CONTRACT="bes.cmm";
TARGET_CONTRACT="test1.cmm";
PUBLIC_KEY="EOS6Gv6J4dwQUx8jzynAywpV1YZ6ghC1r15Unx3vzkAtUpLfjKxBf";

$CLEOS wallet unlock --password $(cat ~/local.wallet)

$CLEOS system newaccount eosio $TARGET_CONTRACT $PUBLIC_KEY --stake-net "100.0000 EOS" --stake-cpu "100.0000 EOS" --buy-ram-kbytes 2048

make

$CLEOS set contract $TARGET_CONTRACT ./ -p $TARGET_CONTRACT"@active"


echo "migrate_cmm_actions";
sleep 5;
bash migrate_cmm_actions.sh $API_URL $SOURCE_CONTRACT $TARGET_CONTRACT

echo "migrate_cmm_checks";
sleep 5;
bash migrate_cmm_checks.sh $API_URL $SOURCE_CONTRACT $TARGET_CONTRACT

echo "migrate_cmm_claims";
sleep 5;
bash migrate_cmm_claims.sh $API_URL $SOURCE_CONTRACT $TARGET_CONTRACT

echo "migrate_cmm_communities";
sleep 5;
bash migrate_cmm_communities.sh $API_URL $SOURCE_CONTRACT $TARGET_CONTRACT

echo "migrate_cmm_indexes";
sleep 5;
bash migrate_cmm_indexes.sh $API_URL $SOURCE_CONTRACT $TARGET_CONTRACT

echo "migrate_cmm_network";
sleep 5;
bash migrate_cmm_network.sh $API_URL $SOURCE_CONTRACT $TARGET_CONTRACT

echo "migrate_cmm_objectives";
sleep 5;
bash migrate_cmm_objectives.sh $API_URL $SOURCE_CONTRACT $TARGET_CONTRACT

echo "migrate_cmm_sales";
sleep 5;
bash migrate_cmm_sales.sh $API_URL $SOURCE_CONTRACT $TARGET_CONTRACT

echo "migrate_cmm_validators";
sleep 5;
bash migrate_cmm_validators.sh $API_URL $SOURCE_CONTRACT $TARGET_CONTRACT