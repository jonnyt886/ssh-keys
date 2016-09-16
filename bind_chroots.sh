#!/bin/sh

CURDIR=`dirname "$0"`

cd $CURDIR/chroots
cat chroots | while read src dst; do
	[ ! -d "$dst" ] && mkdir -p "$dst"
	mount --bind $src $dst
done
