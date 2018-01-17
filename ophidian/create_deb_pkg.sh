PKGNAME="ophidian"
PKGVERSION="0.1-1"

ROOT=$(pwd)
SRCROOT=$ROOT/ophidian
PKGROOT=$ROOT/$PKGNAME\_$PKGVERSION

mkdir $PKGROOT

cd $SRCROOT
git submodule update --init
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make DESTDIR=$PKGROOT install
cd .. && rm -rf build

cp -r $ROOT/DEBIAN $PKGROOT

dpkg-deb --build $PKGROOT

rm -rf $PKGROOT
