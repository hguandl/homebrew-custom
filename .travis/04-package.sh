#!/bin/bash

brew update
brew bottle --json ${TARGET_FORMULA} --root-url ${BOTTLE_ROOT_URL} || brew bottle --skip-relocation --json ${TARGET_FORMULA} --root-url ${BOTTLE_ROOT_URL}
brew bottle --merge --write $(ls ${TARGET_FORMULA}*bottle*.json)
pip3 install requests
