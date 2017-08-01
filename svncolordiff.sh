#!/bin/sh
LESS='FSRX'
export LESS
svn diff --diff-cmd colordiff -x "-u -w -p" "$@" | less -R
