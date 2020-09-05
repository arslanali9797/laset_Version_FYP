#!/bin/sh


export BYFN_CA1_PRIVATE_KEY=$(cd crypto-config/peerOrganizations/org1.example.com/ca && ls *_sk)

echo ${BYFN_CA1_PRIVATE_KEY}
docker-compose -f docker-compose.yaml up -d
docker ps


export CHANNEL_ONE_NAME="channelone"

export FABRIC_START_TIMEOUT=5
sleep ${FABRIC_START_TIMEOUT}

echo "###########  Creating Channel One as Org1 Peer  ##################"
