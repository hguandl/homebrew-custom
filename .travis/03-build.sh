#!/bin/bash

travis_wait 120 brew install hguandl/custom/${TARGET_FORMULA} --build-bottle
