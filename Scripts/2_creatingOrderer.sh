echo "rejestracja użytkowników dla Orderera"
export FABRIC_CA_CLIENT_TLS_CERTFILES=${CONFIGURATION_PATH}/Orderer/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=${CONFIGURATION_PATH}/Orderer/ca/admin
fabric-ca-client enroll -d -u https://admin:adminpw@0.0.0.0:7054
sleep 5
fabric-ca-client register -d --id.name orderer --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7054
echo "rejestracja Admina dla Orderera"
fabric-ca-client register -d --id.name admin-orderer --id.secret ordererAdminpw --id.type admin --id.attrs "hf.Registrar.Roles=client,hf.Registrar.Attributes=*,hf.Revoker=true,hf.GenCRL=true,admin=true:ecert,abac.init=true:ecert" -u https://0.0.0.0:7054

echo
fabric-ca-client identity list
