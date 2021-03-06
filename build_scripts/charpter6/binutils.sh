source $DIST_ROOT/LFS-instalation/build_scripts/file-processing-start.sh $(basename $0)

mkdir -v build
cd build

../configure                   \
    --prefix=/usr              \
    --build=$(../config.guess) \
    --host=$LFS_TGT            \
    --disable-nls              \
    --enable-shared            \
    --disable-werror           \
    --enable-64-bit-bfd

make

make DESTDIR=$LFS install -j1
install -vm755 libctf/.libs/libctf.so.0.0.0 $LFS/usr/lib

source $DIST_ROOT/LFS-instalation/build_scripts/file-cleanup.sh $(basename $0)
