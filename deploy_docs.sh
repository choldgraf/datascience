#!/bin/bash

# This script is used by Travis to automatically build and push the docs to the
# gh-pages branch of the datascience repo.

set -e # exit with nonzero exit code if anything fails

# Only build docs on master branch
if [[ $TRAVIS_PULL_REQUEST == false && $TRAVIS_BRANCH == "master" ]] ; then

  echo "-- building docs --"

  make docs

  echo "-- pushing docs --"


  git config user.name "Travis CI"
  git config user.email "travis@travis.com"

  commitMessage=`git log -1 --pretty=%B`
  commitHash=`git rev-parse HEAD`

  make deploy_docs \
    DEPLOY_DOCS_MESSAGE="Generated by commit $commitHash, pushed by Travis build $TRAVIS_BUILD_NUMBER." \
    GH_REMOTE="https://${GH_TOKEN}@${GH_REPO}"
fi
