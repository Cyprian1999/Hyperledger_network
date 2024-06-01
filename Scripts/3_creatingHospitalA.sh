echo "rejestracja użytkowników dla HospitalA"
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/HospitalA/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/HospitalA/ca/admin
fabric-ca-client enroll -d -u https://admin:adminpw@0.0.0.0:8054
sleep 5
fabric-ca-client register -d --id.name peer1-hospitala --id.secret peer1PW --id.type peer -u https://0.0.0.0:8054
fabric-ca-client register -d --id.name peer2-hospitala --id.secret peer2PW --id.type peer -u https://0.0.0.0:8054
echo "rejestracja Admina dla HospitalA"
fabric-ca-client register -d --id.name admin-hospitala --id.secret hospitalaAdminpw --id.type admin -u https://0.0.0.0:8054
fabric-ca-client register -d --id.name user-hospitala --id.secret hospitalaUserpw --id.type user -u https://0.0.0.0:8054

echo
fabric-ca-client identity list
