#ARG OMNETPP_VER
FROM xmarek02/omnetpp-travis-inet:5.4.1-180629

WORKDIR /root
ARG TARGET_PLATFORM
ARG MODE
ARG OMNETPP_VER
ARG INET_VER
ENV TARGET_PLATFORM ${TARGET_PLATFROM:-linux}
ENV MODE ${MODE:-release}

ENV INET_ROOT  /root/inet
ENV INET_BASE /root/inet

#RUN echo $OMNETPP_VER

##just testing; in inet it used only across stages not builds
RUN ccache -cCz

ENV TARGET_PLATFORM ${TARGET_PLATFROM:-linux} 
ENV MODE ${MODE:-release} 

#RUN echo "MODE: $MODE, target: $TARGET_PLATFORM"
#ENV PATH="/root/omnetpp-5.4.1-$TARGET_PLATFORM/bin:/usr/lib/ccache:$PATH"

# ADD checkout for specific tag
RUN git clone --recursive https://github.com/screw/inet.git

RUN cd $INET_BASE && cp -r /root/nsc-0.5.3 3rdparty 

#turn off for linux, yes for windows
#ENV PCH="no"

#RUN for platform in linux windows macosx; \
RUN for platform in $TARGET_PLATFORM; \
    do for mode in $MODE; \
      do cp -r $INET_BASE $INET_BASE-$platform-$mode; \
        cd $INET_BASE-$platform-$mode; \
        TARGET_PLATFORM=$platform && \
        MODE=$mode && \
        export PATH="/root/omnetpp-${OMNETPP_VER}-$TARGET_PLATFORM/bin:$PATH" && \
        export INET_ROOT=`pwd` && \
        echo $INET_ROOT && \
        export PATH=$INET_ROOT/bin:$PATH && \
        export INET_NED_PATH="$INET_ROOT/src:$INET_ROOT/tutorials:$INET_ROOT/showcases:$INET_ROOT/examples" && \
        export INET_OMNETPP_OPTIONS="-n $INET_NED_PATH --image-path=$INET_ROOT/images" && \
        export INET_GDB_OPTIONS="-quiet -ex run --args" && \
        export INET_VALGRIND_OPTIONS="-v --tool=memcheck --leak-check=yes --show-reachable=no --leak-resolution=high --num-callers=40 --freelist-vol=4000000" && \
        if [ "$TARGET_PLATFORM" = "linux" ]; then \
          opp_featuretool enable VoIPStream VoIPStream_examples TCP_NSC TCP_lwIP && \
          echo "CFLAGS += -fcolor-diagnostics\n\n$(cat src/makefrag)" > src/makefrag && \
          PCH=no; \
        else \ 
          PCH=yes; fi; \
        if [ "$TARGET_PLATFORM" = "windows" ]; then \
          echo "LDFLAGS += -Wl,--stats -Wl,--no-keep-memory\n\n$(cat src/makefrag)" > src/makefrag; \
        fi; \
        make makefiles && \
        make MODE=$MODE USE_PRECOMPILED_HEADER=$PCH  -j $(nproc); \
      done; \
    done && rm -r $INET_BASE

#cd $INET_ROOT-$MODE &&  \
#    cp -r /root/nsc-0.5.3 3rdparty && \
#    opp_featuretool enable VoIPStream VoIPStream_examples TCP_NSC TCP_lwIP && \
#    make makefiles  && \
#    make -j $(nproc)
#


#RUN cp -r inet/ inet.linux && cp -r inet/ inet.macosx && cp -r inet/ inet.windows

#RUN cd inet-linux/ && \
#    make makefiles  && \
#    make -j $(nproc) && \
#    cd -

#RUN cd inet-inet.macosx/ && \
#    make makefiles  && \
#    make -j $(nproc) && \
#    cd -

#RUN cd inet-windows/ && \
#    make makefiles  && \
#    make -j $(nproc) && \
#    cd -



