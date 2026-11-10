# Plan – Shadow Skimmer disassembly

The Manager's plan and dig-task queue (`references/roles/manager.md`). It has one current state: update it in place and never append history.

---

## Phase and coverage

| Item                | State                                     |
|:--------------------|:------------------------------------------|
| Phase               | 3 – depth pass, code and tune player      |
| Gate                | `CHECKS PASS` (SkoolKit 10.1, gate 14)    |
| Baseline findings   | 40                                        |
| Routines to the bar | 118 of 121 (3 flagged only for a bare well-named JP or CALL) |
| Data documented     | screen text, variables, workspace `$C909` |
| Glossary            | registry (11 words) and naming policy     |
| Catalogs            | graphics, sound, data: not started        |
| Behaviour spec      | not started                               |
| Relocatability      | label-clean; unproven                     |

---

## In flight

| Target              | Lane | State                                |
|:--------------------|:-----|:-------------------------------------|
| Title tune player `$F009` (`src/tune.ctl`) | code | review |

---

## Naming pass (phase 2)

| Slice | Range                         | State      |
|:------|:------------------------------|:-----------|
| S1    | `$61FD`, `$B000–$B426`        | integrated |
| S2    | `$B427–$B89E`                 | integrated |
| S3    | `$BA3C–$BD0E`                 | integrated |
| S4    | `$BD44–$C226`                 | integrated |
| S5    | `$C227–$C657`                 | integrated |
| S6    | `$C658–$C962`                 | integrated |
| S7    | `$C963–$CBA7`                 | integrated |
| S8    | `$CBA8–$CE90`                 | integrated |
| S9    | `$CE91–$D472`, `$F000–$F472`  | integrated |
| V     | variables `$BD0F–$BD43`       | integrated |

---

## Name rulings

| Concept                  | Project word         | Not                      |
|:-------------------------|:---------------------|:-------------------------|
| moving opponents         | hostile object       | drone, enemy, robot      |
| rows 6–23 of the screen  | play area            | playfield                |
| a character cell         | cell                 | square                   |
| the player's shot        | pulse laser shot     | pulse-laser shot         |
| a shifted copy           | image                | picture, sprite          |
| `$FA00` workspace        | attribute mirror     | cell map                 |
| saved screen bytes       | background store     | backdrop                 |
| what stops a move        | blocked              | structure (for any block) |
| the 50 Hz tick           | interrupt            | frame (frame = animation) |
| `$D2B8` pointer          | attribute mirror address | colour cell          |
| the 5×5 place to open    | hatchway             | hatch (for the whole) |
| its 3×3 centre that opens | hatch               | cover                |

---

## Dig-tasks

### Code and data

| Address       | Open question                                 |
|:--------------|:----------------------------------------------|
| `$F480`       | Split the key copy out of `b $F473` as code (moves `$F473` baseline keys) |
| `$A020`       | One font entry (39 glyphs) and a render; `@ssub` at `$BB89` |
| `$B16F`       | Label the panel patterns `$A758`/`$A7B8` in `$A2B8` |
| `$C4DB`       | Table addresses built from immediates: `$BF58`, `$C1F5` (needs `$9A88`), `$C503` (needs `$A018`) |
| `$CD9C`       | Label images in `$7CD4`, then type `$CD9C–$CDE7` as `W` |
| `$6200`       | Document the graphic directory record (also `$A818`, needs a split) |
| `$B20A`       | Split plot_graphic, plot_unmasked, cast_shadow, draw_shadow into entries |
| `$D800`       | Split the layout tables and lists; record `#TABLE` |
| `$9520`       | Title the defence device designs (`$7CD4` split) |
| `$D2E7`       | Label the font; its address is built from immediates |
| `$D473`       | Split the readout block; state the digit format and drain amounts there |
| `$CE26`       | Split `flag_interrupt` into its own entry     |
| `$9A88`       | Label and render the 13 hostile object designs |
| `$95B0`       | 32 zero bytes after the device designs        |
| `$99A0`       | Title the hatch bitmap (`$7CD4` split)        |

### Game behaviour

| Address       | Open question                                 |
|:--------------|:----------------------------------------------|
| whole image   | Sectors 2–3 and game end coverage (FuseX)     |
| `$C946`       | Limit per slot pair allows twice the launch cells: intended? |
| `$B889`       | Shield count at row 3 col 5, not far right as the leaflet says |
| `$B5F6`       | Column-0 vertical runs shade twice: visible?  |
| `$B7B7`       | Bit 7: only the steering distances' sign bits? |
| `$B3B0`       | A zero-length bar loops 256 times: document?  |
| `$B3F0`       | Why do the two bars' shadow offsets differ?   |
| `$C802`       | Does `$C0D4`'s reset to `$08` pair the explosion toggles? |
| mark bit 5    | Which graphics use cell mask 7?               |
| `$FF70`       | Cover map `$FF` is the map's page byte (relocation) |
| `$D48D`       | Label `shield_loss_due` (split `$D473`)       |
| `$F840`       | Label the hostile slots' state bytes (split `$F473`) |
| `$D219`       | Note the movement flag +1 in the `D`          |
| `$D2B5`       | Snapshot `$01` sets a blue border on the first click? |
| `$C845`       | Push sets speed ±3 without new rates: visible? |
| `$CF9E`       | Dead `LD A,n` loads before calls: note them?  |
| `$C204`       | Split `add_hostile` into its own entry        |
| `$F473`       | Split the hostile slots and table their schema |
| `$A018`       | Label the explosion frame offsets (split)     |
| `$C43E`       | Explosion's white paint over coloured graphics? |
| `$C1B1`       | Blocked launch on the Skimmer pushes it: visible? |
| `$C0AC`       | Image buffers overwrite sysvars: any ROM call reads them? |
| `$C8C4`       | Hostile shot's right range stops at column 30: defect? |
| `$C453`       | Double count of an exploding object: matters at `$C11B`? |
| `$B6F8`       | Row says `add_hostile` draws; it does not     |
| `$D08A`       | An exit on both axes leaves sideways: say so? |
| `$C963`       | Merge `$C97B`–`$C9B7` into `move_skimmer_left`? |
| `$CD89`       | Split into its own entry for `R` rows         |
| `$CBF3`       | Split the shared draw loop for its contract   |
| `$CC57`       | Split for `R` rows                            |
| `$CC3C`       | Does the click rate depend on the dummy read? |
| site theme    | `#UDGTABLE` cells have no padding: captions touch (`$CD9C`, `$9520`) |
| `$C28D`       | "pixel offset" → "horizontal offset" in the hostile entries |
| `$CDC8`       | Split the unused first frame into its own `u` block? |
| `$BE3F`       | Is the range `$FF` write reachable? Only via `$C8FE` (C AND 3 = 2) |
| `$C8FE`       | Can C AND 3 be 2 after `update_hostile`? Shot with range 255 |
| `$9DC8`       | Label and render the eight shot graphics (`$7CD4` split) |
| `$8B00`       | Label and render the three hull patterns (`$7CD4` split) |
| `$B04F`       | Split `$B04F`, `$BE1E`, `$BE4D` into entries for `R` rows |
| `$BD13`       | Merge `$BD13/$BD14`, `$BD21/$BD22` into words (`@ssub` at `$B5BD`, `$B60D`, `$B4C5`) |
| `$BAC6`       | What is at `$F7F8–$F7FF`, above the stack's start? |
| `$BB6D`       | Does any message wrap past column 31 within a third? |
| `$F154`       | Crosswise counter reloads in the three-tone player: quirk? |
| `$F11E`       | Tone formulas assume no contended port wait states |
| `$F30A`       | Render both tune parts here (blocked by SYNTH_ECHO on the schema); link `#R$F1BF@tune` |
| `#AUDIO`      | Render the intro slides, the bridge, the noise run and the in-game clicks |
| glossary      | Add "slide" and "noise run" (DEF-6)           |
| gate          | The gate's linters skip `src/tune.ctl`; wire them in |
| `tune`        | Raw operands in the tune listing (`operand_subs` reads only the main skool) |
| `tune`        | Tune links use the prose face; try `tune-CodePath=tune/asm` |
| lint-prose    | Vale is not installed, so the prose lint never runs |
| `$E141`       | Screen 55's last record runs into the next layout |
| `$C955`       | Counter value `$17` for the defence device    |
| `$B363`       | Shadow edge tests use the layout cell, not the drawn one |
| `$B37B`       | Full top shadow cell on row 6: why?           |

### Names

| Subject        | Open question                                 |
|:---------------|:----------------------------------------------|
| hostile object | Register the name rulings in the glossary     |
| `$95D0`        | Game name for the animated 3×3 graphic        |
| final goal     | Is the mothership entry-way its own entity?   |

### Skill (upstream)

| Subject           | Open question                                    |
|:------------------|:-------------------------------------------------|
| `CHECK_terms`     | Passes no `--registry`                           |
| `verify-frag`     | Renders `game.skool`; baseline keys `shadskim`   |
| `diff_entries.py` | Skips untracked files                            |
| `rules.md`        | No DEF-6/VIS-11 exemption for the glossary boxes |
| SYNTH_ECHO        | Fires on a data entry's field schema beside a clip (`$F30A`) |
| `coverage`        | Counts a bare well-named JP or CALL (ENT-7) as skeletal (`$61FD`, `$B000`, `$CD86`) |
| label-namespace   | Roots miss the game loop                         |

### Closed

| Address  | Answer                                              |
|:---------|:----------------------------------------------------|
| `$BA3C`  | Redefined FIRE and FLIP are copied by `$F480`       |
| `$BD3E`  | Inside-the-hull flag                                |
| `$BD3F`  | Sector number, 1–3                                  |
| `$BAC6`  | `$5E` means the game ended by `$BD3D`, no GAME OVER |
| `$C0AC`  | `$C227` fills the image buffers                     |
| `$C845`  | Push follows the hostile object: 0 up … 3 right     |
| `$C94E`  | State `$17` is the defence device                   |
| `$C936`  | The hostile objects' shot                           |
| `$B0BE`  | Split into mask and colour-pattern tables           |
| `$B7DA`  | Bar cells split off                                 |
| `$C909`  | Workspace split into one entry per thing            |
| `$C4CB`  | Image offsets typed `W` with schema                 |
| `$BD28`  | Launch direction is bits 5–6 of the column byte     |
| `$C935`  | Only bytes 0–12 of a shot record are used           |
| `$CFC6`  | Yes, on the last shield; GAME OVER still prints     |
| `$F009`  | Title tune player (decrypted; only caller `$BAEB`)  |
| `$CE86`  | Screen number = `$CE86`[row] + column               |
| `$D2A6`  | Speed rates split from the play loop variables      |
| `$CE4B`  | Play area rows 6–23, black left strip               |
| `$B096`  | Bug, latent: columns ≥ 32 all map to column 32      |
| `$B27D`  | Yes: unmasked mask bytes come from mirror rows 0–5  |
| `$B11B`  | Mask 7's 20 bytes are equal, so both shapes work    |
| `$B5BD`  | Reloads `draw_attr` into D; E is unused            |
| `$B766`  | No reader: an uncalled routine and four patterns   |
| `$B51C`  | Inner screen 5 ends the game; WALL DONE for ~9 s   |
| `$BD19`  | The lowest layout row is 23                        |
| `$BD18`  | Flags 3 or 7; bit 2 starts a run; timer limit 5    |
| `$B681`  | Yes; no layout has more than 3 launch graphics     |
| `$B04F`  | A NOP patch draws the 16×16 device on the panel    |
| `$B640`  | Each special graphic has its own test at `$B640`   |
| `$EA00`  | Indexed by the same screen number as `$D800`       |
| `$C926`  | No: at most one animated graphic per screen        |
| `$D800`  | 3-byte records, `$FF` ends; runs reach the next cell |
| `$B789`  | Unreachable: `$FF` ends the list first             |
| `$B5F0`  | Bug, latent: no outer-hull run ends on a join graphic |
| `$B3B0`  | Yes: the bar runs from the previous layout graphic |
| `$B432`  | `$99A0` is the 24×24 hatch bitmap; patterns `$99E8` |
| `$B449`  | Yes: ROM byte `$0400` + screen number picks them    |
| `$B4A7`  | Yes: frame 0, in the layout's attribute            |
| `$B427`  | Fields tabled at `$B427`                            |
| `$B4A3`  | Yes, but it repaints the same colour               |
| `$B7B7`  | Marks with bit 0, 1 or 7 block a shadow            |
| hatchway | Two things: the hatchway, and the hatch at its centre |
| `$FA00`  | `attr_mirror` `@equ`; marks tabled on the Workspace page |
| `$FA00–$FFFF` | `@equ` names: `int_jump`, `int_vectors`, `skimmer_bg_store`, `skimmer_cover_map` |
| `$FF10`  | `skimmer_bg_store`, also the hatch's draw buffer   |
| `$95D0`  | Labelled `animated_frames`                          |
| `$B26D`  | Expression `@ssub` on the table labels              |
| `$FF70`  | The flip check scans the cover map's top-left 3×3   |
| `$CCD3`  | The flipped Skimmer ignores bit 5 (cell mask 7)     |
| `$B0CC`  | Mark 1 stops hostile objects and shots; 2 and `$22` do not |
| `$D343`  | Drains the indicator and counts in the score       |
| `$D47F`  | Drain 1/8 unit per call, 25/8 during a push        |
| `$D48A`  | Points due in eighths; a hit adds 20 to the score  |
| `$D2C4`  | Speed-rate byte 0 is the step in pixels            |
| `$D2C0`  | X step halved into 2-pixel image offsets           |
| `$CDEC`  | `int_jump/$100` `@ssub`                             |
| `$CDE8`  | Inline bytes are `flag_interrupt`'s address        |
| `$D2AF`  | Every play loop variable defined                   |
| `$D2B5`  | Its speaker bit flips only at the two click sites  |
| `$D2CE`  | Yes: the pulse laser shot's clicks                 |
| `$D2CD`  | `$C47D`/`$C48A` set and restore the click threshold |
| `$D2CB`  | Pushes of 20 or 35 from four collision sites       |
| `$D2CF`  | `$D2CF` and `$D2BA` typed `W`                       |
| `$BD44`  | Fires only half a cell off the grid on that axis   |
| `$CE86`  | `@ssub` on `row_first_screen`                       |
| `$C2DB`  | Yes: a shot marks the cell, the next update explodes it |
| `$C18B`  | No: the first steer comes on the fifth whole cell  |
| `$C186`  | `@ssub` on `launch_cells`; `$C1D0` likewise        |
| `$C2DA`  | Unused byte, typed `u`                             |
| `$C494`  | Skipped cells are the ones that hide the object    |
| `$C46B`  | Yes: only the device exists inside, so its flag    |
| `$BD40`  | `$FF` means destroyed; the device is alone inside  |
| `$B6F8`  | `update_hostile` redraws the device after the hold |
| `$D2CC`  | Yes: blocked kept objects vanish during the hold   |
| `$C802`  | Toggles pair: `$08` moves, `$18`/`$10` explosions  |
| `$C76A`  | The hostile object's cover map, not ink            |
| `$C819`  | Shot or hit cell: 20 points; Skimmer cell: a push  |
| `$C880`  | Yes, at right angles; the device never fires       |
| `$C955`  | Cells left before the next steer                   |
| `$C949`  | Pixel offset 0–3 in 2-pixel steps                  |
| `$C94E`  | States tabled at `$C947`                           |
| `$C957`  | 1 if the object stepped                            |
| `$CC32`  | The NOP rewinds the cover map 3 cells per row, not 4 |
| `$C2E0`  | No: every exploding object vanishes in the hold    |
| `$CB8E`  | Unused delay loop; nothing refers to it            |
| `$CBC6`  | Bug: `DEC C` skips the first shield-loss frame     |
| `$CCB0`  | `CP H` tests the cover map; store and map share page `$FF` |
| `$CD3A`  | Yes: the fourth column at a cell edge; `AND $0B` is the cover test |
| `$CD36`  | Kept as its own entry, `cover_map_hide`            |
| `$CD86`  | Set on a new screen, then toggled old and new each draw |
| `$CC9B`  | No: step sizes change only at `$D219` from aligned positions |
| `$61A8`  | Unused relocation code; nothing jumps into it      |
| `$BF8B`  | `$21` comes after the hatch closes over the Skimmer; then the inner section |
| `$BF6A`  | 24 rows × 3 bytes; halves rows 0–12 and 11–23      |
| `$BEE0`  | A Skimmer cell with no hostile mark; push follows the shot for 20 passes |
| `$BEEF`  | Says "adds 20 points"                               |
| `$B4FB`  | No: `$B02A` restores `$B058` before every band      |
| `$BEE0`  | Z only on an upward push with D 0; the hostile shot then launches from `$D2C3` (see `$BE3F`) |
| `$BAA7`  | Unused copy of part of the key copy at `$F480`     |
| `$BC68`  | Unused pattern draw steps; nothing copies them     |
| `$BA3B`  | Folded into `t $BA06`                              |
| `$BA45`  | Dead store: the control name sets it first         |
| `$BA06`  | Titled "WALL DONE message"                         |
| `$B850`  | The panel draw then overwrites rows 0–5            |
| `$F30A`  | Title tune notes: 3-byte records, two parts        |
| `$BC1F`  | Three 8-byte sets: flip, fire, up, down, left, right |
| `$B812`  | No: every cell it tests holds mark 1               |
| `$BBA2`  | `R` row O:A gives the control bits                 |
| `$F009`  | Decrypted listing published as `tune` (`src/tune.ctl`, `tools/tune_player.py`) |
| `$F1BF`  | `#AUDIO` render from the game's own code (simulator) |
