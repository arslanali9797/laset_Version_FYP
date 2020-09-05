#!/bin/sh

# channel Name 
export CHANNEL_ONE_NAME="channelone"

# Profile name 
export CHANNEL_ONE_PROFILE="TwoOrgsChannel"


# Create crypto material using cryptogen tool

echo "##########################################################"
echo "##### Generate certificates using cryptogen tool #########"
echo "##########################################################"


# generate Organization 1 and its peer 
./bin/cryptogen generate --config=./crypto-config-org1.yaml
# Org1 is successfully completed and generated


# generate Organization 2 and its peer
 ./bin/cryptogen generate --config=./crypto-config-org2.yaml
# Org2 is successfully completed and generated


# generate Order Organization 1 and its peer 
./bin/cryptogen generate --config=./crypto-config-orderer.yaml
# Orderer Org is successfully completed and generated

echo "######################## Two Organization and One Orderer had been generated #########################"



echo "####################   Generating Orderer Genesis block #########################"
./bin/configtxgen -profile TwoOrgsOrdererGenesis -channelID system-channel -outputBlock ./channel-artifacts/genesis.block


echo " ###################### generate channel configuration transaction for ${CHANNEL_ONE_NAME} ###################### "
./bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME


echo " ###################### generate anchor peer for channelone transaction of org1  ###################### " 
./bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg Org1MSP


echo " ###################### generate anchor peer for channelone channel transaction of org2 ###################### "
./bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg Org2MSP

