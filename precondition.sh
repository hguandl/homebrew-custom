#!/bin/bash

export COMMIT_MESSAGE=$(git log --format=%B -n 1)
export TARGET_FORMULA=$(echo ${COMMIT_MESSAGE} | cut -f 1 -d ":")

if [[ "${COMMIT_MESSAGE}" == *":"*"bottle." ]]; then
  echo "This commit is for uploading a bottle, skip building."
  exit 0
fi

if [[ "${COMMIT_MESSAGE}" != *":"* ]]; then
  echo "No formula name."
  exit 0
fi

if [ ! ${TARGET_FORMULA} ]; then
  echo "Empty formula name."
  exit 0
fi

echo "Would build ${TARGET_FORMULA}."
export DO_BUILD=1
