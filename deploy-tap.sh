#!/bin/bash

python3 upload.py $1

pushd $(brew --repository ${HOMEBREW_TAP})
git push
popd
