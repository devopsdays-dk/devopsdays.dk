#!/usr/bin/env bash
PREFIX="👀  "

if [[ "$CODESPACES" == "true" ]]; then
  # Running in GitHub CodeSpaces
  echo "$PREFIX Running in GitHub Codespaces - skipping initialization script"
else
  set -e
  
  echo "$PREFIX Running $(basename $0)"
  
  echo "$PREFIX Initializing  GH CLI"
  
  $(dirname $0)/gh-login.sh initialize
  
  echo "$PREFIX SUCCESS"
  exit 0
fi


