TARGET?=default

.PHONY: default

default: # default target
	cat Makefile

bundle: # install gems
	chef exec bundle install

kitchen_create: bundle # create
	export KITCHEN_YAML="./kitchen.virtualbox.yml"; \
	chef exec bundle exec kitchen create --concurrency=1 $(TARGET)

kitchen_converge: bundle # converge
	export KITCHEN_YAML="./kitchen.virtualbox.yml"; \
	chef exec bundle exec kitchen converge --concurrency=1 $(TARGET)

kitchen_verify: bundle # verify
	export KITCHEN_YAML="./kitchen.virtualbox.yml"; \
	chef exec bundle exec kitchen verify --concurrency=1 $(TARGET)

kitchen_test: bundle # test
	export KITCHEN_YAML="./kitchen.virtualbox.yml"; \
	chef exec bundle exec kitchen test --concurrency=1 $(TARGET)

kitchen_destroy: bundle # destroy
	export KITCHEN_YAML="./kitchen.virtualbox.yml"; \
	chef exec bundle exec kitchen destroy

kitchen_login: # login
	export KITCHEN_YAML="./kitchen.virtualbox.yml"; \
	chef exec bundle exec kitchen login $(TARGET)

git_mirror: # mirror the repo to git hub
	git push --mirror https://github.com/jjsymes/minecraft-server-ansible.git

variables: # prints interesting variables
	@echo 'ROOT_DIR =               $(ROOT_DIR)'
