#!/bin/bash

python3 upload.py $1

pushd $(brew --prefix)/Homebrew/Library/Taps/hguandl/homebrew-custom
git push
popd
