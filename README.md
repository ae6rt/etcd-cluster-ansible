## Standup a 5 node etcd cluster secured with TLS with Ansible

This guide assumes you have 5 CentOS7 EC2 nodes setup, and that these hosts are inventoried in the playbook/hosts file.

### Generate an RPM with etcd binaries

```
$ pushd rpm && sh package.sh && popd
```

Copy the rpm to playbook/files/

### Run the playbook

```
$ cd playbook
$ ansible-playbook play.yaml 
```

Not included in this repository is the ansible.cfg file, which would look like this

```
[defaults]
hostfile = hosts
remote_user = centos
private_key_file = path-to-private-key
host_key_checking = false
retry_files_enabled = False
deprecation_warnings=False
gathering = smart
fact_caching = jsonfile
fact_caching_connection = facts_cache
# one hour timeout
fact_caching_timeout = 3600
```

### Check cluster health 

Pick a host and perform a cluster health check

```
$ etcdctl --ca-file files/ca.pem --endpoint https://10.2.23.7:2379 cluster-health
member a4e8abca6616dcfa is healthy: got healthy result from https://10.2.23.7:2379
member b36538262a78cab8 is healthy: got healthy result from https://10.2.23.12:2379
member c5daf24f444a95f3 is healthy: got healthy result from https://10.2.23.8:2379
member f3d233a83998c7ef is healthy: got healthy result from https://10.2.23.6:2379
member fcf5df0a8257b7a1 is healthy: got healthy result from https://10.2.23.13:2379
cluster is healthy
```

### Get/Set a key

```
$ etcdctl --ca-file files/ca.pem --endpoint https://10.2.23.7:2379 set foo bar
bar
$ etcdctl --ca-file files/ca.pem --endpoint https://10.2.23.7:2379 get foo 
bar
$ etcdctl --ca-file files/ca.pem --endpoint https://10.2.23.8:2379 get foo 
bar
```

## Reference

https://coreos.com/etcd/docs/latest/clustering.html
