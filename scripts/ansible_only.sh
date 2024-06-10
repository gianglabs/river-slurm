# 1. Install the ansible dependencies
# Function to check if Python3 is installed
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ROOT_DIR=$(realpath ${SCRIPT_DIR}/..)

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
    # CREATE SSH KEY
    yes n | ssh-keygen -q -t rsa -f ~/.ssh/id_rsa -C "" -N "" || echo "key exists"
}

ansible_galaxy_install
create_ssh_key