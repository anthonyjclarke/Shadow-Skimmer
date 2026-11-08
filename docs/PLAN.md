# Plan – Shadow Skimmer disassembly

The Manager's plan and dig-task queue (`references/roles/manager.md`). It has one current state: update it in place and never append history.

---

## Phase and coverage

| Item                | State                                     |
|:--------------------|:------------------------------------------|
| Phase               | 3 – depth pass, G2 screen layouts         |
| Gate                | `CHECKS PASS` (SkoolKit 10.1, gate 14)    |
| Baseline findings   | 49                                        |
| Routines to the bar | 17 of 120 (`$B080–$B811`)                |
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
| `$C2DA`       | Lone `$C9` after a RET: unused byte?          |
| `$C4DB`       | Table addresses built from immediates: `$BBE5`, `$BF58`, `$C186`, `$C1D0`, `$C1F5`, `$C4E0`, `$C503`, `$CF62` |
| `$C186`       | `LD H,$BD` raw high byte of the launch cells  |
| `$CB8E`       | Delay loop with no caller: unused?            |
| `$CD9C`       | Retype the Skimmer image pointers as `W`      |
| `$BA3B`       | Fold WALL DONE's end `$00` into `t $BA06`     |
| `$BA45`       | Dead store to the text attribute              |
| `$6200`       | Document the graphic directory record (also `$A818`, needs a split) |
| `$B20A`       | Split plot_graphic, plot_unmasked, cast_shadow, draw_shadow into entries |
| `$D800`       | Split the layout tables and lists; record `#TABLE` |
| `$9520`       | Title the defence device designs (`$7CD4` split) |
| `$9A88`       | Label and render the 13 hostile object designs |
| `$95B0`       | 32 zero bytes after the device designs        |
| `$99A0`       | Title the hatch bitmap (`$7CD4` split)        |

### Game behaviour

| Address       | Open question                                 |
|:--------------|:----------------------------------------------|
| whole image   | Sectors 2–3 and game end coverage (FuseX)     |
| `$BA06`       | Title and label of WALL DONE                  |
| `$BD40`       | Is the device the only hostile object inside? |
| `$C946`       | Limit test counts two objects per call: bug?  |
| `$D2CB`       | Countdown forcing directions: which events?   |
| `$D2CC`       | Count up from `$FE` that holds hostile objects: why? |
| `$D2C4`       | Is the first speed-rate byte a step size?     |
| `$D2AF`       | Define the play loop variables with no description |
| `$D47F`       | Damage Report Indicator drain rates           |
| `$D48A`       | Score unit: trace `$D3C7–$D3F6` and `$D2FD`   |
| `$BD44`       | Firing alignment: `$D2B2` = 2, pixel line 4   |
| `$BF8B`       | Does the `$21` result end the opening?        |
| `$BF6A`       | Rows and widths of the hatch's bitmap        |
| `$BEE0`       | Which cell pushes the Skimmer, and how?       |
| `$D2CD`       | Other `$CC0B` patches: `$C47D`, `$C48A`, `$D10F` |
| `$D343`       | Task run by the full interrupt routine        |
| `$C46B`       | Explosion inside the hull sets device flag?   |
| `$C494`       | Cells skipped when they hold ink: why?        |
| `$C955`       | Counter meaning; firing gate ≥ 2              |
| `$C949`       | Pixel offset in 2-pixel steps?                |
| `$C94E`       | Negative states: explosion frames, `$FE`, `$FF` |
| `$C76A`       | What do the inked-cell marks mean?            |
| `$CC32`       | What the NOP / DEC C patch changes            |
| `$CD3A`       | Is AND `$0B` a cover test?                    |
| `$B889`       | Shield count at column 5; leaflet says right  |
| `$B850`       | Rows 0–3 cleared; panel is rows 0–5           |
| `$CCB0`       | Which map does `CP H` test?                   |
| `$CBC6`       | `DEC C` vs `DEC A`: first shield-loss frame never drawn? |
| `$CD36`       | Fold the out-of-line tail into `$CD3A`?       |
| `$D2CF`       | Type `$D2CF` and `$D2BA` as words?            |
| `$CD3A`       | Is the fourth column marked at a cell edge?   |
| `$D2C0`       | Is it the X step size? Speed units of `$D2BF`? |
| `$D2B5`       | Is the speaker bit flipped only at clicks?    |
| `$D2CE`       | Are the clicks the pulse laser shot's sound?  |
| `$CD86`       | When is the Skimmer's mark `$04` toggled?     |
| `$F30A`       | Is it the title tune's data?                  |
| `$BC1F`       | Schema of the three control-key sets          |
| `$BD40`       | Does `$FF` mean the device is destroyed?      |
| `$C2DB`       | Does a pulse laser shot make it explode?      |
| `$C802`       | Which flag bit, and does a second call restore? |
| `$C819`       | What do the blocking marks mean?              |
| `$C880`       | Does it fire across its line of travel?       |
| `$C957`       | What do the per-move flags mean?              |
| `$B812`       | Can the control panel shadow row 6?           |
| `$C18B`       | Does steering override the start direction at once? |
| `$B5F6`       | Column-0 vertical runs shade twice: visible?  |
| `$B7B7`       | Bit 7: only the steering distances' sign bits? |
| `$B3B0`       | A zero-length bar loops 256 times: document?  |
| `$B3F0`       | Why do the two bars' shadow offsets differ?   |
| `$C802`       | Does `$C0D4`'s reset to `$08` pair the explosion toggles? |
| mark bit 5    | Which graphics use cell mask 7?               |
| `$B6F8`       | `add_hostile` draws nothing: who draws the device? |
| `$CDE8`       | Inline `$26`/`$CE` writes are `flag_interrupt`'s address |
| `$CDEC`       | `LD BC,$00FD` holds the vector byte as a literal |
| `$FF70`       | Cover map `$FF` is the map's page byte (relocation) |
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
