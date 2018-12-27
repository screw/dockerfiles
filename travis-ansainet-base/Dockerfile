ARG OMNETPP_VER
FROM xmarek02/omnetpp-travis-inet:${OMNETPP_VER}-180629

WORKDIR /root
ARG TARGET_PLATFORM
ARG MODE
ARG OMNETPP_VER
ARG INET_VER

# ADD checkout for specific tag
# Omit --recursive? (not needed for build, but the image is used for fingerprinting as well)
RUN git clone --recursive https://github.com/screw/inet.git

ENV INET_BASE /root/inet
ENV INET_ROOT /root/inet

ENV TARGET_PLATFORM ${TARGET_PLATFORM:-linux}
ENV MODE ${MODE:-release}

#RUN echo $OMNETPP_VER

##just testing; in inet it used only across stages not builds
#RUN ccache -cCz

#ENV PATH="/root/omnetpp-5.4.1-$TARGET_PLATFORM/bin:/usr/lib/ccache:$PATH"

#RUN cd $INET_BASE && cp -r /root/nsc-0.5.3 3rdparty 

# The following is a combination of INET's setenv and _scripts/travis/
# Why not just call the INET's scripts??????
# Set TRAVIS_REPO_SLUG and pretend it's INET's Travis-CI build
# Don't forget to check INET_ROOT in ANSA travis.yml when changing to use INET's script

RUN cd $INET_BASE && \
    export TRAVIS_REPO_SLUG="root/inet" && \
    bang='#!/bin/bash' && sed -i "1c\#!/bin/bash" ./_scripts/travis/travis-stage-build.sh && \
    chmod +x ./_scripts/travis/travis-stage-build.sh && \
    ./_scripts/travis/travis-stage-build.sh

#RUN for platform in linux windows macosx; \
#RUN for platform in $TARGET_PLATFORM; \
#    do for mode in $MODE; \
#      do cp -r $INET_BASE $INET_BASE-$platform-$mode; \
#        cd $INET_BASE-$platform-$mode; \
#        TARGET_PLATFORM=$platform && \
#        MODE=$mode && \
#        export PATH="/root/omnetpp-${OMNETPP_VER}-$TARGET_PLATFORM/bin:$PATH" && \
#        export INET_ROOT=`pwd` && \
#        echo $INET_ROOT && \
#        export PATH=$INET_ROOT/bin:$PATH && \
#        export INET_NED_PATH="$INET_ROOT/src:$INET_ROOT/tutorials:$INET_ROOT/showcases:$INET_ROOT/examples" && \
#        export INET_OMNETPP_OPTIONS="-n $INET_NED_PATH --image-path=$INET_ROOT/images" && \
#        export INET_GDB_OPTIONS="-quiet -ex run --args" && \
#        export INET_VALGRIND_OPTIONS="-v --tool=memcheck --leak-check=yes --show-reachable=no --leak-resolution=high --num-callers=40 --freelist-vol=4000000" && \
#        if [ "$TARGET_PLATFORM" = "linux" ]; then \
#          opp_featuretool enable VoIPStream VoIPStream_examples TCP_NSC TCP_lwIP && \
#          echo "CFLAGS += -fcolor-diagnostics\n\n$(cat src/makefrag)" > src/makefrag && \
#          PCH=no; \
#        else \ 
#          PCH=yes; fi; \
#        if [ "$TARGET_PLATFORM" = "windows" ]; then \
#          echo "LDFLAGS += -Wl,--stats -Wl,--no-keep-memory\n\n$(cat src/makefrag)" > src/makefrag; \
#        fi; \
#        make makefiles && \
#        make MODE=$MODE USE_PRECOMPILED_HEADER=$PCH  -j $(nproc); \
#      done; \
#    done && rm -r $INET_BASE




