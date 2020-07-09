.PHONY: default

default: # default target
	cat Makefile

bundle: # install gems
	chef exec bundle install

kitchen_create: bundle # create
	export KITCHEN_YAML="./kitchen.virtualbox.yml"; \
	chef exec bundle exec kitchen create

kitchen_converge: bundle # converge
	export KITCHEN_YAML="./kitchen.virtualbox.yml"; \
	chef exec bundle exec kitchen converge

kitchen_verify: bundle # verify
	export KITCHEN_YAML="./kitchen.virtualbox.yml"; \
	chef exec bundle exec kitchen verify

kitchen_test: bundle # test
	export KITCHEN_YAML="./kitchen.virtualbox.yml"; \
	chef exec bundle exec kitchen test

kitchen_destroy: bundle # destroy
	export KITCHEN_YAML="./kitchen.virtualbox.yml"; \
	chef exec bundle exec kitchen destroy

kitchen_login: # login
	export KITCHEN_YAML="./kitchen.virtualbox.yml"; \
	chef exec bundle exec kitchen kitchen_login

git_mirror: # mirror the repo to git hub
	git push --mirror https://github.com/jjsymes/minecraft-server-ansible.git

variables: # prints interesting variables
	@echo 'ROOT_DIR =               $(ROOT_DIR)'
