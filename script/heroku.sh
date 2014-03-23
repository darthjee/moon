#!/bin/bash

declare -A ENVS
ENVS[prod]=git@heroku.com:marryon.git
ENVS[qa]=git@heroku.com:marryon-qa.git

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
  echo "push ENV:"
  echo "    Pushes to ENV"
  echo "configure:"
  echo "    configure heroku enviroments"
}

cmd_configure(){
  for ENV in "${!ENVS[@]}"; do
    GIT_URL="${ENVS[$ENV]}"
    git remote add $ENV $GIT_URL
  done
}

CMDS="push help configure"

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
