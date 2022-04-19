#!/usr/bin/env bash

cd $(dirname $0)
BASE=$(pwd)
CERTS=${BASE}/certs

rm -rf $CERTS
mkdir -p $CERTS/ca
cd $CERTS

export CA_PASSWORD=12345678
export SERVER_PASSWORD=12345678

# CA certificate and key file generation 
openssl req \
	-newkey \
	rsa:4096 \
	-passout pass:${CA_PASSWORD} \
	-keyout $CERTS/ca/ca.key.pem \
	-x509 \
	-days 365 \
	-out $CERTS/ca/ca.crt.pem \
	-subj "/C=CN/ST=GD/L=Shenzhen/O=Apusic/OU=Development/CN=ca"

# Server certificate and key file generation 
openssl req \
	-newkey \
	rsa:4096 \
	-passout pass:${SERVER_PASSWORD} \
	-keyout $CERTS/server.key.pem  \
	-out $CERTS/server.csr \
	-subj "/C=CN/ST=GD/L=Shenzhen/O=Apusic/OU=Development/CN=server"

# Signing a server certificate with a CA certificate and key
openssl x509 \
	-req \
	-days 365 \
	-in $CERTS/server.csr \
	-CA $CERTS/ca/ca.crt.pem \
	-CAkey $CERTS/ca/ca.key.pem \
	-passin pass:${SERVER_PASSWORD} \
	-CAcreateserial \
	-out $CERTS/server.crt.pem

# Remove the cert request file (no longer needed)
rm $CERTS/server.csr
rm $CERTS/ca/ca.crt.srl

# PKCS8 processing of the server keys
openssl pkcs8 -topk8 \
	-v1 PBE-SHA1-RC4-128 \
	-in  $CERTS/server.key.pem \
      	-out $CERTS/server.key-pk8.pem \
       	-passout pass:${SERVER_PASSWORD} \
	-passin pass:${SERVER_PASSWORD}
