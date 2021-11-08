source build_scripts/file-processing-start.sh $(basename $0)

./configure --prefix=/usr   \
            --without-guile \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make

make DESTDIR=$LFS install

source build_scripts/file-cleanup.sh $(basename $0)
