FROM alpine as build
COPY . /data
WORKDIR /data
RUN apk update && apk upgrade && \
    apk add --no-cache git make g++ sdl2-dev && \
    make && \
    mv build/release-*/ /game && \
    rm -rf /build && \
    apk del --purge sdl2-dev g++ make git


FROM alpine
ENV GAME_DIR /rtcw
COPY --from=build /game $GAME_DIR
WORKDIR $GAME_DIR
CMD /bin/bash