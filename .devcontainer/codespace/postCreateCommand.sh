#!/usr/bin/env bash

# This post-create command script is designed for GitHub Codespaces that uses TakT
# It sets up git configuration, logs into GitHub CLI using a provided token,
# You should generate the GitHub OAuth token in a shell like this:
#
# $ gh auth login --web --hostname github.com --git-protocol https
#
# hereafter you can get the toke with:
#
# $ gh auth token
#
# Copy the token and got to https://github.com/settings/codespaces and store it as a secret named TAKT_GHO

set -e

PREFIX="🍰  "
echo "$PREFIX Running $(basename $0)"

echo "$PREFIX Setting up safe git repository to prevent dubious ownership errors"
if [ -n "$RepositoryName" ]; then
  git config --global --add safe.directory /workspaces/$(echo $RepositoryName)
else
  echo "$PREFIX 🤷‍♂️ eeeeh \$RepositoryName is not defined (WTF?)"
  exit 0
fi

echo "$PREFIX Setting up git configuration to support .gitconfig in repo-root"
git config --local --get include.path | grep -e ../.gitconfig >/dev/null 2>&1 || git config --local --add include.path ../.gitconfig

echo "$PREFIX Running in GitHub Codespaces - disabling commit signing"
git config --local commit.gpgsign false

echo "$PREFIX Installing the devx-cafe/gh-tt gh cli extension"
gh extension install devx-cafe/gh-tt --pin experimental
echo "$PREFIX Installing the gh aliases"    
gh alias import .devcontainer/.gh_alias.yml --clobber

echo "$PREFIX Installing the Ruby gems"
bundle config set frozen true # use the existing Gemfile.lock
bundle install

echo "$PREFIX Use defined token if it exists"
if [ -n "$TAKT_GHO" ]; then
  echo "$PREFIX 🔍 Found it! Logging into GitHub CLI using \$TAKT_GHO" 
  unset GITHUB_TOKEN
  gh auth login --with-token <<< "$TAKT_GHO"
else
  echo "$PREFIX 🤷‍♂️ No \$TAKT_GHO found - you need to login manually:"
  echo "   unset GITHUB_TOKEN"
  echo "   gh auth login --web --hostname github.com --git-protocol https"
fi  

echo "$PREFIX SUCCESS"
exit 0