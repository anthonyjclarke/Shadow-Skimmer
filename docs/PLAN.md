# Plan – Shadow Skimmer disassembly

The Manager's plan and dig-task queue (`references/roles/manager.md`). It has one current state: update it in place and never append history.

---

## Phase and coverage

| Item                | State                                     |
|:--------------------|:------------------------------------------|
| Phase               | 3 – depth pass, S Skimmer                 |
| Gate                | `CHECKS PASS` (SkoolKit 10.1, gate 14)    |
| Baseline findings   | 46                                        |
| Routines to the bar | 85 of 121 (`$B080–$B811`, `$C09B–$D472` but `$CD86`) |
| Data documented     | screen text, variables, workspace `$C909` |
| Glossary            | registry (11 words) and naming policy     |
| Catalogs            | graphics, sound, data: not started        |
| Behaviour spec      | not started                               |
| Relocatability      | label-clean; unproven                     |

---

## In flight

| Target              | Lane | State                                |
|:--------------------|:-----|:-------------------------------------|
| Depth G2a `$B3B0–$B4D8`, `$B789–$B811` | code | spliced; review |

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
| `$61A8`       | What is the code-like stub below the entry?   |
| `$F009`       | Decrypted listing of the title tune player (see `docs/RESEARCH.md`) |
| `$F30A–$F45E` | Code or data? No play trace executes it       |
| `$F480`       | Document the key copy that `$BA3C` jumps to   |
| `$A020`       | Map and render the font; `$A150` is the "/"   |
| `$B16F`       | Label the control panel patterns in `$A2B8`   |
| `$BAA7`       | Code with no caller: unused?                  |
| `$BC68`       | Draw-mode code templates: what copies them?   |
| `$C4DB`       | Table addresses built from immediates: `$BBE5`, `$BF58`, `$C1F5` (needs `$9A88`), `$C503` (needs `$A018`) |
| `$CD9C`       | Label images in `$7CD4`, then type `$CD9C–$CDE7` as `W` |
| `$BA3B`       | Fold WALL DONE's end `$00` into `t $BA06`     |
| `$BA45`       | Dead store to the text attribute              |
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
| `$BA06`       | Title and label of WALL DONE                  |
| `$C946`       | Limit per slot pair allows twice the launch cells: intended? |
| `$BF8B`       | Does the `$21` result end the opening?        |
| `$BF6A`       | Rows and widths of the hatch's bitmap        |
| `$BEE0`       | Which cell pushes the Skimmer, and how?       |
| `$B889`       | Shield count at column 5; leaflet says right  |
| `$B850`       | Rows 0–3 cleared; panel is rows 0–5           |
| `$F30A`       | Is it the title tune's data?                  |
| `$BC1F`       | Schema of the three control-key sets          |
| `$B812`       | Can the control panel shadow row 6?           |
| `$B5F6`       | Column-0 vertical runs shade twice: visible?  |
| `$B7B7`       | Bit 7: only the steering distances' sign bits? |
| `$B3B0`       | A zero-length bar loops 256 times: document?  |
| `$B3F0`       | Why do the two bars' shadow offsets differ?   |
| `$C802`       | Does `$C0D4`'s reset to `$08` pair the explosion toggles? |
| mark bit 5    | Which graphics use cell mask 7?               |
| `$FF70`       | Cover map `$FF` is the map's page byte (relocation) |
| `$D48D`       | Label `shield_loss_due` (split `$D473`)       |
| `$F840`       | Label the hostile slots' state bytes (split `$F473`) |
| `$BBA2`       | Give `read_controls` an `R` row               |
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
| `$BEE0`       | `OR D` gives Z at a shot's first cell: effect? |
| `$C8C4`       | Hostile shot's right range stops at column 30: defect? |
| `$C453`       | Double count of an exploding object: matters at `$C11B`? |
| `$BEEF`       | Say "adds 20 points" in `$BEEF`               |
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
| `$E141`       | Screen 55's last record runs into the next layout |
| `$B4FB`       | Does anything call `$B04F` while `$B058` is a NOP? |
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
| `coverage`        | Counts a bare well-named CALL (ENT-7) as skeletal (`$CD86`) |
| label-namespace   | Roots miss the game loop                         |

### Closed

| Address  | Answer                                              |
|:---------|:----------------------------------------------------|
| `$BA3C`  | Redefined FIRE and FLIP are copied by `$F480`       |
| `$BD3E`  | Inside-the-hull flag                                |
| `$BD3F`  | Sector number, 1–3                                  |
| `$BAC6`  | `$5E` means the game ended by `$BD3D`, no GAME OVER |
| `$C0AC`  | `$C227` fills the image buffers                     |
| `$BE3F`  | The failed-draw write cannot happen                 |
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
