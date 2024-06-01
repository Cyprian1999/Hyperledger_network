echo "Zapis InsuranceProvider"
echo "Tworzenie struktury katalogów i certyfikatów dla peer1"
mkdir -p ${CONFIGURATION_PATH}/InsuranceProvider/peer1/assets/ca
cp ${CONFIGURATION_PATH}/InsuranceProvider/ca/admin/msp/cacerts/0-0-0-0-10054.pem ${CONFIGURATION_PATH}/InsuranceProvider/peer1/assets/ca/insurance-provider-ca-cert.pem

mkdir -p ${CONFIGURATION_PATH}/InsuranceProvider/peer1/assets/tls-ca
cp ${CONFIGURATION_PATH}/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem ${CONFIGURATION_PATH}/InsuranceProvider/peer1/assets/tls-ca/tls-ca-cert.pem

echo "tworzenie MSP dla peer1 InsuranceProvider"
export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/InsuranceProvider/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/InsuranceProvider/peer1/assets/ca/insurance-provider-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-insuranceProvider:peer1PW@0.0.0.0:10054
sleep 5

echo "tworzenie TLS dla peer1 InsuranceProvider"
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/InsuranceProvider/peer1/assets/tls-ca/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://peer1-insuranceProvider:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-insuranceprovider
sleep 5

echo "zmiana nazw kluczy"
cp ${CONFIGURATION_PATH}/InsuranceProvider/peer1/tls-msp/keystore/*_sk ${CONFIGURATION_PATH}/InsuranceProvider/peer1/tls-msp/keystore/key.pem
cp ${CONFIGURATION_PATH}/InsuranceProvider/peer1/msp/keystore/*_sk ${CONFIGURATION_PATH}/InsuranceProvider/peer1/msp/keystore/key.pem

echo "Tworzenie struktury katalogów i certyfikatów dla peer2"
mkdir -p ${CONFIGURATION_PATH}/InsuranceProvider/peer2/assets/ca
cp ${CONFIGURATION_PATH}/InsuranceProvider/ca/admin/msp/cacerts/0-0-0-0-10054.pem ${CONFIGURATION_PATH}/InsuranceProvider/peer2/assets/ca/insurance-provider-ca-cert.pem

mkdir -p ${CONFIGURATION_PATH}/InsuranceProvider/peer2/assets/tls-ca
cp ${CONFIGURATION_PATH}/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem ${CONFIGURATION_PATH}/InsuranceProvider/peer2/assets/tls-ca/tls-ca-cert.pem

echo "tworzenie MSP dla peer2 InsuranceProvider"
export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/InsuranceProvider/peer2
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/InsuranceProvider/peer2/assets/ca/insurance-provider-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://peer2-insuranceProvider:peer2PW@0.0.0.0:10054
sleep 5

echo "tworzenie TLS dla peer2 InsuranceProvider"
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/InsuranceProvider/peer2/assets/tls-ca/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://peer2-insuranceProvider:peer2PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer2-insuranceprovider
sleep 5

echo "zapisanie admina dla InsuranceProvider"
export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/InsuranceProvider/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/InsuranceProvider/peer1/assets/ca/insurance-provider-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin-insuranceProvider:insuranceproviderAdminpw@0.0.0.0:10054
sleep 5

echo "zmiana nazw kluczy"
cp ${CONFIGURATION_PATH}/InsuranceProvider/peer2/tls-msp/keystore/*_sk ${CONFIGURATION_PATH}/InsuranceProvider/peer2/tls-msp/keystore/key.pem
cp ${CONFIGURATION_PATH}/InsuranceProvider/peer2/msp/keystore/*_sk ${CONFIGURATION_PATH}/InsuranceProvider/peer2/msp/keystore/key.pem

mkdir -p ${CONFIGURATION_PATH}/InsuranceProvider/peer1/msp/admincerts
cp ${CONFIGURATION_PATH}/InsuranceProvider/peer1/msp/signcerts/cert.pem ${CONFIGURATION_PATH}/InsuranceProvider/peer1/msp/admincerts/insurance-provider-admin-cert.pem

mkdir -p ${CONFIGURATION_PATH}/InsuranceProvider/peer2/msp/admincerts
cp ${CONFIGURATION_PATH}/InsuranceProvider/peer2/msp/signcerts/cert.pem ${CONFIGURATION_PATH}/InsuranceProvider/peer2/msp/admincerts/insurance-provider-admin-cert.pem

mkdir -p ${CONFIGURATION_PATH}/InsuranceProvider/admin/msp/admincerts
cp ${CONFIGURATION_PATH}/InsuranceProvider/admin/msp/signcerts/cert.pem ${CONFIGURATION_PATH}/InsuranceProvider/admin/msp/admincerts/insurance-provider-admin-cert.pem

echo "Tworzenie MSP dla InsuranceProvidera"
mkdir -p ${CONFIGURATION_PATH}/InsuranceProvider/msp/{cacerts,tlscacerts,admincerts}
echo "Kopiowanie certyfikatów"
cp ${CONFIGURATION_PATH}/InsuranceProvider/peer1/assets/ca/insurance-provider-ca-cert.pem ${CONFIGURATION_PATH}/InsuranceProvider/msp/cacerts/
cp ${CONFIGURATION_PATH}/InsuranceProvider/peer1/assets/tls-ca/tls-ca-cert.pem ${CONFIGURATION_PATH}/InsuranceProvider/msp/tlscacerts/
cp ${CONFIGURATION_PATH}/InsuranceProvider/admin/msp/signcerts/cert.pem ${CONFIGURATION_PATH}/InsuranceProvider/msp/admincerts/admin-insurance-provider-cert.pem
echo "InsuranceProvider done"
