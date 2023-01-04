#!/bin/bash

function createCompanyA() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/companyA.solar.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/companyA.solar.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca-companyA --tls.certfiles "${PWD}/organizations/fabric-ca/companyA/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-companyA.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-companyA.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-companyA.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-companyA.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/companyA.solar.com/msp/config.yaml"

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-companyA --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/companyA/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering peer1"
  set -x
  fabric-ca-client register --caname ca-companyA --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/companyA/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-companyA --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/companyA/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-companyA --id.name companyAadmin --id.secret companyAadminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/companyA/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-companyA -M "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer0.companyA/msp" --csr.hosts peer0.companyA.solar.com --tls.certfiles "${PWD}/organizations/fabric-ca/companyA/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer0.companyA.solar.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-companyA -M "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer0.companyA.solar.com/tls" --enrollment.profile tls --csr.hosts peer0.companyA.solar.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/companyA/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer0.companyA.solar.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer0.companyA.solar.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer0.companyA.solar.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer0.companyA.solar.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer0.companyA.solar.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer0.companyA.solar.com/tls/server.key"

  mkdir -p "${PWD}/organizations/peerOrganizations/companyA.solar.com/msp/tlscacerts"
  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer0.companyA.solar.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/companyA.solar.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/companyA.solar.com/tlsca"
  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer0.companyA.solar.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/companyA.solar.com/tlsca/tlsca.companyA.solar.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/companyA.solar.com/ca"
  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer0.companyA.solar.com/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/companyA.solar.com/ca/ca.companyA.solar.com-cert.pem"


  infoln "Generating the peer1 msp"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca-companyA -M "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer1.companyA.solar.com/msp" --csr.hosts peer1.companyA.solar.com --tls.certfiles "${PWD}/organizations/fabric-ca/companyA/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer1.companyA.solar.com/msp/config.yaml"

  infoln "Generating the peer1-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca-companyA -M "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer1.companyA.solar.com/tls" --enrollment.profile tls --csr.hosts peer1.companyA.solar.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/companyA/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer1.companyA.solar.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer1.companyA.solar.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer1.companyA.solar.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer1.companyA.solar.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer1.companyA.solar.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer1.companyA.solar.com/tls/server.key"

  mkdir -p "${PWD}/organizations/peerOrganizations/companyA.solar.com/msp/tlscacerts"
  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer1.companyA.solar.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/companyA.solar.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/companyA.solar.com/tlsca"
  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer1.companyA.solar.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/companyA.solar.com/tlsca/tlsca.companyA.solar.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/companyA.solar.com/ca"
  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/peers/peer1.companyA.solar.com/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/companyA.solar.com/ca/ca.companyA.solar.com-cert.pem"


  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca-companyA -M "${PWD}/organizations/peerOrganizations/companyA.solar.com/users/User1@companyA.solar.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/companyA/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/companyA.solar.com/users/User1@companyA.solar.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://companyAadmin:companyAadminpw@localhost:7054 --caname ca-companyA -M "${PWD}/organizations/peerOrganizations/companyA.solar.com/users/Admin@companyA.solar.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/companyA/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/companyA.solar.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/companyA.solar.com/users/Admin@companyA.solar.com/msp/config.yaml"
}

function createCompanyB() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/companyB.solar.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/companyB.solar.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca-companyB --tls.certfiles "${PWD}/organizations/fabric-ca/logistica/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-companyB.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-companyB.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-companyB.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-companyB.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/companyB.solar.com/msp/config.yaml"

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-companyB --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/logistica/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-companyB --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/logistica/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-companyB --id.name logisticaadmin --id.secret logisticaadminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/logistica/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-companyB -M "${PWD}/organizations/peerOrganizations/companyB.solar.com/peers/peer0.companyB.solar.com/msp" --csr.hosts peer0.companyB.solar.com --tls.certfiles "${PWD}/organizations/fabric-ca/logistica/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/companyB.solar.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/companyB.solar.com/peers/peer0.companyB.solar.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-companyB -M "${PWD}/organizations/peerOrganizations/companyB.solar.com/peers/peer0.companyB.solar.com/tls" --enrollment.profile tls --csr.hosts peer0.companyB.solar.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/logistica/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/companyB.solar.com/peers/peer0.companyB.solar.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/companyB.solar.com/peers/peer0.companyB.solar.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/companyB.solar.com/peers/peer0.companyB.solar.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/companyB.solar.com/peers/peer0.companyB.solar.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/companyB.solar.com/peers/peer0.companyB.solar.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/companyB.solar.com/peers/peer0.companyB.solar.com/tls/server.key"

  mkdir -p "${PWD}/organizations/peerOrganizations/companyB.solar.com/msp/tlscacerts"
  cp "${PWD}/organizations/peerOrganizations/companyB.solar.com/peers/peer0.companyB.solar.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/companyB.solar.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/companyB.solar.com/tlsca"
  cp "${PWD}/organizations/peerOrganizations/companyB.solar.com/peers/peer0.companyB.solar.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/companyB.solar.com/tlsca/tlsca.companyB.solar.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/companyB.solar.com/ca"
  cp "${PWD}/organizations/peerOrganizations/companyB.solar.com/peers/peer0.companyB.solar.com/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/companyB.solar.com/ca/ca.companyB.solar.com-cert.pem"

  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca-companyB -M "${PWD}/organizations/peerOrganizations/companyB.solar.com/users/User1@companyB.solar.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/logistica/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/companyB.solar.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/companyB.solar.com/users/User1@companyB.solar.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://logisticaadmin:logisticaadminpw@localhost:8054 --caname ca-companyB -M "${PWD}/organizations/peerOrganizations/companyB.solar.com/users/Admin@companyB.solar.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/logistica/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/companyB.solar.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/companyB.solar.com/users/Admin@companyB.solar.com/msp/config.yaml"
}

function createComprador() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/comprador.solar.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/comprador.solar.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:10054 --caname ca-comprador --tls.certfiles "${PWD}/organizations/fabric-ca/delivery/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-comprador.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-comprador.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-comprador.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-comprador.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/comprador.solar.com/msp/config.yaml"

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-comprador --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/delivery/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-comprador --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/delivery/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-comprador --id.name deliveryadmin --id.secret deliveryadminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/delivery/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca-comprador -M "${PWD}/organizations/peerOrganizations/comprador.solar.com/peers/peer0.comprador.solar.com/msp" --csr.hosts peer0.comprador.solar.com --tls.certfiles "${PWD}/organizations/fabric-ca/delivery/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/comprador.solar.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/comprador.solar.com/peers/peer0.comprador.solar.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca-comprador -M "${PWD}/organizations/peerOrganizations/comprador.solar.com/peers/peer0.comprador.solar.com/tls" --enrollment.profile tls --csr.hosts peer0.comprador.solar.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/delivery/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/comprador.solar.com/peers/peer0.comprador.solar.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/comprador.solar.com/peers/peer0.comprador.solar.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/comprador.solar.com/peers/peer0.comprador.solar.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/comprador.solar.com/peers/peer0.comprador.solar.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/comprador.solar.com/peers/peer0.comprador.solar.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/comprador.solar.com/peers/peer0.comprador.solar.com/tls/server.key"

  mkdir -p "${PWD}/organizations/peerOrganizations/comprador.solar.com/msp/tlscacerts"
  cp "${PWD}/organizations/peerOrganizations/comprador.solar.com/peers/peer0.comprador.solar.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/comprador.solar.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/comprador.solar.com/tlsca"
  cp "${PWD}/organizations/peerOrganizations/comprador.solar.com/peers/peer0.comprador.solar.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/comprador.solar.com/tlsca/tlsca.comprador.solar.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/comprador.solar.com/ca"
  cp "${PWD}/organizations/peerOrganizations/comprador.solar.com/peers/peer0.comprador.solar.com/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/comprador.solar.com/ca/ca.comprador.solar.com-cert.pem"

  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:10054 --caname ca-comprador -M "${PWD}/organizations/peerOrganizations/comprador.solar.com/users/User1@comprador.solar.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/delivery/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/comprador.solar.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/comprador.solar.com/users/User1@comprador.solar.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://deliveryadmin:deliveryadminpw@localhost:10054 --caname ca-comprador -M "${PWD}/organizations/peerOrganizations/comprador.solar.com/users/Admin@comprador.solar.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/delivery/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/comprador.solar.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/comprador.solar.com/users/Admin@comprador.solar.com/msp/config.yaml"
}


function createOrderer() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/ordererOrganizations/farma.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/farma.com

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/ordererOrganizations/farma.com/msp/config.yaml"

  infoln "Registering orderer"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the orderer admin"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the orderer msp"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/farma.com/orderers/orderer.farma.com/msp" --csr.hosts orderer.farma.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/ordererOrganizations/farma.com/msp/config.yaml" "${PWD}/organizations/ordererOrganizations/farma.com/orderers/orderer.farma.com/msp/config.yaml"

  infoln "Generating the orderer-tls certificates"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/farma.com/orderers/orderer.farma.com/tls" --enrollment.profile tls --csr.hosts orderer.farma.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/ordererOrganizations/farma.com/orderers/orderer.farma.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/farma.com/orderers/orderer.farma.com/tls/ca.crt"
  cp "${PWD}/organizations/ordererOrganizations/farma.com/orderers/orderer.farma.com/tls/signcerts/"* "${PWD}/organizations/ordererOrganizations/farma.com/orderers/orderer.farma.com/tls/server.crt"
  cp "${PWD}/organizations/ordererOrganizations/farma.com/orderers/orderer.farma.com/tls/keystore/"* "${PWD}/organizations/ordererOrganizations/farma.com/orderers/orderer.farma.com/tls/server.key"

  mkdir -p "${PWD}/organizations/ordererOrganizations/farma.com/orderers/orderer.farma.com/msp/tlscacerts"
  cp "${PWD}/organizations/ordererOrganizations/farma.com/orderers/orderer.farma.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/farma.com/orderers/orderer.farma.com/msp/tlscacerts/tlsca.farma.com-cert.pem"

  mkdir -p "${PWD}/organizations/ordererOrganizations/farma.com/msp/tlscacerts"
  cp "${PWD}/organizations/ordererOrganizations/farma.com/orderers/orderer.farma.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/farma.com/msp/tlscacerts/tlsca.farma.com-cert.pem"

  infoln "Generating the admin msp"
  set -x
  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/farma.com/users/Admin@farma.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/ordererOrganizations/farma.com/msp/config.yaml" "${PWD}/organizations/ordererOrganizations/farma.com/users/Admin@farma.com/msp/config.yaml"
}
