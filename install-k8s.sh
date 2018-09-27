#!/bin/bash

# upgrade pip
apt-get update
apt-get -y install git python3-pip python
pip3 install --upgrade pip


rm -rf /srv/kubespray
cd /srv
git clone https://github.com/kubernetes-incubator/kubespray.git
cd -
pip install -r /srv/kubespray/requirements.txt


BASE_DIR="/srv/kubespray"
rm -rf ${BASE_DIR}/inventory/mycluster
mkdir -p ${BASE_DIR}/inventory/mycluster
cp -r kubespray/* ${BASE_DIR}/inventory/mycluster/

cd ${BASE_DIR}
ansible-playbook -b -i inventory/mycluster/hosts.ini cluster.yml
cd -
cp ${BASE_DIR}/inventory/mycluster/artifacts/admin.conf kubeconfig/
