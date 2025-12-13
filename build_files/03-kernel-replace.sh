#!/usr/bin/env bash
set -ouex pipefail

# Remove Existing Fedora Kernel
for pkg in kernel kernel{-core,-modules,-modules-core,-modules-extra,-tools-libs,-tools}; do
    rpm --erase $pkg --nodeps
done
rm -rf /usr/lib/modules

# This should prevent the "05-rpm-ostree.install failed with exit status 1" crash
install -m 000 /dev/null /usr/lib/kernel/install.d/05-rpm-ostree.install

# Install Vanilla Kernel
dnf5 -y copr enable @kernel-vanilla/stable
dnf5 -y install --setopt=install_weak_deps=False \
    kernel \
    kernel-core \
    kernel-modules \
    kernel-modules-core \
    kernel-modules-extra \
    kernel-devel \
    kernel-headers \
    kernel-tools \
    kernel-tools-libs
dnf5 -y copr disable @kernel-vanilla/stable

# Version lock
dnf5 versionlock add \
    kernel \
    kernel-devel \
    kernel-core \
    kernel-modules \
    kernel-modules-core \
    kernel-modules-extra
