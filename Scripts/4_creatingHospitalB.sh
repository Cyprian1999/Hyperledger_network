echo "rejestracja użytkowników dla HospitalB"
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/HospitalB/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/HospitalB/ca/admin
fabric-ca-client enroll -d -u https://admin:adminpw@0.0.0.0:9054
sleep 5
fabric-ca-client register -d --id.name peer1-hospitalb --id.secret peer1PW --id.type peer -u https://0.0.0.0:9054
fabric-ca-client register -d --id.name peer2-hospitalb --id.secret peer2PW --id.type peer -u https://0.0.0.0:9054
echo "rejestracja Admina dla HospitalB"
fabric-ca-client register -d --id.name admin-hospitalb --id.secret hospitalbAdminpw --id.type admin -u https://0.0.0.0:9054
fabric-ca-client register -d --id.name user-hospitalb --id.secret hospitalbUserpw --id.type user -u https://0.0.0.0:9054

echo
fabric-ca-client identity list
