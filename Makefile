.PHONY: vm-start vm-status cluster
${HOME}/.pixi/bin/pixi:
	curl -sSL https://pixi.sh/install.sh | sh

vm-start:
	bash scripts/setup.sh 24.04 true

vm-status:
	cd scripts/virtual/24.04 && vagrant status

install:
	${HOME}/.pixi/bin/pixi run ansible-galaxy install -r requirements.yml -p roles

test:
	${HOME}/.pixi/bin/pixi run molecule test

cluster:
	${HOME}/.pixi/bin/pixi run ansible-playbook -i inventories/hosts.dev.yml playbooks/slurm-cluster/slurm.yml