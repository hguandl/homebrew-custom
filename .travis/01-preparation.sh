#!/bin/bash

git config --global user.name ${GITHUB_USERNAME}
git config --global user.email ${GITHUB_EMAIL}
echo -e "machine github.com\n  login ${GITHUB_USERNAME}\n  password ${GITHUB_TOKEN}" > ~/.netrc
echo -e "machine api.bintray.com\n  login ${BINTRAY_USERNAME}\n  password ${BINTRAY_KEY}" >> ~/.netrc
