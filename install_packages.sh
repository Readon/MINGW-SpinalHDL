#!/bin/sh
set -e -x
CWD=`pwd`
MSYSTEM=$1
ARCH=$2

if [ "$MSYSTEM" = "mingw32" ]; then
  mcode="mcode"
else
  mcode="llvm"
fi

VERSION="current"
GCC_VERSION="14.2.0-2"
GHDL_VERSION="4.1.0-4"

TMP="${CWD}/tmp-${VERSION}"
URL="https://repo.msys2.org/mingw/${MSYSTEM}"
PKGS="
mingw-w64-${ARCH}-gcc-${GCC_VERSION}-any.pkg.tar.zst
mingw-w64-${ARCH}-gcc-libs-${GCC_VERSION}-any.pkg.tar.zst
mingw-w64-${ARCH}-gcc-ada-${GCC_VERSION}-any.pkg.tar.zst
mingw-w64-${ARCH}-libgccjit-${GCC_VERSION}-any.pkg.tar.zst
mingw-w64-${ARCH}-gcc-fortran-${GCC_VERSION}-any.pkg.tar.zst
mingw-w64-${ARCH}-gcc-libgfortran-${GCC_VERSION}-any.pkg.tar.zst
mingw-w64-${ARCH}-gcc-objc-${GCC_VERSION}-any.pkg.tar.zst
mingw-w64-${ARCH}-ghdl-${mcode}-${GHDL_VERSION}-any.pkg.tar.zst
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
pacman -U --noconfirm mingw-w64-${ARCH}-*-any.pkg.tar.*
