#!/bin/sh

sed "s/#BuildFlavour  = quick-cross/BuildFlavour  = quick-cross/" mk/build.mk.sample > mk/build.mk
sed -i "s/ -fllvm//" mk/flavours/quick-cross.mk
# XXX: don't know but ghc-head around v8.1.20 on circleci gives 
# error for libraries/base/configure due to this flag
sed -i "s/-Werror=unused-but-set-variable//" mk/warnings.mk

./boot
./configure --target=x86_64-rumprun-linux --prefix=`pwd`/inst
# XXX: some submodules are not happy with rumprun-cc cross compiling
sed -i "s/cross_compiling=no/cross_compiling=yes/" libraries/unix/configure
sed -i "s/cross_compiling=no/cross_compiling=yes/" libraries/base/configure
make -j && make install
