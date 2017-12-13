PKGNAME="ophidian-units"
PKGVERSION="2.3.1-1"

ROOT=$(pwd)
SRCROOT=$ROOT/units
PKGROOT=$ROOT/$PKGNAME\_$PKGVERSION

LICENCE_DIR=$PKGROOT/usr/share/doc/units

mkdir $PKGROOT
mkdir -p $LICENCE_DIR

cd $SRCROOT
git submodule update --init
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make DESTDIR=$PKGROOT install
cd .. && rm -rf build

cp -r $ROOT/DEBIAN $PKGROOT
cp $SRCROOT/LICENSE $LICENCE_DIR/copyright

dpkg-deb --build $PKGROOT

rm -rf $PKGROOT
