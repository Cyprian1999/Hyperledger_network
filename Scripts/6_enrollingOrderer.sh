echo "Zapis orderera1"
mkdir -p /tmp/hyperledger/Orderer/orderer/assets/ca
cp /tmp/hyperledger/Orderer/ca/admin/msp/cacerts/0-0-0-0-7054.pem /tmp/hyperledger/Orderer/orderer/assets/ca/orderer-ca-cert.pem

mkdir -p /tmp/hyperledger/Orderer/orderer/assets/tls-ca
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/Orderer/orderer/assets/tls-ca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/Orderer/orderer
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/Orderer/orderer/assets/ca/orderer-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://orderer:ordererpw@0.0.0.0:7054
sleep 5

echo "Generowanie certyfikatu TLS dla orderera"
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/Orderer/orderer/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer
sleep 5

echo "Zapis admina dla Orderera"
export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/Orderer/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/Orderer/orderer/assets/ca/orderer-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin-orderer:ordererAdminpw@0.0.0.0:7054

echo "Zmiana nazwy klucza"
cp $(find ${CONFIGURATION_PATH}/Orderer/orderer/tls-msp/keystore -type f | head -n 1) ${CONFIGURATION_PATH}/Orderer/orderer/tls-msp/keystore/key.pem
cp $(find ${CONFIGURATION_PATH}/Orderer/orderer/msp/keystore -type f | head -n 1) ${CONFIGURATION_PATH}/Orderer/orderer/msp/keystore/key.pem

echo "Przeniesienie certyfikatu z MSP do admincerts"
mkdir ${CONFIGURATION_PATH}/Orderer/orderer/msp/admincerts
cp ${CONFIGURATION_PATH}/Orderer/orderer/msp/signcerts/cert.pem ${CONFIGURATION_PATH}/Orderer/orderer/msp/admincerts/orderer-admin-cert.pem

echo "Tworzenie MSP dla Orderera"
mkdir -p ${CONFIGURATION_PATH}/Orderer/msp/{cacerts,tlscacerts,admincerts}
echo "Kopiowanie certyfikatów"
cp ${CONFIGURATION_PATH}/Orderer/ca/crypto/ca-cert.pem ${CONFIGURATION_PATH}/Orderer/msp/cacerts/orderer-ca-cert.pem
cp ${CONFIGURATION_PATH}/Orderer/orderer/assets/tls-ca/tls-ca-cert.pem ${CONFIGURATION_PATH}/Orderer/msp/tlscacerts/tls-ca-cert.pem
cp ${CONFIGURATION_PATH}/Orderer/admin/msp/signcerts/cert.pem ${CONFIGURATION_PATH}/Orderer/msp/admincerts/admin-orderer-cert.pem

echo "Konfiguracja Orderera zakończona"
