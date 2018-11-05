#!/usr/bin/env bash

sudo apt-add-repository -y ppa:fish-shell/release-2 >/dev/null 2>&1
sudo apt -qq update
sudo apt -y -qq install fish git
make install
