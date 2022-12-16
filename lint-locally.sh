#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
# https://github.com/github/super-linter
docker pull github/super-linter:slim-v4
docker run -e RUN_LOCAL=true -e USE_FIND_ALGORITHM=true -e VALIDATE_ALL_CODEBASE=true --env-file "./super-linter-locally.env" -v "$PWD":/tmp/lint github/super-linter:slim-v4