echo "Zapis HospitalB"
echo "Tworzenie struktury katalogów i certyfikatów dla peer1"
mkdir -p ${CONFIGURATION_PATH}/HospitalB/peer1/assets/ca
cp ${CONFIGURATION_PATH}/HospitalB/ca/admin/msp/cacerts/0-0-0-0-9054.pem ${CONFIGURATION_PATH}/HospitalB/peer1/assets/ca/hospitalb-ca-cert.pem

mkdir -p ${CONFIGURATION_PATH}/HospitalB/peer1/assets/tls-ca
cp ${CONFIGURATION_PATH}/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem ${CONFIGURATION_PATH}/HospitalB/peer1/assets/tls-ca/tls-ca-cert.pem

echo "tworzenie MSP dla peer1 HospitalB"
export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/HospitalB/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/HospitalB/peer1/assets/ca/hospitalb-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-hospitalb:peer1PW@0.0.0.0:9054
sleep 5

echo "tworzenie TLS dla peer1 HospitalB"
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/HospitalB/peer1/assets/tls-ca/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://peer1-hospitalB:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-hospitalb
sleep 5

echo "zmiana nazw kluczy"
cp ${CONFIGURATION_PATH}/HospitalB/peer1/tls-msp/keystore/*_sk ${CONFIGURATION_PATH}/HospitalB/peer1/tls-msp/keystore/key.pem
cp ${CONFIGURATION_PATH}/HospitalB/peer1/msp/keystore/*_sk ${CONFIGURATION_PATH}/HospitalB/peer1/msp/keystore/key.pem

echo "Tworzenie struktury katalogów i certyfikatów dla peer2"
mkdir -p ${CONFIGURATION_PATH}/HospitalB/peer2/assets/ca
cp ${CONFIGURATION_PATH}/HospitalB/ca/admin/msp/cacerts/0-0-0-0-9054.pem ${CONFIGURATION_PATH}/HospitalB/peer2/assets/ca/hospitalb-ca-cert.pem

mkdir -p ${CONFIGURATION_PATH}/HospitalB/peer2/assets/tls-ca
cp ${CONFIGURATION_PATH}/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem ${CONFIGURATION_PATH}/HospitalB/peer2/assets/tls-ca/tls-ca-cert.pem

echo "tworzenie MSP dla peer2 HospitalB"
export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/HospitalB/peer2
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/HospitalB/peer2/assets/ca/hospitalb-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer2-hospitalb:peer2PW@0.0.0.0:9054
sleep 5

echo "tworzenie TLS dla peer2 HospitalB"
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/HospitalB/peer2/assets/tls-ca/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://peer2-hospitalB:peer2PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer2-hospitalb
sleep 5

echo "zmiana nazw kluczy"
cp ${CONFIGURATION_PATH}/HospitalB/peer2/tls-msp/keystore/*_sk ${CONFIGURATION_PATH}/HospitalB/peer2/tls-msp/keystore/key.pem
cp ${CONFIGURATION_PATH}/HospitalB/peer2/msp/keystore/*_sk ${CONFIGURATION_PATH}/HospitalB/peer2/msp/keystore/key.pem

echo "zapisanie admina dla HospitalB"
export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/HospitalB/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/HospitalB/peer1/assets/ca/hospitalb-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin-hospitalb:hospitalbAdminpw@0.0.0.0:9054

mkdir -p ${CONFIGURATION_PATH}/HospitalB/peer1/msp/admincerts
cp ${CONFIGURATION_PATH}/HospitalB/peer1/msp/signcerts/cert.pem ${CONFIGURATION_PATH}/HospitalB/peer1/msp/admincerts/hospitalb-admin-cert.pem

mkdir -p ${CONFIGURATION_PATH}/HospitalB/peer2/msp/admincerts
cp ${CONFIGURATION_PATH}/HospitalB/peer2/msp/signcerts/cert.pem ${CONFIGURATION_PATH}/HospitalB/peer2/msp/admincerts/hospitalb-admin-cert.pem

mkdir -p ${CONFIGURATION_PATH}/HospitalB/admin/msp/admincerts
cp ${CONFIGURATION_PATH}/HospitalB/admin/msp/signcerts/cert.pem ${CONFIGURATION_PATH}/HospitalB/admin/msp/admincerts/hospitalb-admin-cert.pem

echo "Tworzenie MSP dla HospitalB"
mkdir -p ${CONFIGURATION_PATH}/HospitalB/msp/{cacerts,tlscacerts,admincerts}
echo "Kopiowanie certyfikatów"
cp ${CONFIGURATION_PATH}/HospitalB/peer1/assets/ca/hospitala-ca-cert.pem ${CONFIGURATION_PATH}/HospitalB/msp/cacerts/
cp ${CONFIGURATION_PATH}/HospitalB/peer1/assets/tls-ca/tls-ca-cert.pem ${CONFIGURATION_PATH}/HospitalB/msp/tlscacerts/
cp ${CONFIGURATION_PATH}/HospitalB/admin/msp/signcerts/cert.pem ${CONFIGURATION_PATH}/HospitalB/msp/admincerts/admin-hospitalb-cert.pem
echo "HospitalB done"
