.PHONY: vm-start vm-status install test cluster
${HOME}/.pixi/bin/pixi:
	curl -sSL https://pixi.sh/install.sh | sh

vm-start: ${HOME}/.pixi/bin/pixi
	bash scripts/setup.sh 24.04 true

vm-status: ${HOME}/.pixi/bin/pixi
	cd scripts/virtual/24.04 && vagrant status

install: ${HOME}/.pixi/bin/pixi
	${HOME}/.pixi/bin/pixi run ansible-galaxy install -r requirements.yml -p roles

test: ${HOME}/.pixi/bin/pixi
	${HOME}/.pixi/bin/pixi run molecule test

cluster: ${HOME}/.pixi/bin/pixi
	${HOME}/.pixi/bin/pixi run ansible-playbook -i inventories/hosts.dev.yml playbooks/slurm-cluster/slurm.yml

# fix fix-molecule-docker
fix-molecule-docker:
	${HOME}/.pixi/bin/pixi run patch-molecule-docker