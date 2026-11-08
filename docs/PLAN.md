# Plan – Shadow Skimmer disassembly

The Manager's plan and dig-task queue (`references/roles/manager.md`). It has one current state: update it in place and never append history.

---

## Phase and coverage

| Item                | State                                     |
|:--------------------|:------------------------------------------|
| Phase               | 2 – naming pass, all slices integrated    |
| Gate                | `CHECKS PASS` (SkoolKit 10.1, gate 14)    |
| Baseline findings   | 52                                        |
| Routines to the bar | 0 of 120                                  |
| Data documented     | screen text, variables, workspace `$C909` |
| Glossary            | registry (11 words) and naming policy     |
| Catalogs            | graphics, sound, data: not started        |
| Behaviour spec      | not started                               |
| Relocatability      | label-clean; unproven                     |

---

## In flight

| Target              | Lane | State                                |
|:--------------------|:-----|:-------------------------------------|
| Naming S8, S9       | code | fixes applied; final re-review       |

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

---

## Dig-tasks

### Code and data

| Address       | Open question                                 |
|:--------------|:----------------------------------------------|
| `$61A8`       | What is the code-like stub below the entry?   |
| `$F009`       | Decrypted listing of the title tune player (see `docs/RESEARCH.md`) |
| `$F30A–$F45E` | Code or data? No play trace executes it       |
| `$F480`       | Document the key copy that `$BA3C` jumps to   |
| `$FA00`       | Attribute mirror: `@equ` name and mark bits   |
| `$FA00–$FFFF` | `@equ` names for workspace and IM 2 table     |
| `$A020`       | Map and render the font; `$A150` is the "/"   |
| `$B16F`       | Label the control panel patterns in `$A2B8`   |
| `$B11B`       | Mask 7 serves 4- and 5-wide graphics          |
| `$B766`       | Code or data? No reader found                 |
| `$BAA7`       | Code with no caller: unused?                  |
| `$BC68`       | Draw-mode code templates: what copies them?   |
| `$C2DA`       | Lone `$C9` after a RET: unused byte?          |
| `$C4DB`       | Table address built from immediates           |
| `$C186`       | `LD H,$BD` raw high byte of the launch cells  |
| `$B5BD`       | `LD DE,($BD14)` reloads D from the draw attribute |
| `$CB8E`       | Delay loop with no caller: unused?            |
| `$CD9C`       | Retype the Skimmer image pointers as `W`      |
| `$BA3B`       | Fold WALL DONE's end `$00` into `t $BA06`     |
| `$BA45`       | Dead store to the text attribute              |

### Game behaviour

| Address       | Open question                                 |
|:--------------|:----------------------------------------------|
| whole image   | Sectors 2–3 and game end coverage (FuseX)     |
| `$B51C`       | WALL DONE screen: inner screen 5, `$BD3D`     |
| `$BA06`       | Title and label of WALL DONE                  |
| `$BD18`       | Run flag and low bits: animation speed?       |
| `$BD19`       | Real maximum layout row                       |
| `$B681`       | More than 4 launch graphics overwrite the pointer? |
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
| `$BF6A`       | Rows and widths of the hatchway graphic       |
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
| `$FF70`       | What the flip check searches                  |
| `$B096`       | Off-edge column ≥ 32 is one past 31: bug?     |
| `$B04F`       | What does `$B507` draw with the INC DE patch? |
| `$B889`       | Shield count at column 5; leaflet says right  |
| `$B850`       | Rows 0–3 cleared; panel is rows 0–5           |
| `$B640`       | List every special layout graphic             |
| `$CCB0`       | Which map does `CP H` test?                   |
| `$CBC6`       | `DEC C` vs `DEC A`: first shield-loss frame never drawn? |
| `$CD36`       | Fold the out-of-line tail into `$CD3A`?       |
| `$D2CF`       | Type `$D2CF` and `$D2BA` as words?            |
| `$CD3A`       | Is the fourth column marked at a cell edge?   |
| `$D2C0`       | Is it the X step size? Speed units of `$D2BF`? |
| `$D2B5`       | Is the speaker bit flipped only at clicks?    |
| `$D2CE`       | Are the clicks the pulse laser shot's sound?  |
| `$CD86`       | Meaning of attribute mirror mark `$04`        |
| `$CCD3`       | Meaning of the mark the flipped Skimmer ignores |
| `$EA00`       | Inner-section map index                       |
| `$F30A`       | Is it the title tune's data?                  |
| `$B3B0`       | Does the bar run from the previous graphic?   |
| `$B432`       | Is `$99A0` the hatchway graphic's buffer?     |
| `$B449`       | Do cover patterns depend on the screen number? |
| `$B4A7`       | Does it draw the first frame?                 |
| `$B4D9`       | Which table is the inner-section map?         |
| `$B7B7`       | Which mirror marks block a shadow?            |
| `$B27D`       | Does mask 0 draw every cell?                  |
| `$B427`       | The 11 fields of the animation template       |
| `$BC1F`       | Schema of the three control-key sets          |
| `$BD40`       | Does `$FF` mean the device is destroyed?      |
| `$C2DB`       | Does a pulse laser shot make it explode?      |
| `$C802`       | Which flag bit, and does a second call restore? |
| `$C819`       | What do the blocking marks mean?              |
| `$C880`       | Does it fire across its line of travel?       |
| `$C957`       | What do the per-move flags mean?              |
| `$C926`       | Can a screen hold a third animated graphic?   |
| `$D800`       | Layout format; count graphic `$2B` per screen |
| `$B789`       | Is the colour rectangle reachable?            |

### Names

| Subject        | Open question                                 |
|:---------------|:----------------------------------------------|
| hostile object | Register the name rulings in the glossary     |
| `$95D0`        | Game name for the animated 3×3 graphic        |
| hatchway       | One thing or two (place and opening cover)?   |
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
