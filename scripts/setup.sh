#!/bin/bash
# Config
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <UBUNTU_VERSION> <RUN_VM>"
    exit 1
fi

UBUNTU_VERSION="${1:-20.04}"
RUN_VM="${2:-false}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
ROOT_DIR=$(realpath "${SCRIPT_DIR}/..")
echo "Root directory: ${ROOT_DIR}"

# Load modules
source "${ROOT_DIR}/scripts/modules/common_setup.sh"
source "${ROOT_DIR}/scripts/modules/ubuntu_setup.sh"
export DEBIAN_FRONTEND=noninteractive
OS="${UBUNTU_VERSION}"
setup_ubuntu
ansible_galaxy_install
create_ssh_key

if [ "${RUN_VM}" == true ]; then
    up_vm_and_inventory
fi
