#!/bin/bash

if [ ! ${TARGET_FORMULA} ]; then
  exit 0
fi

brew install hguandl/custom/${TARGET_FORMULA} --build-bottle
