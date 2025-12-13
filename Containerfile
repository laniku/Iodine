FROM scratch AS ctx
COPY build_files /

FROM ghcr.io/ublue-os/silverblue-main:43
COPY system_files /

RUN --mount=type=bind,from=ctx,source=/ctx,target=/ctx \
    --mount=type=cache,dst=/var/cache/dnf \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh
