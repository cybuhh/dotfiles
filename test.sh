#!/usr/bin/env bash

command -v shellcheck 2>&1 /dev/null
if [ $? != 0 ]; then
  echo 'Shellcheck is missing, can''t run tests'
  echo 'More info https://github.com/koalaman/shellcheck'
  return 1
fi

shellcheck source/* init.sh
