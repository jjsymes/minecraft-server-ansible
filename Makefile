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
	chef exec bundle exec kitchen login

variables: # prints interesting variables
	@echo 'ROOT_DIR =               $(ROOT_DIR)'
