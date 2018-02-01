set -e

CURRENT_DIR=$(pwd)
SCRIPT=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT")

FILES=$SCRIPT_DIR/pkg_files

echo "Running script: ${SCRIPT}"

PKG_NAME="def"
PKG_VERSION="5.8"
PKG_REVISION="1"

SOURCE_DIR_NAME=$PKG_NAME-$PKG_VERSION

GIT_URL="http://gitlab.com/eclufsc/DEF.git"
SOURCE_DIR=$SCRIPT_DIR/$SOURCE_DIR_NAME
git clone $GIT_URL $SOURCE_DIR

PKG_DIR=$SCRIPT_DIR/pkg
PKG_SOURCE_DIR=$PKG_DIR/$SOURCE_DIR_NAME

TAR_NAME=$PKG_NAME\_$PKG_VERSION.orig.tar.gz
TAR_FILE=$PKG_DIR/$TAR_NAME

LICENSE_FILE=$SOURCE_DIR/LICENSE.TXT

# Create pkg dir
install -d $PKG_DIR

cd $SCRIPT_DIR
tar czf $TAR_FILE $SOURCE_DIR_NAME 

cd $PKG_DIR
tar xzf $TAR_NAME

PKG_DEBIAN_DIR=$PKG_SOURCE_DIR/debian
install -d $PKG_DEBIAN_DIR
install -d $PKG_DEBIAN_DIR/source

# write the debian/control file
install -D $FILES/control $PKG_DEBIAN_DIR/control

# write the debian/rules file
install -D $FILES/rules $PKG_DEBIAN_DIR/rules

# install debian license
touch $PKG_DEBIAN_DIR/copyright
cat $LICENSE_FILE > $PKG_DEBIAN_DIR/copyright

# compatibilit level ?
touch $PKG_DEBIAN_DIR/compat
echo "10" > $PKG_DEBIAN_DIR/compat

touch $PKG_DEBIAN_DIR/source/format
echo "3.0 (quilt)" > $PKG_DEBIAN_DIR/source/format

cd $PKG_SOURCE_DIR
dch --create -v $PKG_VERSION-$PKG_REVISION --package $PKG_NAME
debuild -us -uc 
