#!/bin/sh

./boot
sed "s/#BuildFlavour  = quick-cross/BuildFlavour  = quick-cross/" mk/build.mk.sample | sed "s/ -fllvm//" > mk/build.mk
./configure --target=x86_64-rumprun-linux --prefix=`pwd`/inst
# XXX: some submodules are not happy with rumprun-cc cross compiling
sed -i "s/cross_compiling=no/cross_compiling=yes/" libraries/unix/configure
sed -i "s/cross_compiling=no/cross_compiling=yes/" libraries/base/configure
make && make install
