# ChetOS

## About  ##

This project is to be used in conjunction with the Linux From Scratch (LFS) book 
so that a user will be able to create their own version of Linux with my personal
customisations.

These scripts are designed to be used in conjunction with LFS 9.0
You can find the book: [here](http://www.linuxfromscratch.org/lfs/downloads/stable/LFS-BOOK-9.0.pdf)

## Chapter 5 ##

Chapter 5 needs to be built in 2 steps with both scripts:
  * ch5-build.sh
  * ch5-build-perl-onwards.sh

This is because the first script fails once it gets to Perl.
The second script will build Perl and everything else that needs doing afterwards.

**Chapter 5 is ~= 45.1 SBU's**

## Chapter 6 ##




**Chapter 6 is ~= 171 SBU's**
*With Tests*

It is possible to change the script to not include tests in which case, the total build time
for Chapter 6 is roughly the same as Chapter 5
