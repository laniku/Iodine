#!/usr/bin/env bash
set -ouex pipefail

# Install GNOME and Enable GDM
dnf5 -y install @gnome-desktop
systemctl enable gdm.service

# Install Chromium and Remove Firefox
dnf5 -y install chromium fedora-chromium-config
dnf5 -y remove firefox

# Install Keyd and Ectool
dnf5 -y install keyd
systemctl enable keyd.service

dnf5 -y install chromium-ectool

# Install ublue goodies
dnf5 -y copr enable ublue-os/packages
dnf -y install ublue-*
dnf5 -y copr disable ublue-os/packages
