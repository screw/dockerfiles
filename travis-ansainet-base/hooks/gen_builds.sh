#!/bin/bash -xe
_tag=$(git describe --tags --abbrev=0)
_version_tag=$(echo $_tag | sed -e 's/[a-z-]*\([0-9.]\+-[0-9v.]\+\)\(\(-rc[0-9]\+\)*\(-pre[0-9]\+\)*\)*/\1/' )
SOURCE_BRANCH="empty"
for plat in linux windows macosx;
  do for mode in release debug;
    do export DOCKER_TAG="${_version_tag}-${plat}-${mode}"
      echo $DOCKER_TAG
      ./hooks/build
  done
done

