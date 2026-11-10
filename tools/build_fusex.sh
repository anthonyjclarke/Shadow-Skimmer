#!/bin/sh
# Build FuseX from the main branch of https://github.com/speccytools/fusex into
# external/fusex, on Apple silicon with Xcode 27. It is the emulator the
# skill's zx-fuse-driver and relocation oracle run the game in: they load
# libfusex, which step 3 builds. The build is unsigned (ad-hoc).
#
# Needs Xcode and, beyond what bootstrap.sh installs:
#   brew install autoconf automake libtool
# The macOS libfusex is configured --without-png and libspectrum
# --with-fake-glib, so neither glib nor libpng is linked.
#
# Use it without installing into /Applications:
#   export FUSEX_LIB=$(pwd)/external/fusex/build/libfusex/libfusex.dylib
#   export FUSEX_ROMS=$(pwd)/external/fusex/roms
set -e
root=$(cd "$(dirname "$0")/.." && pwd)/external/fusex
[ -d "$root/.git" ] || git clone -b main https://github.com/speccytools/fusex "$root"
cd "$root"
git submodule update --init --recursive --depth 1

# Ad-hoc signing: the Xcode projects name the upstream team (48UV5KV3FB).
SIGN="CODE_SIGN_IDENTITY=- CODE_SIGN_STYLE=Manual DEVELOPMENT_TEAM="
# Xcode 27 rejects the projects' old deployment targets; Makefile.darwin
# already passes 12.0.
XC="SYMROOT=build BUILD_DIR=build CONFIGURATION_BUILD_DIR=build/Deployment MACOSX_DEPLOYMENT_TARGET=12.0"

# 1. Frameworks. Makefile.darwin's targets work with the signing override.
make -f Makefile.darwin audiofile libgcrypt mbedtls libssh2 \
  CODE_SIGN_IDENTITY=- DEVELOPMENT_TEAM=

# 2. Quick Look plug-ins and FuseImporter. Both fail to link on Xcode 27
#    (undefined _iconv, _iconv_open and _iconv_close from libspectrum's tape
#    text conversion), so they link -liconv.
(cd 3rdparty/FuseGenerator && xcodebuild -project FuseGenerator.xcodeproj \
  -target FuseQLThumbnail -target FuseQLPreview -configuration Deployment \
  $XC $SIGN 'OTHER_LDFLAGS=$(inherited) -liconv')
(cd 3rdparty/FuseImporter && xcodebuild -project FuseImporter.xcodeproj \
  -target FuseImporter -configuration Deployment \
  $XC $SIGN 'OTHER_LDFLAGS=$(inherited) -liconv')

# 3. Generated sources, then libfusex (libspectrum static, --with-null-ui).
#    This alone is enough for the skill's FuseX driver.
make -f Makefile.darwin fusepb
make -f Makefile.darwin libfusex

# 4. The app. Its Metal shader step needs Apple's Metal Toolchain, a separate
#    component: run `xcodebuild -downloadComponent MetalToolchain` once, then
#    this script again. Without it the bundle lacks Contents/MacOS/FuseX, but
#    its build phase has already copied build/libfusex/libfusex.dylib into
#    Contents/Frameworks and the ROMs into Contents/Resources.
(cd fusepb && xcodebuild -project FuseX.xcodeproj -target FuseX \
  -configuration Deployment $XC $SIGN) || echo "App step failed: see the Metal Toolchain note in $0"

echo "Built: $root/fusepb/build/Deployment/FuseX.app"
