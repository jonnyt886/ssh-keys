#!/bin/sh

set -eu

TARGET_USER="$1"

CURDIR=`dirname "$0"`

find $CURDIR/enabled/ -name "$TARGET_USER"@\* | while read f; do
	F=`basename "$f"`
	F_USER=${F%%@*}
	F_HOST=${F##*@}

	# look up the IP address and FQDN from DNS and add those to the list
	F_HOST2=`nslookup "$F_HOST" 2>/dev/null | egrep -v '^Server' | grep -v '#53' | sed -e 's/.*: *//' | egrep -v '^$' | tr --delete '\t' | tr '\n' ',' | sed -e 's/,$//'`

	printf "from=\"$F_HOST,$F_HOST2\" "
	cat $f
done
