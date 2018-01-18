PKGNAME="liblemon-dev"
PKGVERSION="1.3.1"

ROOT=$(pwd)
SRCROOT=$ROOT/Lemon
PKGROOT=$ROOT/$PKGNAME\_$PKGVERSION

mkdir $PKGROOT

cd $SRCROOT
git submodule update --init
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
make DESTDIR=$PKGROOT install
cd .. && rm -rf build
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=TRUE
make DESTDIR=$PKGROOT install
cd .. && rm -rf build

cp -r $ROOT/DEBIAN $PKGROOT

dpkg-deb --build $PKGROOT

#rm -rf $PKGROOT
