#!/usr/bin/env bash

set -e

PREFIX="🍰  "
echo "$PREFIX Running $(basename $0)"

echo "$PREFIX Setting up safe git repository to prevent dubious ownership errors"
if [[ "$CODESPACES" == "true" ]]; then
  git config --global --add safe.directory /workspaces/devopsdays.dk
else
  git config --global --add safe.directory /workspace
fi

echo "$PREFIX Setting up git configuration to support .gitconfig in repo-root"
git config --local --get include.path | grep -e ../.gitconfig >/dev/null 2>&1 || git config --local --add include.path ../.gitconfig

if [[ "$CODESPACES" == "true" ]]; then
  echo "$PREFIX Running in GitHub Codespaces - disabling commit signing"
  git config --global commit.gpgsign false
  echo "$PREFIX Running in GitHub Codespaces - skipping GH CLI setup"
else
  if [ -e $(dirname $0)/_temp.token ]; then
      echo "$PREFIX setting up GitHub CLI"
      $(dirname $0)/gh-login.sh postcreate
  fi 
fi

echo "$PREFIX Installing the devx-cafe/gh-tt gh cli extension"
gh extension install devx-cafe/gh-tt
echo "$PREFIX Installing the gh aliases"    
gh alias import .devcontainer/.gh_alias.yml --clobber

echo "$PREFIX Refreshing GitHub CLI scopes to include project access"
gh auth refresh -s project

echo "$PREFIX Installing the Ruby gems"
bundle config set frozen true # use the existing Gemfile.lock
bundle install


echo "$PREFIX SUCCESS"
exit 0