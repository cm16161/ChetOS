#!/bin/bash

mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources
wget --input-file=wget-list --continue --directory-prefix=$LFS/sources
mkdir -v $LFS/tools
ln -sv $LFS/tools /

