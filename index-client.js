const fs = require('fs');
const key = fs.readFileSync('cert/server/localhost.decrypted.key');
const cert = fs.readFileSync('cert/server/localhost.crt');
const ca = fs.readFileSync('cert/ca/CA.pem')

const express = require('express');
const app = express();

app.get('/', (req, res, next) => {
  console.log('Hello')
  res.set('Access-Control-Allow-Origin', '*');
  res.status(200).send('Hello world!');
});

const https = require('https');
const server = https.createServer({ 
  key, cert, ca,
  requestCert: true, 
  rejectUnauthorized: true
}, app);

const port = 4000;
server.listen(port, () => {
  console.log(`Server is listening on https://localhost:${port}`);
});