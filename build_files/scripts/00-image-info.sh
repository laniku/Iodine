#!/usr/bin/env bash
set -eoux pipefail

IMAGE_INFO="/usr/share/ublue-os/image-info.json"
IMAGE_VENDOR=laniku
IMAGE_NAME=iodine

mkdir -p "$(dirname "$IMAGE_INFO")"
if [ ! -f "$IMAGE_INFO" ]; then
    echo "{}" > "$IMAGE_INFO"
fi

IMAGE_REF="ostree-image-signed:docker://ghcr.io/$IMAGE_VENDOR/$IMAGE_NAME"

sed -i 's/\"image-name\": [^,]*/\"image-name\": \"'"$IMAGE_NAME"'\"/' "$IMAGE_INFO" || true
sed -i 's|\"image-ref\": [^,]*|\"image-ref\": \"'"$IMAGE_REF"'\"|' "$IMAGE_INFO" || true

sed -i "s/^VARIANT_ID=.*/VARIANT_ID=$IMAGE_NAME/" /usr/lib/os-release || true
