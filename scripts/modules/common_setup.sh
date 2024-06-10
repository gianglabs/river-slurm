# Collect the ansible roles
ansible_galaxy_install(){
    # Check if requirements.yml exists
    if [ -f "requirements.yml" ]; then
        echo "Installing Ansible roles..."
        ansible-galaxy install -r requirements.yml -p ${ROOT_DIR}/roles
    else
        echo "requirements.yml file not found."
        exit 1
    fi
}


create_ssh_key(){
    yes n | ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -C "" -N "" || echo "key exists"
}

up_vm_and_inventory(){
    # CREATE VIRTUAL MACHINE and INVENTORY
    cp ${ROOT_DIR}/inventories/hosts.example ${ROOT_DIR}/inventories/hosts
    cd ${ROOT_DIR}/scripts/virtual/${OS} && vagrant up
    cd ${ROOT_DIR}
}

setup_cluster(){
    ansible-playbook -i ${ROOT_DIR}/inventories/hosts ${ROOT_DIR}/river_cluster.yml
}