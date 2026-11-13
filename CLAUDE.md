# CLAUDE.md – Shadow Skimmer disassembly

Target: ZX Spectrum 48K game *Shadow Skimmer* (The Edge, 1987), from the snapshot `SHADSKIM.Z80`, which is not tracked: each user supplies it, and the Makefile checks its SHA-256. Not an ESP32 project: no `platformio.ini`, `config.h` or `debug.h` rules apply. This is a SkoolKit disassembly built on the `zx-game-disasm` skill in `external/zx-spectrum-skills/` (clone of morozov/zx-spectrum-skills). Version 0.4.2: every routine documented, graphics, screens, sound and a behaviour spec published, byte-for-byte restore green.

## Rules

- Read `external/zx-spectrum-skills/zx-game-disasm/references/rules.md` before editing any `.ctl`; it is the normative rulebook.
- Hand-edit only `src/*.ctl`, `src/*.ref`, `src/shadskim.z80header`. Never edit `build/` (generated) or `vendor/zx-game-disasm/` (a `make vendor` copy; `vendor-check` fails if it drifts).
- Every change must keep `gmake restore` printing `RESTORE OK`. That proves the whole `.z80` file is rebuilt identically, header and RLE included.
- Use `gmake` (GNU make 4.4 from Homebrew); `/usr/bin/make` is 3.81 and cannot run the skill's framework.
- Tools run from `.venv/bin` (SkoolKit 10.1); the Makefile prepends it to `PATH`.
- `.ctl` addresses are hex, always.

## Gotchas

- `$F009–$F309` is XOR-encrypted in the snapshot (key `$41`, +1 per byte, applied by `$F45F`). Keep it a `b` block. Never promote it to code from trace hits.
- SMC: operands at `$B859`, `$B87A`, `$C80D`, `$CC0A` are patched at runtime and are written as `label+1` via `@ssub`. `$B058` has its whole opcode rewritten.
- `skool2bin.py` lays an entry after an `i` block straight after the previous one. That is why `environment.ctl` is disassembled as two ranges (`-e 0x61A8`, `-s 0xFA00`).
- The skill's `$(Z80)` rule wants a tape (`.t2s`). The Makefile overrides it to copy `SHADSKIM.Z80`; the "overriding recipe" warning is expected.
- pasmo lives in `.venv/bin` (built by `tools/bootstrap.sh`). Without it the framework preflight fails every goal except `restore`, `fuse` and `coverage`.
- `skool2bin.py` flags are `-S`/`-E` (capital), not `-s`/`-e`.
- `external/zx-spectrum-skills` tracks upstream `main`; our skill fixes were merged there (PR #1, `95b22d5`). If upstream changes `site/`, run `gmake vendor`, then run `gmake lint-baseline` if the gate digest moves.
- `$FA00+` is runtime workspace outside the image (IM 2 vector at `$FDFD`/`$FE00`), so it needs `@equ` constants, not labels.

## Fuse

`tools/build_fuse.sh` builds the arm64 branch. It needs `MACOSX_DEPLOYMENT_TARGET=12.0`, since Xcode 27 rejects 11.5, and Homebrew ruby + jekyll for the help book. The output is `external/fuse-for-macos/fuse/fusepb/build/Deployment/Fuse.app`. The skill's `zx-fuse-driver` needs FuseX, a different emulator: `tools/build_fusex.sh` builds its library into `external/fusex/` (set `FUSEX_LIB`/`FUSEX_ROMS`); the full `FuseX.app` also needs Apple's Metal Toolchain.
