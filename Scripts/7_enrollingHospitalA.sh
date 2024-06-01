echo "Zapis HospitalA"
echo "Tworzenie struktury katalogów i certyfikatów dla peer2"
mkdir -p ${CONFIGURATION_PATH}/HospitalA/peer1/assets/ca
cp ${CONFIGURATION_PATH}/HospitalA/ca/admin/msp/cacerts/0-0-0-0-8054.pem ${CONFIGURATION_PATH}/HospitalA/peer1/assets/ca/hospitala-ca-cert.pem

mkdir -p ${CONFIGURATION_PATH}/HospitalA/peer1/assets/tls-ca
cp ${CONFIGURATION_PATH}/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem ${CONFIGURATION_PATH}/HospitalA/peer1/assets/tls-ca/tls-ca-cert.pem

echo "tworzenie MSP dla peer1 HospitalA"
export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/HospitalA/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/HospitalA/peer1/assets/ca/hospitala-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-hospitala:peer1PW@0.0.0.0:8054
sleep 5

echo "tworzenie TLS dla peer1 HospitalA"
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/HospitalA/peer1/assets/tls-ca/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://peer1-hospitalA:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-hospitala
sleep 5

echo "zmiana nazwy kluczy"
cp ${CONFIGURATION_PATH}/HospitalA/peer1/tls-msp/keystore/*_sk ${CONFIGURATION_PATH}/HospitalA/peer1/tls-msp/keystore/key.pem
cp ${CONFIGURATION_PATH}/HospitalA/peer1/msp/keystore/*_sk ${CONFIGURATION_PATH}/HospitalA/peer1/msp/keystore/key.pem

echo "Tworzenie struktury katalogów i certyfikatów dla peer2"
mkdir -p ${CONFIGURATION_PATH}/HospitalA/peer2/assets/ca
cp ${CONFIGURATION_PATH}/HospitalA/ca/admin/msp/cacerts/0-0-0-0-8054.pem ${CONFIGURATION_PATH}/HospitalA/peer2/assets/ca/hospitala-ca-cert.pem

mkdir -p ${CONFIGURATION_PATH}/HospitalA/peer2/assets/tls-ca
cp ${CONFIGURATION_PATH}/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem ${CONFIGURATION_PATH}/HospitalA/peer2/assets/tls-ca/tls-ca-cert.pem

echo "tworzenie MSP dla peer2 HospitalA"
export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/HospitalA/peer2
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/HospitalA/peer2/assets/ca/hospitala-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer2-hospitala:peer2PW@0.0.0.0:8054
sleep 5

echo "tworzenie TLS dla peer2 HospitalA"
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/HospitalA/peer2/assets/tls-ca/tls-ca-cert.pem
fabric-ca-client enroll -d -u https://peer2-hospitalA:peer2PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer2-hospitala
sleep 5

echo "zmiana nazwy kluczy"
cp ${CONFIGURATION_PATH}/HospitalA/peer2/tls-msp/keystore/*_sk ${CONFIGURATION_PATH}/HospitalA/peer2/tls-msp/keystore/key.pem
cp ${CONFIGURATION_PATH}/HospitalA/peer2/msp/keystore/*_sk ${CONFIGURATION_PATH}/HospitalA/peer2/msp/keystore/key.pem

echo "zapisanie admina dla HospitalA"
export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/HospitalA/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/HospitalA/peer1/assets/ca/hospitala-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp
fabric-ca-client enroll -d -u https://admin-hospitala:hospitalaAdminpw@0.0.0.0:8054

mkdir -p ${CONFIGURATION_PATH}/HospitalA/peer1/msp/admincerts
cp ${CONFIGURATION_PATH}/HospitalA/peer1/msp/signcerts/cert.pem ${CONFIGURATION_PATH}/HospitalA/peer1/msp/admincerts/hospitala-admin-cert.pem

mkdir -p ${CONFIGURATION_PATH}/HospitalA/peer2/msp/admincerts
cp ${CONFIGURATION_PATH}/HospitalA/peer2/msp/signcerts/cert.pem ${CONFIGURATION_PATH}/HospitalA/peer2/msp/admincerts/hospitala-admin-cert.pem

mkdir -p ${CONFIGURATION_PATH}/HospitalA/admin/msp/admincerts
cp ${CONFIGURATION_PATH}/HospitalA/admin/msp/signcerts/cert.pem ${CONFIGURATION_PATH}/HospitalA/admin/msp/admincerts/hospitala-admin-cert.pem

echo "Tworzenie MSP dla HospitalA"
mkdir -p ${CONFIGURATION_PATH}/HospitalA/msp/{cacerts,tlscacerts,admincerts}
echo "Kopiowanie certyfikatów"
cp ${CONFIGURATION_PATH}/HospitalA/peer1/assets/ca/hospitala-ca-cert.pem ${CONFIGURATION_PATH}/HospitalA/msp/cacerts/
cp ${CONFIGURATION_PATH}/HospitalA/peer1/assets/tls-ca/tls-ca-cert.pem ${CONFIGURATION_PATH}/HospitalA/msp/tlscacerts/
cp ${CONFIGURATION_PATH}/HospitalA/admin/msp/signcerts/cert.pem ${CONFIGURATION_PATH}/HospitalA/msp/admincerts/admin-hospitala-cert.pem
echo "HospitalA done"
