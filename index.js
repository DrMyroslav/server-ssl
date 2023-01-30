const fs = require('fs');
const key = fs.readFileSync('cert/server/localhost.decrypted.key');
const cert = fs.readFileSync('cert/server/localhost.crt');

const express = require('express');
const app = express();

app.get('/', (req, res, next) => {
  res.status(200).send('Hello world!');
});

const https = require('https');
const server = https.createServer({ key, cert }, app);

const port = 4000;
server.listen(port, () => {
  console.log(`Server is listening on https://localhost:${port}`);
});