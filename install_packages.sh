#!/bin/sh
set -e -x
CWD=`pwd`
VERSION="current"
TMP="${CWD}/tmp-${VERSION}"
URL="https://repo.msys2.org/mingw/mingw64"
PKGS="
mingw-w64-x86_64-gcc-13.1.0-7-any.pkg.tar.zst
mingw-w64-x86_64-gcc-libs-13.1.0-7-any.pkg.tar.zst
mingw-w64-x86_64-gcc-ada-13.1.0-7-any.pkg.tar.zst
mingw-w64-x86_64-libgccjit-13.1.0-7-any.pkg.tar.zst
mingw-w64-x86_64-gcc-fortran-13.1.0-7-any.pkg.tar.zst
mingw-w64-x86_64-gcc-libgfortran-13.1.0-7-any.pkg.tar.zst
mingw-w64-x86_64-gcc-objc-13.1.0-7-any.pkg.tar.zst
mingw-w64-x86_64-ghdl-llvm-3.0.0.r147.g6c56631a7-2-any.pkg.tar.zst
"

if [ ! -d "${TMP}" ]; then
    mkdir -p "${TMP}"
fi
cd ${TMP}
for pkg in ${PKGS}; do
    if [ ! -f "${pkg}" ]; then
        wget "${URL}/${pkg}"
    fi
done
pacman -U mingw-w64-x86_64-*-any.pkg.tar.*
