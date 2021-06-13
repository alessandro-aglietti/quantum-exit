#!/bin/bash

echo "################## BACKUP package.json, settings.js, flows_cred.json and flows.json"
cat $NODE_RED_STARTUP_DIR/settings.js > /opt/data/settings.js
cat $NODE_RED_STARTUP_DIR/package.json > /opt/data/package.json
cat $NODE_RED_STARTUP_DIR/flows.json > /opt/data/flows.json
cat $NODE_RED_STARTUP_DIR/flows_cred.json > /opt/data/flows_cred.json