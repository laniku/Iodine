ARG BASE_IMAGE_NAME="silverblue"
ARG FEDORA_MAJOR_VERSION="43"

FROM scratch AS ctx
COPY build_files /

FROM ghcr.io/ublue-os/silverblue-main:43

COPY system_files /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache/dnf \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/00-image-info.sh && \
    /ctx/01-repos.sh && \
    ostree container commit

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    /ctx/02-branding.sh && \
    ostree container commit

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache/dnf \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/03-kernel-replace.sh && \
    ostree container commit

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache/dnf \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/10-desktop-extras.sh && \
    ostree container commit

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    /ctx/99-build-initramfs.sh && \
    /ctx/999-cleanup.sh && \
    ostree container commit

RUN bootc container lint
