#!/bin/sh
#Author: Bulot Geoffrey
#Release: 2016-12-07

echo "******************************";
echo "*                            *";
echo "*  Compressing CSS/JS Files  *";
echo "*                            *";
echo "******************************";

type=$1;
path=$2;

if [ $# -lt 2 ]; then
    echo "\n\t Usage: <type> <path>";
else
    echo "\nWork in progress...Please be patient for a while\n";
fi

saved=0
for f in `find -name "*.css" -not -name "*.min.css"`;
do
	target=${f%.*}.min.css
	echo "\t- "$f to $target
	FILESIZE=$(stat -c%s "$f")
	yui-compressor --type css --nomunge -o $target $f
	FILESIZEC=$(stat -c%s "$target")
	diff=$(($FILESIZE - $FILESIZEC))
	saved=$(($saved + $diff))
	echo "\t  $diff bytes saved"
done

echo "\n";
echo "*******************************";
echo "*  Total saved: $saved bytes  *";
echo "*******************************";
echo "*                             *";
echo "*       Bye Bye dude!!        *";
echo "*******************************";

# params ?
chown www-data.www-data $path/*.min.css
