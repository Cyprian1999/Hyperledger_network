export CONFIGURATION_PATH="/tmp/hyperledger"
export DOCKER_PATH="/home/cyprian/Desktop/Hyperledger_network/Docker_files"
export CONFIGTX_PATH="/home/cyprian/Desktop/Hyperledger_network/ConfigTx"
export SCRIPTS_PATH="/home/cyprian/Desktop/Hyperledger_network/Scripts"
export LOGS_PATH="/home/cyprian/Desktop/Hyperledger_network/Logs"
source ~/.bashrc

LOG_FILE="${LOGS_PATH}/$(date +%Y-%m-%d-H%M%S)-deployment.log"
exec > "$LOG_FILE" 2>&1

sudo chown -R $(whoami):$(whoami) /tmp/hyperledger
sudo chmod -R 755 /tmp/hyperledger

echo $PATH
which fabric-ca-client

cd ${DOCKER_PATH}
docker-compose -f tls-ca.yaml up -d
sleep 5
cd ${SCRIPTS_PATH}
./1_ca-tls.sh
cd ${DOCKER_PATH}
docker-compose -f orderer.yaml up -d
sleep 5
docker-compose -f  ca-organisations.yaml up -d
sleep 5
cd ${SCRIPTS_PATH}
./2_creatingOrderer.sh
./3_creatingHospitalA.sh
./4_creatingHospitalB.sh
./5_creatingInsuranceProvider.sh
./6_enrollingOrderer.sh
./7_enrollingHospitalA.sh
./8_enrollingHospitalB.sh
./9_enrollingInsuranceProvider.sh
cd ${DOCKER_PATH}
docker-compose -f peer-organisations.yaml up -d
sleep 5
cd ${SCRIPTS_PATH}
./10_creatingChannelTx.sh
cd ${DOCKER_PATH}
docker-compose -f cli.yaml up -d
echo "FINISH"
