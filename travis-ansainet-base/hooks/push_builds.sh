#!/bin/bash -xe
[ -n "$1" ]  || echo "Missing parameter tag"
_version_tag=$(echo $_tag | sed -e 's/[a-z-]*\([0-9.]\+-[0-9v.]\+\)\(\(-rc[0-9]\+\)*\(-pre[0-9]\+\)*\)*/\1/' )
SOURCE_BRANCH="empty"
for plat in linux windows macosx;
  do for mode in release debug;
    do docker push xmarek02/omnetpp-travis-ansainet-base:$1-${plat}-${mode}
  done
done

