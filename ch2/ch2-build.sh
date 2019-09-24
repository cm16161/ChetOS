#!/bin/bash

./createSourcesAndTools.sh
./makeLFSUser.sh

cd ../../
mv -v ChetOS $LFS/sources
