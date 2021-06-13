#!/bin/bash

mkdir -p $NODE_RED_STARTUP_DIR
cd $NODE_RED_STARTUP_DIR

echo "################## COPY package.json, settings.js, flows_cred.json and flows.json"
cat /opt/data/settings.js > ./settings.js
cat /opt/data/flows_cred.json > ./flows_cred.json
cat /opt/data/flows.json > ./flows.json
cat /opt/data/package.json > ./package.json


echo "################## npm install"
npm install

echo "################## chown node"
chown -R node:node .

echo "################## exports"
export NODE_RED_USER_DIR=/opt/data/node-red-user-dir
export NODE_RED_SETTINGS=$NODE_RED_STARTUP_DIR/settings.js
export NODE_RED_FLOWS=$NODE_RED_STARTUP_DIR/flows.json
env | grep NODE_RED

echo "################## npm start"
npm start
