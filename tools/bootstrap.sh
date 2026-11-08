#!/bin/sh
# One-time setup for a fresh checkout on macOS (Apple silicon):
#   - Python virtualenv with SkoolKit 10.1 (+ Pillow, numpy) in .venv/
#   - the zx-spectrum-skills repo (the disassembly framework) in external/
#   - GNU coreutils (timeout), which the skill requires
#   - the Fuse for macOS source, arm64 branch, with its submodules, in external/
#   - GNU make 4 (gmake); macOS ships make 3.81
#   - pasmo 0.5.5 built from source into .venv/bin (no Homebrew formula)
set -e
cd "$(dirname "$0")/.."

PY=${PYTHON:-/opt/homebrew/bin/python3.14}
[ -x .venv/bin/python ] || "$PY" -m venv .venv
.venv/bin/pip install -q -r tools/requirements.txt

command -v gmake >/dev/null || brew install make
command -v timeout >/dev/null || brew install coreutils

# pasmo 0.5.5 (no Homebrew formula): build from source into the venv.
if [ ! -x .venv/bin/pasmo ]; then
  venv=$(pwd)/.venv
  tmp=$(mktemp -d)
  curl -sSL https://pasmo.speccy.org/bin/pasmo-0.5.5.tar.gz | tar xz -C "$tmp"
  (cd "$tmp/pasmo-0.5.5" && ./configure --prefix="$venv" >/dev/null && make >/dev/null && make install >/dev/null)
fi

mkdir -p external
[ -d external/zx-spectrum-skills ] || \
  git clone https://github.com/morozov/zx-spectrum-skills.git external/zx-spectrum-skills

if [ ! -d external/fuse-for-macos ]; then
  git clone -b arm64 https://git.code.sf.net/p/fuse-for-macosx/fuse-for-macos external/fuse-for-macos
  # .gitmodules uses git://, which many networks block; fetch over https.
  for m in FuseGenerator FuseImporter audiofile fuse libgcrypt; do
    url=$(git -C external/fuse-for-macos config -f .gitmodules "submodule.$m.url" | sed 's#^git://#https://#')
    git -C external/fuse-for-macos config "submodule.$m.url" "$url"
  done
  git -C external/fuse-for-macos submodule update --init --recursive
fi

echo "Bootstrap done. Next: gmake restore   (then tools/build_fuse.sh to build Fuse)"
