# vagrant-openshift-ansible-local

This repository is suitable to use in Windows since it uses ansible-local provisioner.
It will installation 3 nodes cluster - 1 controller and 2 worker nodes.

## Plugins

The followng plugings needs to be installed for vagrant.

1. [vagrant landrush](https://github.com/vagrant-landrush/landrush)


## Build the cluster
```
git clone https://github.com/riponbanik/vagrant-openshift-ansible-local.git
cd vagrant-openshift-ansible-local
vagrant up 
```

## When you're done, you can shut down the cluster using
```
vagrant destroy -f
```


