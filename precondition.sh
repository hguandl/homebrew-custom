#!/bin/bash

export TARGET_FORMULA=$(echo ${TRAVIS_COMMIT_MESSAGE} | cut -f 1 -d ":")

if [[ "${TRAVIS_COMMIT_MESSAGE}" == *":"*"bottle." ]]; then
  echo "This commit is for uploading a bottle, skip building."
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
export DO_BUILD=1
