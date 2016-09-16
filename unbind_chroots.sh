#!/bin/sh

CURDIR=`dirname "$0"`

cd $CURDIR/chroots

find -mindepth 2 -maxdepth 2 -type d | while read f; do
	umount "$f"
	rmdir "$f"
done
