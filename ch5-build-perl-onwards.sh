function prebuild_sanity_check {
    if [[ $(whoami) != "lfs" ]] ; then
        echo "Not running as user lfs, you should be!"
        exit 1
    fi

    if ! [[ -v LFS ]] ; then
        echo "You forgot to set the LFS environment variable!"
        exit 1
    fi

    if ! [[ -v LFS_TGT ]] ; then
        echo "You forgot to set the LFS_TGT environment variable!"
        exit 1
    fi

    if ! [[ -d $LFS ]] ; then
        echo "Your LFS directory doesn't exist!"
        exit 1
    fi

    if ! [[ -d $LFS/sources ]] ; then
        echo "Can't find your sources directory!"
        exit 1
    fi

    if [[ $(stat -c %U $LFS/sources) != "lfs" ]] ; then
        echo "The sources directory should be owned by user lfs!"
        exit 1
    fi

    if ! [[ -d $LFS/tools ]] ; then
        echo "Can't find your tools directory!"
        exit 1
    fi

    if [[ $(stat -c %U $LFS/tools) != "lfs" ]] ; then
        echo "The tools directory should be owned by user lfs!"
        exit 1
    fi
}

echo "# 5.29. Perl-5.30.0"
tar -Jxf perl-5.30.0.tar.xz
cd perl-5.30.0
sh Configure -des -Dprefix=/tools -Dlibs=-lm -Uloclibpth -Ulocincpth
make -j $PARALLEL_JOBS
cp -v perl cpan/podlators/scripts/pod2man /tools/bin
mkdir -pv /tools/lib/perl5/5.30.0
cp -Rv lib/* /tools/lib/perl5/5.30.0
cd $LFS/sources
rm -rf perl-5.30.0

echo "# 5.30. Python-3.7.4"
tar -Jxf Python-3.7.4.tar.xz
cd Python-3.7.4
sed -i '/def add_multiarch_paths/a \        return' setup.py
./configure --prefix=/tools --without-ensurepip
make -j $PARALLEL_JOBS
make install
cd $LFS/sources
rm -rf Python-3.7.4

echo "# 5.31. Sed-4.7"
tar -Jxf sed-4.7.tar.xz
cd sed-4.7
./configure --prefix=/tools
make -j $PARALLEL_JOBS
make install
cd $LFS/sources
rm -rf sed-4.7

echo "# 5.32. Tar-1.32"
tar -Jxf tar-1.32.tar.xz
cd tar-1.32
./configure --prefix=/tools
make -j $PARALLEL_JOBS
make install
cd $LFS/sources
rm -rf tar-1.32

echo "# 5.33. Texinfo-6.6"
tar -Jxf texinfo-6.6.tar.xz
cd texinfo-6.6
./configure --prefix=/tools
make -j $PARALLEL_JOBS
make install
cd $LFS/sources
rm -rf texinfo-6.6

echo "# 5.34. Xz-5.2.4"
tar -Jxf xz-5.2.4.tar.xz
cd xz-5.2.4
./configure --prefix=/tools
make -j $PARALLEL_JOBS
make install
cd $LFS/sources
rm -rf xz-5.2.4
