source ../file-processing-start.sh $1

mkdir -pv build
cd build

../configure --prefix=$LFS/tools \
  --with-sysroot=$LFS \
  --target=$LFS_TGT   \
  --disable-nls       \
  --disable-werror    

make && make install 

source ../file-cleanup.sh $1