#!/bin/bash

# Minio Default Credentials
export MINIMAL_TENANT_1="${MINIMAL_TENANT_1:=DEFAULT}"
export PREMIUM_TENANT_1="${PREMIUM_TENANT_1:=DEFAULT}"

envsubst < instances/minimal/tenant1/secret.tmpl > instances/minimal/tenant1/secret.txt
envsubst < instances/premium/tenant1/secret.tmpl > instances/premium/tenant1/secret.txt

# Minio OIDC
export MINIO_IDENTITY_OPENID_CLIENT_ID="${MINIO_IDENTITY_OPENID_CLIENT_ID:=default}"
export MINIO_IDENTITY_OPENID_CONFIG_URL="${MINIO_IDENTITY_OPENID_CONFIG_URL:-default}"
export CONFIG_FILE="${CONFIG_FILE:-instances/base/minio.yaml}"
yq -d3 w -i ${CONFIG_FILE} 'spec.env[2].value' ${MINIO_IDENTITY_OPENID_CLIENT_ID}
yq -d3 w -i ${CONFIG_FILE} 'spec.env[3].value' ${MINIO_IDENTITY_OPENID_CONFIG_URL}

# Minio Domain
export MINIO_DOMAIN_NAME="${MINIO_DOMAIN_NAME:=default.example.ca}"
for patch in instances/*/tenant*/patch-ing*; do
  val=$(yq r $patch '[0].value')
  yq w -i $patch '[0].value' ${val/example.ca/$MINIO_DOMAIN_NAME}
done
