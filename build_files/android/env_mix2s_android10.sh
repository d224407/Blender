#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2026 Blender Authors
# SPDX-License-Identifier: GPL-2.0-or-later
#
# Xiaomi Mi Mix 2S (Snapdragon 845 / Adreno 630), Android 10 profile.
# Source this instead of env.sh before building dependencies and the APK:
#   source build_files/android/env_mix2s_android10.sh
#   build_files/android/deps/build.sh all
#   python3 build_files/android/build.py lite
#
# A separate build base is intentional: API-29 libraries must not share a
# prefix or CMake cache with the existing Android-12/API-31 build.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

export ANDROID_ABI="arm64-v8a"
export ANDROID_API="29"
export ANDROID_TARGET_API="29"
export BUILD_BASE="${MIX2S_BUILD_BASE:-$(cd "$REPO_ROOT/.." && pwd)/blender_build_android_mix2s_api29}"

# shellcheck source=/dev/null
source "$SCRIPT_DIR/env.sh"
echo "[mix2s-android10] build base: $BUILD_BASE"
