# Changelog

## [0.2.0] 08-11-2026

### Added

- Screen text documented (`$B89F–$BA3A`): title, redefine-keys, key names, control names, menu keys, game over and wall done, with labels, the message line format and the text colours.
- Documented a defect in the game: the redefine-keys screen names the F key "E".
- `docs/PLAN.md`: the Manager's plan and dig-task queue.
- `src/glossary.ref`: the naming policy and a registry of the game's own words, linked from the site's index.
- Routines and data from `$61FD` and `$B000–$CBA7` named: labels, titles and tentative one-line purposes.
- Game variables (`$BD11–$BD43`) labelled and defined, and the workspace at `$C909` split into the animation list, the shot records and the current hostile object.
- Graphic cell masks and colour patterns split into their own tables, with the pointer tables typed as words.

## [0.1.0] 08-11-2026

### Added

- SkoolKit project on the `zx-game-disasm` skill: `Makefile`, `skoolkit.ini` and the vendored site build.
- `src/shadskim.ctl`: code/data map of the code block `$61A8–$F9FF`. It has 120 code entries backed by execution traces and resolves every operand reference (zero `skool2asm -s` warnings).
- `src/environment.ctl` and `src/shadskim.z80header`: the rest of the snapshot as source.
- `gmake restore`: rebuilds `SHADSKIM.Z80` byte for byte and `cmp`s it with the original.
- `tools/z80snap.py`, `tools/coverage_trace.py`, `tools/extend_map.py`, `tools/build_fuse.sh`, `tools/bootstrap.sh`.
- VS Code tasks, settings and extension recommendations.
- Fuse for macOS built from source (`arm64` branch); `gmake fuse` opens the rebuilt snapshot.
- `README.md`, `docs/DISASSEMBLY.md`, `CLAUDE.md`.
- pasmo 0.5.5 in `.venv/bin`; `gmake restore` assembles the `.asm` with it.
- `src/shadskim.ref`, `resources/shadskim.css`: the HTML site's config and identity sheet.
- `tools/lint-baseline.toml`: every gating check adopted; `gmake gate` is `CHECKS PASS`.
- Git repository on `main` (nothing committed).
