#!/bin/sh

ansible cluster -a "/opt/bin/etcdctl --ca-file /etc/ssl/certs/ca.pem --endpoint https://10.2.23.8:2379 set foo bar"

ansible cluster -a "/opt/bin/etcdctl --ca-file /etc/ssl/certs/ca.pem --endpoint https://10.2.23.8:2379 get foo"
