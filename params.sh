#!/bin/bash

export MINIMAL_TENANT_1="${MINIMAL_TENANT_1:=DEFAULT}"
export MINIMAL_TENANT_2="${MINIMAL_TENANT_2:=DEFAULT}"
export MINIMAL_TENANT_3="${MINIMAL_TENANT_3:=DEFAULT}"

export MINIO_IDENTITY_OPENID_CLIENT_ID="${MINIO_IDENTITY_OPENID_CLIENT_ID:=default}"
export MINIO_IDENTITY_OPENID_CONFIG_URL="${MINIO_IDENTITY_OPENID_CONFIG_URL:-default}"
export CONFIG_FILE="${CONFIG_FILE:-instances/base/minio.yaml}"

envsubst < instances/minimal/tenant1/secret.tmpl > instances/minimal/tenant1/secret.txt
envsubst < instances/minimal/tenant2/secret.tmpl > instances/minimal/tenant2/secret.txt
envsubst < instances/minimal/tenant3/secret.tmpl > instances/minimal/tenant3/secret.txt

yq -d2 w -i ${CONFIG_FILE} 'spec.env[2].value' ${MINIO_IDENTITY_OPENID_CLIENT_ID}
yq -d2 w -i ${CONFIG_FILE} 'spec.env[3].value' ${MINIO_IDENTITY_OPENID_CONFIG_URL}
