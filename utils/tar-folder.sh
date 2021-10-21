#!/bin/bash

FOLDER_NAME=$(basename "$1")
CWD=$1
/usr/bin/tar -cf ${FOLDER_NAME}.tar $FOLDER_NAME
