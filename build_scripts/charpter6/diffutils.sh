source $DIST_ROOT/LFS-instalation/build_scripts/file-processing-start.sh $(basename $0)

./configure --prefix=/usr --host=$LFS_TGT

make

make DESTDIR=$LFS install

source $DIST_ROOT/LFS-instalation/build_scripts/file-cleanup.sh $(basename $0)
