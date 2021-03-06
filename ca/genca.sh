#!/bin/sh

set -u

cat <<EOF > ca-csr.json
{
  "CN": "AE6RT Certificate Authority",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Petaluma",
      "O": "AE6RT",
      "ST": "California"
    }
  ]
}
EOF

cfssl gencert -initca ca-csr.json | cfssljson -bare ca
