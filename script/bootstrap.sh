#!/bin/bash

red() {
  echo -e "\033[31m $1\033[0m"
}

green() {
  echo -e "\033[0;32m$1\033[0m"
}

white() {
  echo -e "\033[0;37m$1\033[0m"
}

command_exists() {
  command -v "$1" &>/dev/null
}

test_dependency() {
  if command_exists "$1"; then
    green " ✔ $2 is already installed."
  else
    exec >&2
    red " ✖ You need to install $2.\c"
    if [[ -n "$3" ]]; then
      white "\n $3\n"
    else
      echo " If you use Homebrew, you can run:"
      white " brew install $2\n"
    fi
    return 1
  fi
}

config_heroku(){
  script/heroku.sh configure
}

install_gems(){
  echo "Installing gems"
  bundle check &> /dev/null || bundle install --quiet
}

check_ruby() {
  if ruby -v | grep -q "$1"; then
    green " ✔ Ruby $1 is already installed."
  else
    red " ✖ Ruby $1 is not installed. Please install it."
    return 1
  fi
}

(
  set -e
  check_ruby "2.0.0"
  test_dependency "bundle" "Bundler" "gem install bundler"
  test_dependency "psql" "postgres" "apt-get install postgresql-server-dev-9.1"
)

if (( $? != 0 )); then
  exit $?
fi

install_gems
config_heroku