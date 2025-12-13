#!/usr/bin/bash
set -euo pipefail

log() {
  echo "=== $* ==="
}

log "Starting system cleanup"

# Clean package manager cache to reduce image size
dnf5 clean all

# Clean temporary files
rm -rf /tmp/*

# Cleanup the entirety of `/var`. This is mandatory for a clean bootc/OSTree image
rm -rf /var
mkdir -p /var

# Commit and lint container
bootc container lint || true

log "Cleanup completed"
