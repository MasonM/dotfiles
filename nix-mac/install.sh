#!/bin/sh
set -ex
#nix profile install .
nix profile upgrade --all
