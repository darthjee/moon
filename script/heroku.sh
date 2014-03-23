#!/bin/bash

push_it(){
  ENV=$1
  git push $ENV $ENV:master
}

cmd_push(){
  if [ $1 ]; then
    while [ $1 ]; do
      echo push_it $1
      shift 1
    done
  else
    push_it qa
 fi
}

cmd_help(){
  echo "push: Pushes to server"
}

CMDS="push help"

if [ $1 ]; then
  CMD=$1
  shift 1
  
  if (echo $CMDS | grep "\b$CMD\b" > /dev/null); then
    cmd_$CMD $*
  else
    cmd_help
  fi
else
  cmd_help
fi
