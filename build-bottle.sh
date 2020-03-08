#!/bin/bash

if [ ${TRAVIS_COMMIT_MESSAGE} == "*add*" ] && [ ${TRAVIS_COMMIT_MESSAGE} == "*bottle." ]; then
  exit 0
fi

if [ ${TRAVIS_COMMIT_MESSAGE} != "*:*" ]; then
  exit 0
fi

if [ ! ${TARGET_FORMULA} ]; then
  exit 0
fi

brew install hguandl/custom/${TARGET_FORMULA} --build-bottle
