source $DIST_ROOT/LFS-instalation/build_scripts/file-processing-start.sh $(basename $0)

sed -i 's/extras//' Makefile.in

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(./config.guess)

make

make DESTDIR=$LFS install

source $DIST_ROOT/LFS-instalation/build_scripts/file-cleanup.sh $(basename $0)
