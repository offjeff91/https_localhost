echo "cleaning..."
rm -rf ~/cert
rm -rf /tmp/build_ssl

echo "starting..."
mkdir /tmp/build_ssl
cp localhost.ext /tmp/build_ssl
cd ~/
mkdir cert
cd cert
mkdir CA
cd CA
openssl genrsa -out CA.key -des3 2048
openssl req -x509 -sha256 -new -nodes -days 3650 -key CA.key -out CA.pem
mkdir localhost
cd localhost
cp /tmp/build_ssl/localhost.ext .
openssl genrsa -out localhost.key -des3 2048
openssl req -new -key localhost.key -out localhost.csr
cd ~/cert/CA/localhost
openssl x509 -req -in localhost.csr -CA ../CA.pem -CAkey ../CA.key -CAcreateserial -days 3650 -sha256 -extfile localhost.ext -out localhost.crt
openssl rsa -in localhost.key -out localhost.decrypted.key
