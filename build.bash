#!/bin/bash
set -e
set -x

mkosi --force
unshare --map-auto --map-current-user --setuid 0 --setgid 0 chown "$(id -u):$(id -g)" -R output/files
# shellcheck source=/dev/null
source version.bash
LINGLONG_ARCH=$(dpkg-architecture -q DEB_BUILD_GNU_CPU)
export LINGLONG_ARCH

echo "$LINGLONG_ARCH" >"output/files/etc/linglong-triplet-list"

ll-builder list | grep "$APPID/$VERSION" | xargs ll-builder remove

envsubst <templates/linglong.template.yaml >"output/linglong.yaml"
MODULE=binary envsubst <templates/info.template.json >"output/info.json"
ll-builder import ./output
MODULE=develop envsubst <templates/info.template.json >"output/info.json"
ll-builder import ./output
