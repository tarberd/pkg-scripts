PKGNAME="ophidian-DEF"
PKGVERSION="5.8-2"

ROOT=$(pwd)
DEFROOT=$ROOT/DEF
PKGROOT=$ROOT/$PKGNAME\_$PKGVERSION

cd $DEFROOT
git submodule update --init
make clean
make CXXFLAGS="-fPIC" all

mkdir $PKGROOT
mkdir $PKGROOT/usr
cp -r $DEFROOT/bin $PKGROOT/usr
cp -r $DEFROOT/lib $PKGROOT/usr
cp -r $DEFROOT/include $PKGROOT/usr

cp -r $ROOT/DEBIAN $PKGROOT

dpkg-deb --build $PKGROOT

rm -rf $PKGROOT
