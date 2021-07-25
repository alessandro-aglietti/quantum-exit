#!/bin/bash

# URL API a caso
# https://github.com/Qiskit/qiskit-ibmq-provider/blob/1416d6de30dbf67ab9793b05a2593cc79478ccdf/qiskit/providers/ibmq/credentials/updater.py#L22-L28
# QE_URL = 'https://quantumexperience.ng.bluemix.net/api'
# QCONSOLE_URL = 'https://q-console-api.mybluemix.net/api'
QE2_URL='https://api.quantum-computing.ibm.com/api'
# QCONSOLE2_URL = 'https://api-qcon.quantum-computing.ibm.com/api'
QE2_AUTH_URL='https://auth.quantum-computing.ibm.com/api'

echo -e "\n"
echo "Auth on $QE2_AUTH_URL..."
# https://github.com/Qiskit/qiskit-ibmq-provider/blob/1416d6de30dbf67ab9793b05a2593cc79478ccdf/qiskit/providers/ibmq/api/rest/root.py#L124-L125
curl \
    -s \
    -X POST \
    -H 'Content-Type: application/json' \
    --data-binary "{\"apiToken\":\"$IBM_QUANTUM_EXPERIENCE_TOKEN\"}" \
    "$QE2_AUTH_URL/users/loginWithToken" | jq '.' > loginWithToken.response.json


# "id" e' l'access token...
# https://github.com/Qiskit/qiskit-ibmq-provider/blob/1416d6de30dbf67ab9793b05a2593cc79478ccdf/qiskit/providers/ibmq/api/clients/auth.py#L74-L76
ACCESS_TOKEN=`cat loginWithToken.response.json | jq -r '.id'`

echo -e "\n"
echo "###############################"
echo "Access token: $ACCESS_TOKEN"
echo "###############################"

# recupero dettagli sull'utente
# Usano header custom X-Access-Token
# https://github.com/Qiskit/qiskit-ibmq-provider/blob/06e557b6245b1baf6865aee2a7dea5db6f301317/qiskit/providers/ibmq/api/session.py#L179
curl \
    -s \
    -H  "Accept: application/json" \
    -H  "X-Access-Token: $ACCESS_TOKEN" \
    "$QE2_URL/users/me" | jq '.' > users-me.response.json

USER_ID=`cat users-me.response.json | jq -r '.id'`
USER_EMAIL=`cat users-me.response.json | jq -r '.email'`
USER_CREDITS=`cat users-me.response.json | jq -r '.credit.credits'`


echo -e "\n"
echo "###############################"
echo "User id $USER_ID ($USER_EMAIL) with credits $USER_CREDITS"
echo "###############################"

# I parametri della API /jobs sono stati dedotti dal file Near-Time-Compute.v1.yaml
# preso da https://runtime-us-east.quantum-computing.ibm.com/static/Near-Time-Compute.v1.yaml
# la swagger UI https://runtime-us-east.quantum-computing.ibm.com/openapi/#/default/logout
# purtroppo lo swagger online non risulta aggiornato rispetto al flusso che utilizza Qiskit perche'
# 1) non supporta la loginWithToken di cui sopra
# 2) usa runtime-us-east.quantum-computing.ibm.com come QE2_URL
# 3) usa Authorization: Bearer ${token} invece che X-Access-Token

curl \
    -s \
    -H  "Accept: application/json" \
    -H  "X-Access-Token: $ACCESS_TOKEN" \
    "$QE2_URL/jobs?limit=200&pending=false" | jq '.' > jobs-completed-get.response.json

# Last job result and logs
LAST_JOB_ID=`cat jobs-completed-get.response.json | jq -r '.[0].id'`

echo -e "\n"
echo "###############################"
echo "LAST_JOB_ID $LAST_JOB_ID"
echo "###############################"

# https://github.com/Qiskit/qiskit-ibmq-provider/blob/1416d6de30dbf67ab9793b05a2593cc79478ccdf/qiskit/providers/ibmq/api/rest/job.py#L39
curl \
    -s \
    -H  "Accept: application/json" \
    -H  "X-Access-Token: $ACCESS_TOKEN" \
    "$QE2_URL/Jobs/$LAST_JOB_ID/v/1" | jq '.' > last-job-v-1.response.json

curl \
    -s \
    -H  "Accept: application/json" \
    -H  "X-Access-Token: $ACCESS_TOKEN" \
    "$QE2_URL/Jobs/$LAST_JOB_ID/resultDownloadUrl" | jq '.' > last-job-result-url.response.json

LAST_JOB_RESULT_URL=`cat last-job-result-url.response.json | jq -r '.url'`

curl -s "$LAST_JOB_RESULT_URL" | jq '.' > last-job-result.response.json

echo -e "\n"
echo "In last-job-result.response.json si trova l'equivalente di https://quantum-computing.ibm.com/jobs/$LAST_JOB_ID"
