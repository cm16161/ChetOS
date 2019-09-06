#!/bin/bash

PARALLEL_JOBS=16

set -o nounset
set -o errexit

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

function check_tarballs {
LIST_OF_TARBALLS="
binutils-2.32.tar.xz
gcc-9.2.0.tar.xz
mpfr-4.0.2.tar.xz
gmp-6.1.2.tar.xz
mpc-1.1.0.tar.gz
linux-5.2.8.tar.xz
glibc-2.30.tar.xz
tcl8.6.9-src.tar.gz
expect5.45.4.tar.gz
dejagnu-1.6.2.tar.gz
m4-1.4.18.tar.xz
ncurses-6.1.tar.gz
bash-5.0.tar.gz
bison-3.4.1.tar.xz
bzip2-1.0.8.tar.gz
coreutils-8.31.tar.xz
diffutils-3.7.tar.xz
file-5.37.tar.gz
findutils-4.6.0.tar.gz
gawk-5.0.1.tar.xz
gettext-0.20.1.tar.xz
grep-3.3.tar.xz
gzip-1.10.tar.xz
make-4.2.1.tar.gz
patch-2.7.6.tar.xz
perl-5.30.0.tar.xz
Python-3.7.4.tar.xz
sed-4.7.tar.xz
tar-1.32.tar.xz
texinfo-6.6.tar.xz
xz-5.2.4.tar.xz
"

for tarball in $LIST_OF_TARBALLS ; do
    if ! [[ -f $LFS/sources/$tarball ]] ; then
        echo "Can't find $LFS/sources/$tarball!"
        exit 1
    fi
done
}

function timer {
     if [[ $# -eq 0 ]]; then
         echo $(date '+%s')
     else
         local stime=$1
         etime=$(date '+%s')
         if [[ -z "$stime" ]]; then stime=$etime; fi
         dt=$((etime - stime))
         ds=$((dt % 60))
         dm=$(((dt / 60) % 60))
         dh=$((dt / 3600))
         printf '%02d:%02d:%02d' $dh $dm $ds
     fi
}

prebuild_sanity_check
check_tarballs

if [[ $(free | grep 'Swap:' | tr -d ' ' | cut -d ':' -f2) == "000" ]] ; then
    echo -e "\nYou are almost certainly going to want to add some swap space before building!"
    echo -e "Continue without swap?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes) break;;
            No) exit;;
        esac
    done
fi

echo -e "\nThis is your last chance to quit before we start building... continue?"
echo "(Note that if anything goes wrong during the build, the script will abort mission)"
select yn in "Yes" "No"; do
    case $yn in
        Yes) break;;
        No) exit;;
    esac
done

./ch5-1-build.sh
./ch5-2-build.sh

echo -e "----------------------------------------------------"
echo -e "\nYou made it! This is the end of chapter 5!"
printf 'Total script time: %s\n' $(timer $total_time)
echo -e "Now continue reading from \"5.36. Changing Ownership\""
