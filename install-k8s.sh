#!/bin/bash

# upgrade pip
apt-get update
apt-get -y install git python3-pip python sshpass
pip3 install --upgrade pip

BEG_PATH="$(pwd)"

rm -rf /srv/kubespray
cd /srv
git clone https://github.com/kubernetes-incubator/kubespray.git
cd /srv/kubespray
git checkout -b v2.10.0
cd -

# workaround for calico installation
#sed -i 's/ansible>=2.5.0/ansible==2.6.3/' kubespray/requirements.txt
# cd -
pip install -r /srv/kubespray/requirements.txt


BASE_DIR="/srv/kubespray"
rm -rf ${BASE_DIR}/inventory/mycluster
mkdir -p ${BASE_DIR}/inventory/mycluster
cp -r ${BEG_PATH}/kubespray/* ${BASE_DIR}/inventory/mycluster/

cp -r ${BEG_PATH}/node-prereqs.yml ${BASE_DIR}/node-prereqs.yml

cd ${BASE_DIR}
ansible-playbook -b -i inventory/mycluster/hosts.ini node-prereqs.yml
ansible-playbook -b -i inventory/mycluster/hosts.ini cluster.yml
cd -
if [ -f ${BASE_DIR}/inventory/mycluster/artifacts/admin.conf ]; then
  cp ${BASE_DIR}/inventory/mycluster/artifacts/admin.conf kubeconfig/
  cat ${BASE_DIR}/inventory/mycluster/artifacts/admin.conf
fi
