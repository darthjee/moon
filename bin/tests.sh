#!/usr/bin/env bash

# make sure Postgres is available
until nc -z postgres $MOON_POSTGRES_PORT; do echo Waiting for Posgres; sleep 1; done

ARG=$1

if [ ! $ARG ]; then
  ARG=all
fi

function do_db() {
  bundle exec rake db:drop db:create db:schema:load db:migrate
}

function do_ci() {
  bundle exec rake jasmine:ci
}

function do_rspec() {
  bundle exec rspec -fd
}

function do_jasmine() {
  bundle exec rake jasmine
}

case $ARG in
  all)
    echo all
    do_db
    do_rspec
    ;;
  rspec)
    echo rspec
    do_db
    do_rspec
    ;;
  ci)
    echo ci
    do_ci
    ;;
  jasmine)
    do_jasmine
    ;;
  *)
    echo 'Usage: $0 <ci|rspec|jasmine>'
    ;;
esac
