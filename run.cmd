# Clone the repo
git clone https://github.com/openshift/openshift-ansible 

# Run playbook all 
ansible-playbook -i inventory playbook.yml

# Run individually
sudo ansible-playbook -i inventory openshift/playbooks/prerequisites.yml
sudo ansible-playbook -i inventory openshift/playbooks/deploy_cluster.yml