#!/bin/sh
set -e -x
CWD=`pwd`
MSYSTEM=$1
ARCH=$2
VERSION="current"
TMP="${CWD}/tmp-${VERSION}"
URL="https://repo.msys2.org/mingw/${MSYSTEM}"
PKGS="
mingw-w64-${ARCH}-gcc-13.1.0-7-any.pkg.tar.zst
mingw-w64-${ARCH}-gcc-libs-13.1.0-7-any.pkg.tar.zst
mingw-w64-${ARCH}-gcc-ada-13.1.0-7-any.pkg.tar.zst
mingw-w64-${ARCH}-libgccjit-13.1.0-7-any.pkg.tar.zst
mingw-w64-${ARCH}-gcc-fortran-13.1.0-7-any.pkg.tar.zst
mingw-w64-${ARCH}-gcc-libgfortran-13.1.0-7-any.pkg.tar.zst
mingw-w64-${ARCH}-gcc-objc-13.1.0-7-any.pkg.tar.zst
mingw-w64-${ARCH}-ghdl-llvm-3.0.0.r147.g6c56631a7-2-any.pkg.tar.zst
"

if [ ! -d "${TMP}" ]; then
    mkdir -p "${TMP}"
fi
cd ${TMP}
for pkg in ${PKGS}; do
    if [ ! -f "${pkg}" ]; then
        curl -O "${URL}/${pkg}"
    fi
done
pacman -U mingw-w64-${ARCH}-*-any.pkg.tar.*
