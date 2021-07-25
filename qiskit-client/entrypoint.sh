#!/bin/bash

apt-get update && apt-get install -y jq curl

pip install qiskit

pip install qiskit[visualization]

# https://github.com/qiskit-community/qiskit_rng
pip install qiskit_rng

touch /opt/qiskit-client/ibm-quantum-provider.log

tail -f /opt/qiskit-client/ibm-quantum-provider.log