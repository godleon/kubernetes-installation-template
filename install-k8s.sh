#!/bib/bash

# upgrade pip
apt-get update
apt-get -y install git python3-pip python
pip3 install --upgrade pip


rm -rf /srv/kubespray
cd /srv
git clone https://github.com/kubernetes-incubator/kubespray.git
cd -
pip install -r /srv/kubespray/requirements.txt

# spawn VMs for k8s dedeployment
# cd /ansible
# ansible-playbook -i inventory site.destroy-vm.yml
# ansible-playbook -i inventory site.spawn-vm.yml

BASE_DIR="/srv/kubespray"
rm -rf ${BASE_DIR}/inventory/mycluster
#cp -rfp ${BASE_DIR}/inventory/sample ${BASE_DIR}/inventory/mycluster
mkdir -p ${BASE_DIR}/inventory/mycluster
cp -r kubespray/* ${BASE_DIR}/inventory/mycluster/
# cp /ansible/kubespray/tasks/pre-requisite.yml ${BASE_DIR}/

cd ${BASE_DIR}
# ansible-playbook -i inventory/mycluster/hosts.ini pre-requisite.yml
ansible-playbook -b -i inventory/mycluster/hosts.ini cluster.yml

#cd /ansible
#ansible-playbook -i inventory site.post-install.yml

