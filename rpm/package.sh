#!/bin/sh

set -eu

VERSION=${VERSION:-v2.2.5}

mkdir -p download staging/opt/bin
pushd download
   wget https://github.com/coreos/etcd/releases/download/$VERSION/etcd-$VERSION-linux-amd64.tar.gz 
   tar zxf etcd-$VERSION-linux-amd64.tar.gz etcd-$VERSION-linux-amd64/etcd etcd-$VERSION-linux-amd64/etcdctl
popd

cp download/etcd-$VERSION-linux-amd64/etcd* staging/opt/bin/

RPM_DIR=rpms/
mkdir -p $RPM_DIR && rm -rf $RPM_DIR/* 

echo -n "Packaging..."

fpm -s dir \
	-t rpm \
	--package $RPM_DIR \
	--version $(/bin/echo -n $VERSION | tr -d v) \
	--rpm-os linux \
	--name etcd \
	--architecture amd64 \
	--description="CoreOS etcd cluster: https://github.com/coreos/etcd/releases" \
	--url="https://github.com/ae6rt/etcd-cluster-ansible" \
	--maintainer "Mark Petrovic <mspetrovic@gmail.com>" \
	--iteration 1 \
	-C staging/ \
	opt 

echo done
