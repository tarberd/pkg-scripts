PKGNAME="ophidian-verilog-parser"
PKGVERSION="0.2-32"

ROOT=$(pwd)
SRCROOT=$ROOT/verilog-parser
PKGROOT=$ROOT/$PKGNAME\_$PKGVERSION

LICENCE_DIR=$PKGROOT/usr/share/doc/ophidian-verilog-parser

mkdir $PKGROOT
mkdir -p $LICENCE_DIR

cd $SRCROOT
git submodule update --init
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make DESTDIR=$PKGROOT install
cd .. && rm -rf build

cp -r $ROOT/DEBIAN $PKGROOT
cp $SRCROOT/LICENSE.txt $LICENCE_DIR/copyright

dpkg-deb --build $PKGROOT

rm -rf $PKGROOT
