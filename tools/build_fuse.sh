#!/bin/sh
# Build Fuse for macOS from the arm64 branch of
# https://sourceforge.net/p/fuse-for-macosx/fuse-for-macos/ (cloned into
# external/fuse-for-macos by tools/bootstrap.sh), following the order in its
# README: the three frameworks, the Quick Look and Spotlight plug-ins, then
# the emulator. Needs Xcode; the help book step also needs ruby + jekyll.
#
# The app lands in external/fuse-for-macos/fuse/fusepb/build/Deployment/.
set -e
# The help book is built with Jekyll 4, which needs a newer ruby than macOS
# ships: brew install ruby && $(brew --prefix ruby)/bin/gem install jekyll
for d in /opt/homebrew/opt/ruby/bin /opt/homebrew/lib/ruby/gems/*/bin; do
  [ -d "$d" ] && PATH="$d:$PATH"
done
export PATH
# Xcode 15 and later refuse the projects' 11.5 deployment target.
target="MACOSX_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET:-12.0}"
root=$(cd "$(dirname "$0")/.." && pwd)/external/fuse-for-macos
log=$root/../fuse-build.log
: > "$log"

step() {
  echo "== $1" | tee -a "$log"
  (cd "$root/$1" && shift && "$@") >> "$log" 2>&1 || {
    echo "FAILED in $1 - see $log" >&2; tail -30 "$log" >&2; exit 1; }
}

step audiofile     xcodebuild -configuration Deployment "$target"
step libgcrypt     xcodebuild -configuration Deployment "$target"
step FuseGenerator xcodebuild -configuration Release "$target"
step FuseImporter  xcodebuild -configuration Deployment "$target"
step fuse/fusepb   make
step fuse/fusepb   xcodebuild -configuration Deployment "$target"

app=$(find "$root/fuse/fusepb/build" -name Fuse.app -maxdepth 3 | head -1)
echo "Built: $app"
