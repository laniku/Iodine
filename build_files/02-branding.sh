#!/usr/bin/env bash
set -ouex pipefail

source /usr/lib/os-release || false

IMAGE_PRETTY_NAME="Iodine"
IMAGE_LIKE="fedora"
HOME_URL="https://github.com/laniku/Iodine/"
SUPPORT_URL="https://github.com/laniku/Iodine/issues"
BUG_SUPPORT_URL="https://github.com/ecstasy-rh/laniku/issues"
CODE_NAME="Forty-Three"
#VERSION="${VERSION:-00.00000000}"
IMAGE_NAME=iodine
IMAGE_VENDOR=laniku


# OS Release File
sed -i "s|^NAME=.*|NAME=\"Iodine\"|" /usr/lib/os-release
sed -i "s|^PRETTY_NAME=.*|PRETTY_NAME=\"${IMAGE_PRETTY_NAME} ${VERSION} (${CODE_NAME} / FROM Fedora ${VERSION} Silverblue)\"|" /usr/lib/os-release
sed -i "s|^HOME_URL=.*|HOME_URL=\"$HOME_URL\"|" /usr/lib/os-release
sed -i "s|^SUPPORT_URL=.*|SUPPORT_URL=\"$SUPPORT_URL\"|" /usr/lib/os-release
sed -i "s|^BUG_REPORT_URL=.*|BUG_REPORT_URL=\\\"$BUG_SUPPORT_URL\\\"|" /usr/lib/os-release
sed -i "s|^DEFAULT_HOSTNAME=.*|DEFAULT_HOSTNAME=\"iodine\"|" /usr/lib/os-release
sed -i "s|^VERSION_CODENAME=.*|VERSION_CODENAME=\"$CODE_NAME\"|" /usr/lib/os-release

# Set static hostname
hostnamectl set-hostname --static iodine
