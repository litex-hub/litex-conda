#!/bin/bash
# Instructions from http://openrisc.io/newlib/building.html

set -x
set -e

if [ x"$TRAVIS" = xtrue ]; then
	CPU_COUNT=2
fi

(
mkdir build
cd build
../configure \
  --target=lm32-elf \
  --prefix=$PREFIX \
 \
  --disable-itcl \
  --disable-tk \
  --disable-tcl \
  --disable-winsup \
  --disable-gdbtk \
  --disable-libgui \
  --disable-rda \
  --disable-sid \
  --disable-sim \
  --disable-lm32sim \
  --with-sysroot \
  --disable-newlib \
  --disable-libgloss \
  --disable-gas \
  --disable-ld \
  --disable-binutils \
  --disable-gprof \
  --with-system-zlib \
 \
  --disable-shared \
  --enable-static \

make -j$CPU_COUNT
make install
)

$PREFIX/bin/lm32-elf-gdb --version
echo $($PREFIX/bin/lm32-elf-gdb --version 2>&1 | head -1 | sed -e's/.* //')
