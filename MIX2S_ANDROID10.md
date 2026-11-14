# Xiaomi Mi Mix 2S — Android 10 build profile

This source tree now includes an API-29 profile intended for the Xiaomi Mi Mix
2S (Snapdragon 845 / Adreno 630), running Android 10. It keeps the normal
Android 12+ defaults untouched.

## Build from scratch

The Android 10 profile deliberately uses a separate build base because native
libraries and CMake caches built for API 31 must not be reused for API 29.

```bash
source build_files/android/env_mix2s_android10.sh

# Build every third-party dependency against Android API 29.
build_files/android/deps/build.sh all

# Start with the smaller feature profile; use `full` after this is stable.
python3 build_files/android/build.py lite
```

The generated APK is under:

```text
../blender_build_android_mix2s_api29/apk/
```

The APK build is arm64-v8a only. Do not copy the API-31 `lib/android_arm64`
prefix or its prebuilt `.so` files into this API-29 build. Rebuild dependencies
from source in the dedicated build base.

## Compatibility changes in this profile

- Native compilation and APK minimum/target SDK are set to API 29.
- The manifest opts into Android 10 legacy external-storage behavior. The app
  requests the Android 10 READ/WRITE storage runtime permissions instead of
  opening the Android 11+ all-files-access settings page.
- `StorageVolume.getDirectory()` is used only on API 30+; Android 10 uses a
  guarded reflective lookup of its legacy `getPath()` method for removable
  volumes (with the existing content-URI copy fallback if that is unavailable).
- Android 12 splash-screen theme attributes are isolated in `values-v31`.
- Gradle packaging can be configured with `-PandroidMinSdk=29
  -PandroidTargetSdk=29`; the repository's direct `package.sh`/`build.py` path
  reads the SDK levels from the sourced environment profile.

## Important device caveat

This profile has not been compiled or run on a Mi Mix 2S in this workspace.
A successful APK build is still required to prove that every third-party native
library links against API 29. Runtime graphics support also depends on the
installed Xiaomi/Qualcomm Adreno 630 Vulkan driver and ROM. If Blender starts
but Vulkan initialization fails, capture `adb logcat` before changing the
Vulkan backend or forcing a different driver.
