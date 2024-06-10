all: minio setup vagrant server single

.PHONY: minio server client vagrant setup single

minio:
	docker compose up -d createbuckets

setup: requirements.txt
	python3 -m venv .env && \
	. .env/bin/activate && \
	pip install -r requirements.txt

vagrant_init: Vagrantfile
	vagrant up

vagrant_halt:
	vagrant halt

vagrant_destroy:
	vagrant destroy -y

vagrant_provision:
	vagrant provision

cluster:
	. .env/bin/activate && \
	ansible-playbook -i inventories/hosts setup_cluster.yml

single:
	ansible-playbook -i inventories/hosts single.yml