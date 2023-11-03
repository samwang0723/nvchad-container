#!/bin/bash
# ./apksize.sh | sort -n | uniq
PACKAGES=`apk info -e -s \*`

a=`echo "$PACKAGES" | awk 'NR % 3 == 1' | cut -d ' ' -f 1`
PKGNAMES=($a)
a=`echo "$PACKAGES" | awk 'NR % 3 == 2'`
PKGSIZES=($a)

for i in ${!PKGNAMES[@]}; do
  echo -e "${PKGSIZES[$i]} - ${PKGNAMES[$i]}"
done
