#!/usr/bin/bash
set -euo pipefail

log() {
  echo "=== $* ==="
}

log "Building initramfs"

KERNEL_VERSION=$(rpm -q --queryformat="%{evr}.%{arch}" kernel-core)

/usr/bin/dracut \
  --no-hostonly \
  --kver "$KERNEL_VERSION" \
  --reproducible \
  --zstd \
  -v \
  --add ostree \
  -f "/usr/lib/modules/$KERNEL_VERSION/initramfs.img"

chmod 0600 "/usr/lib/modules/$KERNEL_VERSION/initramfs.img"

log "Build completed"
