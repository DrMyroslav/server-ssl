openssl genrsa -out CA.key -des3 2048

openssl req -x509 -sha256 -new -nodes -days 3650 -key CA.key -out CA.pem

openssl genrsa -out localhost.key -des3 2048

openssl req -new -key localhost.key -out localhost.csr

openssl x509 -req -in localhost.csr -CA CA.pem -CAkey CA.key -CAcreateserial -days 3650 -sha256 -extfile localhost.ext -out localhost.crt

openssl rsa -in localhost.key -out localhost.decrypted.key

# from pem to pk12
# openssl pkcs12 -export -out Cert.p12 -in CA.pem -inkey CA.key -passin pass:test -passout pass:test


openssl genrsa -out client.key 4096

openssl req -new -key client.key -out client.csr -sha256 -subj '/CN=Local Test Client'


openssl x509 -req -days 750 -in client.csr -sha256 -CA CA.pem -CAkey CA.key -CAcreateserial -out client.crt -extfile client.cnf -extensions client


openssl pkcs12 -export -out client.pfx -inkey client.key -in client.crt -certfile CA.pem

rm -rf cert

mkdir cert
mkdir cert/ca
mkdir cert/server
mkdir cert/client

mv CA.key cert/ca
mv CA.pem cert/ca
mv CA.srl cert/ca

mv localhost.crt cert/server
mv localhost.csr cert/server
mv localhost.decrypted.key cert/server
mv localhost.key cert/server

mv client.crt cert/client
mv client.csr cert/client
mv client.key cert/client
mv client.pfx cert/client
