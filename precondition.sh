#!/bin/bash

if [ -e .DO_BUILD ]; then
  rm -rf .DO_BUILD
fi

TARGET_FORMULA=$(echo ${TRAVIS_COMMIT_MESSAGE} | cut -f 1 -d ":")

if [[ "${TRAVIS_COMMIT_MESSAGE}" == *": add"*"bottle." ]]; then
  echo "Bottle added, skip building."
  exit 0
fi

if [[ "${TRAVIS_COMMIT_MESSAGE}" != *":"* ]]; then
  echo "No formula name."
  exit 0
fi

if [ ! ${TARGET_FORMULA} ]; then
  echo "Empty formula name."
  exit 0
fi

echo "Would build ${TARGET_FORMULA}."
touch .DO_BUILD
