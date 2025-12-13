#!/usr/bin/env bash

set -eo pipefail

CONTEXT_PATH="$(realpath "$(dirname "$0")/..")" # should return /run/context
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

copy_systemfiles_for() {
	WHAT=$1
	shift
	DISPLAY_NAME=$WHAT
	if [ "${CUSTOM_NAME}" != "" ] ; then
		DISPLAY_NAME=$CUSTOM_NAME
	fi
	printf "::group:: ===%s-file-copying===\n" "${DISPLAY_NAME}"
	
	find "${CONTEXT_PATH}/files/$WHAT" -maxdepth 1 -print0 | while IFS= read -r -d $'\0' file ; do
		if [ -d "$file" ] ; then
			if [ "$(basename "$file")" != "root" ] ; then
				rsync -a -v --ignore-times --exclude='.git' "${file}" "/${file}"
			fi
		fi
	done
	
	if [ -d "${CONTEXT_PATH}/files/$WHAT/root" ] ; then
		rsync -a -v --ignore-times --exclude='.git' "${CONTEXT_PATH}/files/$WHAT/root/" "/"
	fi
	
	printf "::endgroup::\n"
}

CUSTOM_NAME="base"
copy_systemfiles_for files

run_buildscripts_for scripts/00-image-info.sh
run_buildscripts_for scripts/01-repos.sh
run_buildscripts_for scripts/02-branding.sh
run_buildscripts_for scripts/03-kernel-replace.sh
run_buildscripts_for scripts/10-desktop-extras.sh
run_buildscripts_for scripts/20-install-apps.sh
run_buildscripts_for scripts/40-services.sh
run_buildscripts_for scripts/50-fix-opt.sh
run_buildscripts_for scripts/60-clean-base.sh
run_buildscripts_for scripts/99-build-initramfs.sh
run_buildscripts_for scripts/999-cleanup.sh

CUSTOM_NAME=
