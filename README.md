# kubernetes-installation-template

This is an Kubernetes installation template for Kubespray


# Prerequisites

1. All the VMs for deploying Kubernetes needs to be accessible via specific private SSH key

2. Prepare an Ubuntu 16.04 machine for deployment(VM is fine)


# User Guide

## Clone this repository

Log in the deployment machine and execute the following commands:

```bash
$ sudo apt-get update
$ sudo apt-get -y install git
$ cd /tmp
$ git clone https://github.com/godleon/kubernetes-installation-template.git
```


## Prepare SSH access key

Put the private SSH access key to **/tmp/kubernetes-installation-template/ssh-privkey** folder.


## Change the default deployment configurations

The following configurations are necessary to change according to your environment:

### /tmp/kubernetes-installation-template/kubespray/group_vars/all.yml

- **Host Authentication Information**

> This part includes the authentication information of the hosts which are going to deploy

- **Python Interpreter Location**

> File path of Python Interpreter which is required for Ansible deployment

- Bootstrap OS

> default is set to `ubuntu`，modification is needed if different OS is used

### /tmp/kubernetes-installation-template/kubespray/hosts.init

Fill out the inventory information of the nodes which are going to deploy Kubernetes. There are two kinds of information is need here:

- Host information: includes **OS hostname** and **IP address**

- Host Roles (which nodes is belong to **master**, **worker**, or **ingress**)
> ingress is not a must


## Start to deploy

Execute the following commands to start Kubernetes deployment:

```bash
$ cd kubernetes-installation-template/
$ bash start.sh
```


## Access the Kubernetes cluster

Log in any one of the master nodes you defined in the file **/tmp/kubernetes-installation-template/kubespray/hosts.init**，**kubectl** CLI is installed and be able to manage the cluster.
