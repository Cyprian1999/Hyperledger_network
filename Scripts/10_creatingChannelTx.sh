echo "Tworzenie danych kryptograficznych dla kanału oraz bloku zero"
cd ../../backup/Hyperledger_network/ConfigTx
configtxgen -profile OrgsOrdererGenesis -outputBlock /tmp/hyperledger/Orderer/orderer/genesis.block -channelID syschannel
sleep 5
configtxgen -profile ThreeOrgsChannel -outputCreateChannelTx /tmp/hyperledger/Orderer/orderer/channel.tx -channelID mychannel
sleep 5
