# Shadow Skimmer – ZX Spectrum disassembly

A reassemblable disassembly of *Shadow Skimmer* (The Edge / Softek, 1987; John Marshall code, Jack Wilkes graphics), built from the snapshot `SHADSKIM.Z80` with [SkoolKit](https://skoolkit.ca) and the [`zx-game-disasm`](https://github.com/morozov/zx-spectrum-skills) skill, and tested in [Fuse for macOS](https://sourceforge.net/p/fuse-for-macosx/fuse-for-macos/ci/arm64/tree/) built from its `arm64` branch.

**Status (08-11-2026):** stage 2 of the skill (code/data map) is done and the round trip is green. `gmake restore` rebuilds `SHADSKIM.Z80` from source and it is identical to the original, byte for byte (41,483 bytes). Documentation (stage 3) has not started; see `docs/DISASSEMBLY.md`.

---

## Quick start

Run these once on a fresh checkout:

```bash
tools/bootstrap.sh
```

```bash
gmake restore
```

```bash
tools/build_fuse.sh
```

```bash
gmake fuse
```

In VS Code, the same steps are in **Terminal → Run Task** (`.vscode/tasks.json`); `gmake restore` is the default build task (⇧⌘B).

| Command          | What it does                                  |
|:-----------------|:----------------------------------------------|
| `gmake restore`  | Rebuild `SHADSKIM.Z80` from source, `cmp` it  |
| `gmake fuse`     | `restore`, then open the result in Fuse       |
| `gmake coverage` | The skill's "is it done?" gauge               |
| `gmake html`     | HTML site in `build/html/`                    |
| `gmake`          | The skill's full gate (needs `pasmo`)         |

---

## Layout

| Path                         | Holds                                        |
|:-----------------------------|:---------------------------------------------|
| `SHADSKIM.Z80`               | The original snapshot (ground truth)         |
| `src/shadskim.ctl`           | Control file for the code block $61A8–$F9FF  |
| `src/environment.ctl`        | Screen, system vars, BASIC, top of RAM       |
| `src/shadskim.z80header`     | The 86-byte `.z80` header, annotated         |
| `src/shadskim.t2s`           | Provenance note (no tape image exists here)  |
| `tools/z80snap.py`           | Unpack / rebuild `.z80` files exactly        |
| `tools/coverage_trace.py`    | Headless scripted play, logs executed code   |
| `tools/extend_map.py`        | Adds untaken branches to an execution map    |
| `tools/build_fuse.sh`        | Builds Fuse for macOS (arm64) from source    |
| `tools/bootstrap.sh`         | venv, skill repo, Fuse source, GNU make      |
| `vendor/zx-game-disasm/`     | The skill's site build (`make vendor` copy)  |
| `external/`                  | Skill repo and Fuse source (not tracked)     |
| `build/`                     | Everything generated (not tracked)           |
| `docs/DISASSEMBLY.md`        | Findings, method and the road ahead          |

The `.ctl` files are the only hand-edited sources. The `.skool`, `.asm` and binaries under `build/` are generated from them.

---

## Requirements

You need macOS on Apple silicon with Xcode, Homebrew Python 3.11 or newer, and GNU make 4 (`brew install make`, run as `gmake`). SkoolKit 10.1, Pillow and numpy are installed in `.venv/` by `tools/bootstrap.sh`. Building Fuse also needs Homebrew ruby with the `jekyll` gem for its help book.

[`pasmo`](https://pasmo.speccy.org/) 0.5.5 assembles the `.asm` for both `gmake restore` and the skill's gate. Homebrew has no formula for it, so `tools/bootstrap.sh` builds it from source into `.venv/bin`. If it is missing, `gmake restore` falls back to SkoolKit's `skool2bin.py`, and says so.

---

## Credits

Game © 1987 The Edge / Softek. This repository holds no copy of the game beyond the user's own snapshot and is for preservation and study.
