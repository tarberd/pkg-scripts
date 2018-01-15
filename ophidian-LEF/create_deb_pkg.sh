PKGNAME="ophidian-LEF"
PKGVERSION="5.8-3"

ROOT=$(pwd)
SRCROOT=$ROOT/LEF
PKGROOT=$ROOT/$PKGNAME\_$PKGVERSION

LICENCE_DIR=$PKGROOT/usr/share/doc/LEF

cd $SRCROOT
git submodule update --init
make clean
make CXXFLAGS="-fPIC" all

mkdir $PKGROOT
mkdir $PKGROOT/DEBIAN
mkdir $PKGROOT/usr
mkdir $PKGROOT/usr/bin
mkdir $PKGROOT/usr/lib
mkdir $PKGROOT/usr/include

install -D -o root -g root -m 644 $ROOT/DEBIAN/control $PKGROOT/DEBIAN

install -D -o root -g root -m 644 $SRCROOT/bin/* $PKGROOT/usr/bin
install -D -o root -g root -m 644 $SRCROOT/lib/* $PKGROOT/usr/lib
install -D -o root -g root -m 644 $SRCROOT/include/* $PKGROOT/usr/include

install -D -o root -g root -m 644 $SRCROOT/LICENSE.TXT $LICENCE_DIR/copyright

dpkg-deb --build $PKGROOT

rm -rf $PKGROOT
