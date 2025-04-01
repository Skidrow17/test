# Command to generate key
openssl genrsa -des3 -passout pass:dummyPassword -out server.pass.key 2048
openssl rsa -passin pass:dummyPassword -in server.pass.key -out server.key
rm server.pass.key
openssl req -new -key server.key -out server.csr

# Command to create CRT:

openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt