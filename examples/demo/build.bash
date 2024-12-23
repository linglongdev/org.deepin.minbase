#!/bin/bash
set -e
workdir=$PWD
rm -rf linglong-builder-demo || true
git clone https://github.com/linuxdeepin/linglong-builder-demo.git --depth 1
cd linglong-builder-demo && mkdir build && cd build && qmake .. && make -j4
cd $workdir
ll-builder build --skip-output-check --skip-strip-symbols
