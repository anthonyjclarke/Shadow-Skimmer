# Changelog

## [0.3.0] 09-11-2026

### Added

- Sound clips inline at the code that makes each sound: the shot (`$BE1E`), the explosion (`$C44B`), the title tune (`$F000`) and the introduction, bridge and noise run in the tune listing.
- Graphics engine documented in depth (`$B080–$B3AF`): cell addresses, the graphic directory fields, cell masks, colour patterns, the pixel, colour, mark and shadow passes, with every basic block commented.
- Behaviour specification (`spec/*.md`, published on the site by `tools/spec_pages.py`, kept in this repo by owner ruling until the skill takes a generic converter): architecture, game flow, the hull, graphics, the control panel, the Skimmer, controls, hostile objects, shots, collisions, the economy, the score, effects and sound, and the state, actions, dynamics and rewards for an agent.
- Sound page (`src/sound.ref`): the title tune whole and in its parts, the shot's clicks and the explosion, each captured by running the game's own code in SkoolKit's simulator.
- Documented a defect in the game's data: screen 55's last layout record carries a stray run flag, so that graphic casts no shadow.
- Screens page (`src/screens.ref`, `src/screens.py`): every outer hull screen, every inner section screen and the whole 10 × 11 hull map, each drawn by the game's own screen code in SkoolKit's simulator; the layout tables split into one labelled list per screen with the record format, and the readout variables at `$D473` split and defined.
- The outer hull's graphic directory (`$6200`) and all 151 outer hull graphics, each labelled and rendered, with the directory's odd records explained; the inner directory linked to the same schema.
- Graphics gallery (`src/graphics.ref`) and the sprite block `$7CD4–$A817` split into labelled, rendered entries: the Skimmer's images, flip and shield-loss frames (animated), hull surfaces, defence devices, the animated graphic, the hatch, the 13 hostile object designs, the shots, the explosion (animated), the font and the control panel in its own colours.
- The title tune player, decrypted by `tools/tune_player.py` and published as its own listing (`src/tune.ctl`, `src/tune.ref`): the introduction's slides, the two-tone and three-tone players with their timing and pitch formulas, the noise run and the key-press exit. The tune listing plays the start of the first part as an `#AUDIO` clip, captured by running the game's own player in SkoolKit's simulator.
- Control panel, menus, keys, the main loop, printing and the title tune wrapper documented in depth (`$B812–$BD43`, `$F000–$F472`), with every game variable defined and the title tune's note data identified. Every routine outside the encrypted title tune player is now documented.
- Start-up, firing and hatchways documented in depth (`$61A8–$B07F`, `$BD44–$C09A`): the entry, screen clear and hull surface, the fire key, both shots' launch, flight, colours and marks, hits and pushes, and the hatchway animation's halves and phases.
- Documented two more defects in the game: a failed shot launch writes `$FF` to the range byte instead of the direction (`$BE3F`), and a push at a shot's first cell can report the cell as free (`$BEED`).
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

### Changed

- Entry structure: the graphic plotters, shadow casters, shot routines, Skimmer draw loops, `flag_interrupt` and `add_hostile` are their own entries with register rows; `move_skimmer_left` is one entry; `$F473` is split into unused bytes, `copy_new_keys`, the stack and the hostile object slots with their layout; `$BD13` and `$BD21` are words; `hostile_pixel_offset` is now `hostile_x_shift`.
- Site pass: the Screens page shows two screens across and fits an 800 px window; `g` pages are headed "Variables"; links into the tune listing use the code face.

### Fixed

- `$B850` blanks rows 1–4 of the screen, not rows 0–3.

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
