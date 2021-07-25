Node-RED: Low-code programming for event-driven applications.

multiple node-red istance per demo 1 per ogni quantum-op
where your Node-RED instance will store its data
If you deploy multiple instances of Node-RED from this repository, they will share the one Cloudant instance.

node-red flow
spreadsheet > Cloudant > node-red-quantum-op-1 > Cloudant > spreadsheet

quantum internet > istant computing big answers

## Run on Google Cloud Shell

[![Open this project in Cloud
Shell](http://gstatic.com/cloudssh/images/open-btn.png)](https://console.cloud.google.com/cloudshell/open?git_repo=https://github.com/alessandro-aglietti/quantum-exit.git&tutorial=gcp-shell-tutorial.md&shellonly=true)


## Run with secrets

Nel secrets/docker-compose-secrets.yml aggiungere environment `IBM_QUANTUM_EXPERIENCE_TOKEN` con il proprio token preso da https://quantum-computing.ibm.com/account.

`docker-compose -f docker-compose.yml -f secrets/docker-compose-secrets.yml up`
