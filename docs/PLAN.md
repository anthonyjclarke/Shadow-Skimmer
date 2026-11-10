# Plan – Shadow Skimmer disassembly

The Manager's plan and dig-task queue (`references/roles/manager.md`). It has one current state: update it in place and never append history.

---

## Phase and coverage

| Item                | State                                     |
|:--------------------|:------------------------------------------|
| Phase               | 5 – behaviour spec                        |
| Gate                | `CHECKS PASS` (SkoolKit 10.1, gate 14)    |
| Baseline findings   | 9                                         |
| Routines to the bar | 118 of 121 (3 flagged only for a bare well-named JP or CALL) |
| Data documented     | screen text, variables, workspace `$C909` |
| Glossary            | registry (11 words) and naming policy     |
| Catalogs            | graphics, screens, sound                  |
| Behaviour spec      | 15 pages under `spec/`, published on the site |
| Relocatability      | label-clean; unproven                     |

---

## In flight

| Target              | Lane | State                                |
|:--------------------|:-----|:-------------------------------------|
| Site pass (theme, page widths, inline audio, reader pass) | site | review |

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

### Game behaviour

| Address       | Open question                                 |
|:--------------|:----------------------------------------------|

### Names

| Subject        | Open question                                 |
|:---------------|:----------------------------------------------|
| `$95D0`        | Game name for the animated 3×3 graphic        |

### Skill (upstream)

All 18 items are fixed on branch `shadskim-fixes` of the local skill clone (25 commits on `70b3589`), vendored here, and offered upstream as a PR. Until morozov/zx-spectrum-skills takes them, a fresh clone's `vendor-check` fails against the unmodified upstream skill.

| Subject           | Open question                                    |
|:------------------|:-------------------------------------------------|
| PR                | Open the PR to morozov/zx-spectrum-skills (owner approval) |

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
| `$CD9C`  | Pointer tables typed `W` with image labels         |
| `$9A88`  | 13 hostile designs labelled and rendered with masks |
| `$9DC8`  | 8 shot graphics rendered in their traced colours   |
| `$8B00`  | Three hull surface patterns labelled and rendered  |
| `$A018`  | `explosion_offsets`, with `@ssub` at `$C503`       |
| `$A020`  | One font entry with a character table              |
| `$B16F`  | Targets labelled `colour_pat_33/34`                |
| `$95B0`  | Unused bytes past the third device design          |
| `$C4DB`  | Table addresses from immediates now `@ssub`        |
| `$6200`  | 38 and 43 never read; 117/120 overlap; 119 ROM 0×0 |
| `$7CD4`  | Graphic 109 one sub-block; entry starts at `$645C`  |
| `$A818`  | Confirmed; schema linked to `$6200`                 |
| mark bit 5 | Cell mask 7, used by graphics 44 and 47 only      |
| `$D473`  | Split: drains, readout digits, step count, points due, doublings |
| `$D48D`  | `shield_loss_due`                                   |
| `$D800`  | Pointer tables and one labelled list per screen     |
| `$E141`  | Bug: the stray run flag leaves the shadow switch set, so screen 55's last graphic casts no shadow |
| `$B5F6`  | No: shading twice changes nothing (24 screens simulated) |
| layouts  | Every screen and the hull map rendered by the game's own code |
| `#AUDIO`  | Sound page: every effect and the whole tune, from the game's own code |
| glossary | "slide" and "noise run" defined (DEF-6)             |
| hostile object | Name rulings in the Write/Not registry; frame, structure, hatch, cover, picture kept out (NAME-2) |
| `$99A0`  | Opening steps run by the game's code, on the Graphics page |
| decoder  | Graphic 24 and 104–109 rendered from screens 64, 0, 10 at `$645C` |
| graphic 35 | No code-backed name: drawn as plain 1×1 graphics   |
| screens  | Render is right: `start_game` zeroes the device flags |
| inline audio | `$F30A–$F45E` in the tune snapshot; part clips at `$F021`, `$F030` |
| `$F493`  | Stack reaches no lower than `$F7BC` (60 bytes); `$F493–$F7BB` unused |
| lint-prose | Vale 3.26 installed; warnings fixed, the rest are extractor false positives |
| whole image | FuseX runs reach sectors 2–3 and WALL DONE; no listing claim contradicted |
| `$F30A`  | Both tune parts render here (SYNTH_ECHO narrowed in the skill) |
| gate     | Other `.ctl` files (`src/tune.ctl`) run through 12 lint checks |
| `$BE3F`  | Unreachable: C is always 3, so the push is down and no shot launches (`$C8FE`) |
| `$C8C4`  | BUG note: a hostile shot fired right stops at column 30 |
| `$D08A`  | A pass crossing two edges leaves by the side one, or by neither when that side edge is the map's |
| `$C826`  | BUG note extended: the stray mark stays until the next draw (`$C802`) |
| `$CEDB`  | The shield loss restarts from its first stage, not cancelled |
| `$C1B1`  | A blocked launch runs the full collision |
| `$C0AC`  | Nothing reads the overwritten system variables |
| `$C43E`  | The white paint shows the hull surface in the black strip |
| `$C845`  | The old pace lasts until the next square cell on that axis |
| `$B7B7`  | Bit 7 only from the steering distances; no play area cell holds it |
| `$FF70`  | `$FF` is the map's page byte, shared by the background store |
| `$B889`  | Code prints at row 3, column 5; leaflet says far right (spec says both) |
| `$C955`  | The device's 23 is never read (`$B72D`)              |
| `$F11E`  | Wait states stated once at `$F009`; `$F154` behaviour noted |
| `$B363`  | No visible effect: the run's own shadow covers the cells where they differ |
| `$B37B`  | Phrased as a condition                               |
| `$9810`  | Grouping stated as the renders' choice (EVID-9)      |
| `$C946`, `$B3B0`, `$B3F0`, `$CF9E`, `$BB6D`, `$6200`, glyph 10, graphics | Answered; no text (covered already, or HOME-3) |
| final goal | The entry-way is an ordinary hatchway; inner screen 5 ends the game |
| `$BAC6`  | Nothing found reads or writes `$F7F8–$F7FF`; the stack starts below them |
| `$B20A`  | Plotters and shadow casters are their own entries   |
| `$B04F`  | `$B04F`, `$BE1E`, `$BE4D` split, with `R` rows       |
| `$CBF3`  | Draw loop, `$CC57`, `$CD89`, `$CE26`, `$C204` split  |
| `$C963`  | `$C97B–$C9D9` merged into `move_skimmer_left`        |
| `$CDC8`  | No split: `$CBC2` indexes from it (ENT-2, UNU-1)     |
| `$F473`  | Unused, `copy_new_keys`, stack, slots with schema    |
| `$BD13`  | `$BD13`, `$BD21` are words; `@ssub` at the readers   |
| `$D2E7`  | Font labelled `font`, operands as expressions        |
| wording  | `$B6F8`, `$D219`, `$C500`; "horizontal offset" (`$C28D`) |
| `$B850`   | Clears rows 1–4 (`LD HL,$4021`, `LD BC,$201E`)      |
| `g` pages | Headed "Variables" via `[PageHeaders]`/`[Titles]` |
| Screens page | Two screens across: fits 800 px            |
| inline audio | Clips at `$BE1E`, `$C44B`, `$F000`, `$F009` body |
| `tune` links | `tune-CodePath=tune/asm`: code face from other pages |
| `$D2CE`  | Clicks follow either side's shot; comments say "a shot" |
| `$CC3C`  | The dummy read keeps the click rate independent of cover |
| `$D2B5`  | No: the snapshot's `$01` never reaches the port     |
| `$D10D`  | Clicks sound only on hatch-step passes during the animation |
| `$C453`  | The double count delays a launch in that pair only  |
| hatch timing | 101 passes for a trip's 26 steps; home in `game-flow.md` |
