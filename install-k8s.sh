#!/bin/bash

# upgrade pip
apt-get update
apt-get -y install git python3-pip python sshpass
pip3 install --upgrade pip


rm -rf /srv/kubespray
cd /srv
git clone https://github.com/kubernetes-incubator/kubespray.git --branch v2.8.3
# workaround for calico installation
#sed -i 's/ansible>=2.5.0/ansible==2.6.3/' kubespray/requirements.txt
#cd -
pip install -r /srv/kubespray/requirements.txt


BASE_DIR="/srv/kubespray"
rm -rf ${BASE_DIR}/inventory/mycluster
mkdir -p ${BASE_DIR}/inventory/mycluster
cp -r kubespray/* ${BASE_DIR}/inventory/mycluster/

cd ${BASE_DIR}
ansible-playbook -b -i inventory/mycluster/hosts.ini cluster.yml
cd -
if [ -f ${BASE_DIR}/inventory/mycluster/artifacts/admin.conf ]; then
  cp ${BASE_DIR}/inventory/mycluster/artifacts/admin.conf kubeconfig/
fi
