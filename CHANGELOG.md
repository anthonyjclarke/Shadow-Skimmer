# Changelog

## [0.3.0] 09-11-2026

### Added

- Graphics engine documented in depth (`$B080–$B3AF`): cell addresses, the graphic directory fields, cell masks, colour patterns, the pixel, colour, mark and shadow passes, with every basic block commented.
- The Skimmer documented in depth (`$C963–$CDE7`): its four moves and screen exits, the shared draw with its cover map and timing-matched skip, background saves and restores, blocking checks and pushes, and the image, flip and shield-loss frame tables with renders.
- Documented another defect in the game: the shield-loss animation never shows its first frame (`$CBC6`).
- Hostile objects documented in depth (`$C09B–$C962`): the four slots, launches, the 13 designs and their shifted images, steering, the four moves, cover maps, collisions, pushes, firing, explosions, and every field of the hostile object workspace.
- Documented two more defects in the game: a hit cell's mark clear also clears the struck object's own mark, and a hostile shot that starts on the Skimmer pushes it in an unset direction.
- The game loop `play_game` documented in depth (`$CE91–$D218`), with every play loop variable defined: controls, speeds and step rates, screen exits, hatchway steps, pushes, flips and the shot clicks.
- Interrupts, shields, readouts and score documented in depth (`$CDE8–$CE90`, `$D219–$D2AE`, `$D2D6–$D472`): the IM 2 set-up, the Skimmer's speed rates and flip, shield loss, the rolling readout digits, the Damage Report Indicator drain and the score count.
- Workspace page (`src/workspace.ref`): the attribute mirror and its mark bits, the IM 2 table, the Skimmer's background store and cover map, with `@equ` names for every workspace operand.
- Labels for the defence device designs, the animated graphic frames, the hatch bitmap and patterns, the hostile object slots and `add_hostile`; the cell mask, colour pattern, hatch bitmap and hatch pattern addresses built from immediates now assemble from their labels.
- Bars, hatchways, animated graphics and cell shading documented in depth (`$B3B0–$B4D8`, `$B789–$B811`), with the animated graphic template's fields and the bar cell renders.
- Screen layout interpreter documented in depth (`$B4D9–$B788`): the layout record format, runs, special graphics, launch cells, the WALL DONE screen and the defence device set-up.
- Documented two more defects in the game: launch cells store their direction where the reader takes another bit, and a run records the last graphic's size, not its own cell, as the previous graphic's cell.
- Documented a latent defect in the game: `$B096` maps every column past the right edge to column 32.

## [0.2.0] 08-11-2026

### Added

- Screen text documented (`$B89F–$BA3A`): title, redefine-keys, key names, control names, menu keys, game over and wall done, with labels, the message line format and the text colours.
- Documented a defect in the game: the redefine-keys screen names the F key "E".
- `docs/PLAN.md`: the Manager's plan and dig-task queue.
- `docs/RESEARCH.md`: the Researcher's leads and the proposed order of the deep documentation.
- `src/glossary.ref`: the naming policy and a registry of the game's own words, linked from the site's index.
- Routines and data from `$61FD` and `$B000–$CBA7` named: labels, titles and tentative one-line purposes.
- Game variables (`$BD11–$BD43`) labelled and defined, and the workspace at `$C909` split into the animation list, the shot records and the current hostile object.
- Graphic cell masks and colour patterns split into their own tables, with the pointer tables typed as words.
- Routines from `$CBA8` to `$D472` named (the Skimmer's drawing and collision checks, the interrupt set-up, the game loop, shields, the Damage Report Indicator and the score), and the title tune player's wrapper and decrypter at `$F000`–`$F472`.
- Skimmer image and frame tables and the play loop variables split into their own entries, with the Skimmer speed rates on their own.

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
