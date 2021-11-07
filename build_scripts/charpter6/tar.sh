source ../file-processing-start.sh $0

./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess)

make 

make DESTDIR=$LFS install

source ../file-cleanup.sh $0
