FROM xmarek02/omnetpp-travis-inet:5.4.1-180629

WORKDIR /root
ENV INET_ROOT  /root/inet/

##just testing; in inet it used only across stages not builds
#RUN ccache -cCz
#ENV TARGET_PLATFORM="linux"
#ENV MODE="release"

#ENV PATH="/root/omnetpp-5.4.1-$TARGET_PLATFORM/bin:/usr/lib/ccache:$PATH"


RUN git clone --recursive https://github.com/inet-framework/inet.git

RUN cd $INET_ROOT
#turn off for linux, yes for windows
#EVN PCH="no"

RUN cd $INET_ROOT &&  \
    cp -r /root/nsc-0.5.3 3rdparty && \
    make makefiles  && \
    make -j $(nproc)
#


#RUN cp -r inet/ inet.linux && cp -r inet/ inet.macosx && cp -r inet/ inet.windows

#RUN cd inet.linux/ && \
#    make makefiles  && \
#    make -j $(nproc) && \
#    cd -

#RUN cd inet/inet.macosx/ && \
#    make makefiles  && \
#    make -j $(nproc) && \
#    cd -

#RUN cd inet/windows/ && \
#    make makefiles  && \
#    make -j $(nproc) && \
#    cd -



