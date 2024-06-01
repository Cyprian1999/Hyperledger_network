echo "rejestracja użytkoników dla Insurance Provider"
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/InsuranceProvider/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/InsuranceProvider/ca/admin
fabric-ca-client enroll -d -u https://admin:adminpw@0.0.0.0:10054
sleep 5
fabric-ca-client register -d --id.name peer1-insuranceProvider --id.secret peer1PW --id.type peer -u https://0.0.0.0:10054
fabric-ca-client register -d --id.name peer2-insuranceProvider --id.secret peer2PW --id.type peer -u https://0.0.0.0:10054
echo "rejestracja Admina dla Insurance Provider"
fabric-ca-client register -d --id.name admin-insuranceProvider --id.secret insuranceproviderAdminpw --id.type admin -u https://0.0.0.0:10054
fabric-ca-client register -d --id.name user-insuranceProvider --id.secret insuranceProviderUserow --id.type user -u https://0.0.0.0:10054

echo
fabric-ca-client identity list
