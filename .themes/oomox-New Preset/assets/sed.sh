#!/bin/sh
sed -i \
         -e 's/#d1ccc4/rgb(0%,0%,0%)/g' \
         -e 's/#101010/rgb(100%,100%,100%)/g' \
    -e 's/#464139/rgb(50%,0%,0%)/g' \
     -e 's/#b49372/rgb(0%,50%,0%)/g' \
     -e 's/#ffffff/rgb(50%,0%,50%)/g' \
     -e 's/#1a1a1a/rgb(0%,0%,50%)/g' \
	"$@"
