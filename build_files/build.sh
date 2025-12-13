#!/bin/bash

set -ouex pipefail

### Install packages

# RPMFusion for goodies
dnf5 -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-43.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-43.noarch.rpm

# Install Terra
dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

# Use vanilla kernel for faster updates and more universal device support
for pkg in kernel kernel{-core,-modules,-modules-core,-modules-extra,-tools-libs,-tools}; do
    rpm --erase $pkg --nodeps
done
rm -rf /usr/lib/modules
rm -f /usr/lib/kernel/install.d/05-rpm-ostree.install

dnf5 -y copr enable @kernel-vanilla/stable
dnf5 -y install \
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

dnf5 versionlock add \
    kernel \
    kernel-devel \
    kernel-core \
    kernel-modules \
    kernel-modules-core \
    kernel-modules-extra

# Install GNOME
dnf5 -y install @gnome-desktop
systemctl enable gdm

# Install Chromium
dnf5 -y install chromium fedora-chromium-config
dnf5 -y remove firefox

# Keyd for cb keyboard mapping
dnf5 -y install keyd
systemctl enable keyd

# Ectool for low-level management related to the embedded controller
dnf5 -y install chromium-ectool

# Install ublue goodies
dnf5 -y copr enable ublue-os/packages
dnf5 -y install \
    ublue-brew \
    ublue-fastfetch \
    ublue-motd \
    ublue-polkit-rules \
    ublue-setup-services
dnf5 -y copr disable ublue-os/packages
