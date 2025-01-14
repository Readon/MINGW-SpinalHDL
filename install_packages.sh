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
mingw-w64-${ARCH}-ghdl-${mcode}-4.1.0-4-any.pkg.tar.zst
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
