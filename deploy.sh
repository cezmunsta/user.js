#!/bin/bash

test "${DEBUG:-0}" -ne 0 && set -o xtrace

set -o errexit -o pipefail -o nounset
set -o errtrace -o functrace

test -d ~/workspace/user.js
cd ~/workspace/user.js

test "$(git rev-parse --abbrev-ref HEAD)" = "customised"

cp -a prefsCleaner.sh updater.sh user.js "${OLDPWD}"

if [ -f user-overrides.js ]; then
    cp -a user-overrides.js "${OLDPWD}"/user-overrides.js
else
    touch "${OLDPWD}"/user-overrides.js
fi

cd -
./updater.sh
./prefsCleaner.sh
