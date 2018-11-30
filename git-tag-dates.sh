#!/bin/sh
git log --no-walk --tags --pretty="%C(auto) %ad %h %d " --decorate=short --date=short
