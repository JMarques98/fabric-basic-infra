# fabric-basic-infra

## BORRAMOS TODO LO QUE TENGAMOS PREVIO

```bash
  docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker volume prune
docker network prune

sudo rm -rf organizations/peerOrganizations
sudo rm -rf organizations/ordererOrganizations
sudo rm -rf channel-artifacts/
mkdir channel-artifacts
```


## LEVANTAMOS TODAS LAS CAS
```bash
docker-compose -f docker/docker-compose-solarproject-ca.yaml up -d
```

## REALIZAMOS LOS EXPORTS DE BIN Y CONFIGTX PARA DETECTAR LOS COMANDOS A UTILIZAR

```bash
export PATH=${PWD}/bin:${PWD}:$PATH
export FABRIC_CFG_PATH=${PWD}/configtx
```

## CREAMOS LOS CERTIFICADOS CONTRA LA CA, PODEMOS MODIFICAR EL REGISTER AND ENROLL Y ADAPTARLO AL PROYECTO QUE QUERAMOS
## EN EL SCRIPT SE POBLA CON CERTIFICADOS TODO NUESTRO FILE SYSTEM

```bash
vi organizations/fabric-ca/registerEnrollSolarProject.sh
```

## CON LOS SCRITPS QUE SE TIENEN CADA UNO ATACA A UNA CA Y GENERA LOS CERTIFICADOS

```bash
. ./organizations/fabric-ca/registerEnrollSolarProject.sh && createCompanyA
. ./organizations/fabric-ca/registerEnrollSolarProject.sh && createCompanyB
. ./organizations/fabric-ca/registerEnrollSolarProject.sh && createComprador
. ./organizations/fabric-ca/registerEnrollSolarProject.sh && createOrderer
```


## DA UN ERRROR 
Error: Response from server: Error Code: 19 - CA 'ca-companyA' does not exist