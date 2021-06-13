# Quantum playground!!!
Avviando questo tutorial verrai guidato nei primi passi che ti consentiranno di

- bootstrap nodi Node-RED
- utilizzo di Node-RED
- eseguire il backup dei flussi Node-RED

## Next step: bootstrap nodi Node-RED

## bootstrap nodi Node-RED

Attendere il messaggio "Started flows" del seguente comando
```sh
chmod +x ./data/*.sh && docker-compose up
```
Click <walkthrough-web-preview-icon></walkthrough-web-preview-icon> and change
the preview port to 21880.

## utilizzo di Node-RED

Proseguire su https://sites.google.com/view/quantum-exit per indicazioni sull'utilizzo dell'ambiente Node-RED.

## eseguire il backup dei flussi Node-RED
Dall'interfaccia di Node-RED selezionare il tab "backup node-red flows".

Cliccare il pulsante quadrato grigio del nodo "timestamp".

Adesso dobbiamo estrarre il contentuto di alcuni file da questo ambiente Cloud Shell effimero.

- <walkthrough-editor-open-file filePath="data/flows.json">data/flows.json</walkthrough-editor-open-file>
- <walkthrough-editor-open-file filePath="data/flows_cred.json">data/flows_cred.json</walkthrough-editor-open-file>
- <walkthrough-editor-open-file filePath="data/package.json">data/package.json</walkthrough-editor-open-file>
- <walkthrough-editor-open-file filePath="data/package.json">data/settings.js</walkthrough-editor-open-file>