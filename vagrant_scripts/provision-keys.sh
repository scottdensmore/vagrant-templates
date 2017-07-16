#!/bin/bash
set -e

# make sure we can get to github & microsoft
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

# put any other keys that you need in here
