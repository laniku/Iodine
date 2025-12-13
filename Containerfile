FROM scratch AS ctx
COPY build_files /
COPY system_files /

FROM ghcr.io/ublue-os/silverblue-main:43

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    /ctx/branding.sh && \
    ostree container commit
    
RUN bootc container lint
