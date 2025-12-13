#!/usr/bin/env bash

set -eo pipefail

CONTEXT_PATH="$(realpath "$(dirname "$0")/..")"
BUILD_SCRIPTS_PATH="$(realpath "$(dirname "$0")")"
MAJOR_VERSION_NUMBER="$(sh -c '. /usr/lib/os-release ; echo $VERSION_ID')"
SCRIPTS_PATH="$(realpath "$(dirname "$0")/scripts")"
export CONTEXT_PATH
export SCRIPTS_PATH
export MAJOR_VERSION_NUMBER

run_buildscripts_for() {
	SCRIPT_PATH=$1
	shift
	
	printf "::group:: ===BUILD-SCRIPT-%s===\n" "$(basename "$SCRIPT_PATH")"
	"$(realpath "$SCRIPT_PATH")"
	printf "::endgroup::\n"
}

CUSTOM_NAME="base"

run_buildscripts_for scripts/00-image-info.sh
run_buildscripts_for scripts/01-repos.sh
run_buildscripts_for scripts/02-branding.sh
run_buildscripts_for scripts/03-kernel-replace.sh
run_buildscripts_for scripts/10-desktop-extras.sh
run_buildscripts_for scripts/99-build-initramfs.sh
run_buildscripts_for scripts/999-cleanup.sh

CUSTOM_NAME=
