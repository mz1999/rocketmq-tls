#!/usr/bin/env bash

cd $(dirname $0)
BASE=$(pwd)
CERTS=${BASE}/certs

CONFDIR=${BASE}/rocketmq
CONFFILE=${CONFDIR}/tls.properties
rm -rf ${CONFDIR}
mkdir ${CONFDIR}

## server conf
SERVER_PASSWORD=12345678
touch ${CONFFILE}
echo "tls.server.mode=enforcing" >> ${CONFFILE}
echo "tls.test.mode.enable=false" >> ${CONFFILE}
echo "tls.server.certPath=${CERTS}/server.crt.pem" >> ${CONFFILE}
echo "tls.server.keyPath=${CERTS}/server.key-pk8.pem" >> ${CONFFILE}
echo "tls.server.keyPassword=${SERVER_PASSWORD}" >> ${CONFFILE}
echo "tls.server.trustCertPath=${CERTS}/ca/ca.crt.pem" >> ${CONFFILE}
echo "tls.server.need.client.auth=none" >> ${CONFFILE}
