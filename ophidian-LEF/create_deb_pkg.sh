PKGNAME="ophidian-LEF"
PKGVERSION="5.8-1"

ROOT=$(pwd)
SRCROOT=$ROOT/LEF
PKGROOT=$ROOT/$PKGNAME\_$PKGVERSION

cd $SRCROOT
git submodule update --init
make clean
make CXXFLAGS="-fPIC" all

mkdir $PKGROOT
mkdir $PKGROOT/usr
cp -r $SRCROOT/bin $PKGROOT/usr
cp -r $SRCROOT/lib $PKGROOT/usr
cp -r $SRCROOT/include $PKGROOT/usr

cp -r $ROOT/DEBIAN $PKGROOT

dpkg-deb --build $PKGROOT

rm -rf $PKGROOT
