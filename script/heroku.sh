#!/bin/bash

push_it(){
  ENV=$1
  git push $ENV $ENV:master
}

if [ $1 ]; then
  while [ $1 ]; do
    echo push_it $1
    shift 1
  done
else
  push_it qa
fi
