#!/bin/bash
echo "Dist root: ${DIST_ROOT}"
echo "LFS: ${LFS:?}"

#if ! grep -q "$LFS" /proc/mounts; then
#  source setupdisk.sh "$LFS_DISK" # if LFS is not mount yet 
#  sudo mount "${LFS_DISK}2" "$LFS" 
#  sudo chown -v $USER "$LFS" # in the LFS book they create a few directories and chenge the owner for each one, chenge the owner of the whole mount point to $USER will work, and we dont need use "sudo" to create directories and files anymore
#fi

# intermediate cross compiling
mkdir -pv $LFS/sources # download tarballs here 
chmod -v a+wt $LFS/sources
mkdir -pv $LFS/tools # cross compiling sit here

# basic linux structure
mkdir -pv $LFS/{boot,etc,bin,lib,sbin,usr,var}

case $(uname -m) in # check if we are compiling to a x86_64 machine
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

## DONWLOAD SECTION
cp -rf *.sh packages.json charpter* "$LFS/sources"
cd "$LFS/sources"
#export PATH="$LFS/tools/bin:$PATH"

source download.sh

if ! test $(id -u distbuild); then

  groupadd distbuild
  useradd -s /bin/bash -g distbuild -m -k /dev/null distbuild
  passwd distbuild
  
  chown distbuild $LFS/{boot,etc,bin,lib,sbin,usr,var,tools,sources/*}
  case $(uname -m) in # check if we are compiling to a x86_64 machine
    x86_64) chown distbuild $LFS/lib64 ;;
  esac
  
  dbhome=$(eval echo "~distbuild")

  cat > $dbhome/.bash_profile << EOF
    exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

  cat > $dbhome/.bashrc << EOF
    set +h
    umask 022
    LFS=$LFS
    DIST_ROOT=$DIST_ROOT
EOF

  cat >> $dbhome/.bashrc << EOF
    LC_ALL=POSIX
    LFS_TGT=$(uname -m)-lfs-linux-gnu
    PATH=/usr/bin
    if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
    PATH=$LFS/tools/bin:$PATH
    CONFIG_SITE=$LFS/usr/share/config.site
    export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
    MAKEFLAGS="-j4"
EOF

  fi
  


## COMPILE SECTION
#binutils gcc linux 
#for package in glibc; do
#  source packageinstall.sh 5 $package
#done
