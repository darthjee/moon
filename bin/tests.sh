#!/usr/bin/env bash

# make sure Postgres is available
until nc -z postgres $MOON__POSTGRES_PORT; do echo Waiting for Posgres; sleep 1; done

bundle exec rake db:drop db:create db:schema:load db:migrate
bundle exec rspec -fd
