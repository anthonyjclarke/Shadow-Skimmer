# Plan – Shadow Skimmer disassembly

The Manager's plan and dig-task queue (`references/roles/manager.md`). It has one current state: update it in place and never append history.

---

## Phase and coverage

| Item                | State                                     |
|:--------------------|:------------------------------------------|
| Phase               | 2/3 – naming pass, then deep-document     |
| Gate                | `CHECKS PASS` (SkoolKit 10.1, gate 14)    |
| Baseline findings   | 194                                       |
| Routines to the bar | 0 of 120                                  |
| Data documented     | screen text `$B89F–$BA3A`                 |
| Glossary            | registry (11 words) and naming policy     |
| Catalogs            | graphics, sound, data: not started        |
| Behaviour spec      | not started                               |
| Relocatability      | label-clean; unproven                     |

---

## In flight

| Target                  | Lane     | State                    |
|:------------------------|:---------|:-------------------------|
| Glossary bootstrap      | glossary | fixed; Challenger re-review  |
| Naming S1–S9            | code     | S1–S4 back; S5 renaming; S6–S9 running |

---

## Naming pass (phase 2)

| Slice | Range                         |
|:------|:------------------------------|
| S1    | `$61FD`, `$B000–$B426`        |
| S2    | `$B427–$B89E`                 |
| S3    | `$BA3C–$BD0E`                 |
| S4    | `$BD44–$C226`                 |
| S5    | `$C227–$C657`                 |
| S6    | `$C658–$C962`                 |
| S7    | `$C963–$CBA7`                 |
| S8    | `$CBA8–$CE90`                 |
| S9    | `$CE91–$D472`, `$F000–$F472`  |
| V     | variables `$BD0F–$BD43`       |

---

## Dig-tasks

| Address       | Open question                                 |
|:--------------|:----------------------------------------------|
| `$61A8`       | What is the code-like stub below the entry?   |
| `$F009`       | Decrypted listing of the encrypted routine    |
| `$F30A–$F45E` | Code or data? No play trace executes it       |
| `$FA00–$FFFF` | `@equ` names for workspace and IM 2 table     |
| whole image   | Sectors 2–3 and game end coverage (FuseX)     |
| `$BA3B`       | Fold WALL DONE's end `$00` into `t $BA06`     |
| `$B51C`       | WALL DONE trigger: `$BD3D`, `$BD3E`, `$B4D9`  |
| `$BA06`       | Title and label of WALL DONE, once derived    |
| `$CE91`       | Does it run a whole game?                     |
| `$BA45`       | Dead store to the text attribute              |
| `$A020`       | Map and render the font; `$A150` is the "/"   |
| hatchway      | One thing or two (place and opening cover)?   |
| final goal    | Is the mothership entry-way its own entity?   |
| shots         | Names for the player's and others' shots      |
| skill         | `CHECK_terms` passes no `--registry`          |
| `$BA3C`        | Redefined FIRE/FLIP never read by `$BBA2`?    |
| `$BAA7`        | Code with no caller: unused?                  |
| `$BC68`        | Draw-mode code templates: what copies them?   |
| `$F480`        | `$BA3C` jumps here into a b block: code?      |
| `$D2CB`        | Countdown forcing directions: which event?    |
| `$BAC6`        | `$CE91` returning `$5E` skips GAME OVER: why? |
| `$BC70`        | What map lives at attributes + `$A200`?       |
| `$C936`        | Game word for the hostile objects' shot       |
| `$F800`        | Are these the leaflet's "hostile objects"?    |
| `$BEE0`        | Which square pushes the Skimmer, and how?     |
| `$BEEF`        | Meaning of the hit mark; is `$D48A` the score? |
| `$C0AC`        | What fills the `$5B00–$5FFF` graphics?        |
| `$BE3F`        | Failed draw writes the range byte: bug?       |
| `$D2CD`        | Patched into `$CC0A` on launch: sound?        |
| `$B7DA`        | Split the bar cells off the shadow masks      |
| `$B766`        | Code or data? No reader found                 |
| `$BD3E`        | Confirm 0 = outer hull, 1 = inner section     |
| `$BD40`        | Flag = "defence device destroyed"?            |
| `$BD28`        | What are the four launch cells?               |
| `$B889`        | Shield count at column 5, leaflet says right  |
| `$95D0`        | Game name for the animated 3×3 graphic        |
| `$B850`        | Rows 0–3 cleared, panel is rows 0–5           |
| glossary       | Admit playfield, attribute mirror, animation list? |
| skill          | verify-frag renders `game.skool`, baseline keys `shadskim.skool` |
| skill          | `diff_entries.py` skips untracked files       |
| skill          | DEF-6/VIS-11 exemption for policy and registry boxes |
| `$B0BE`        | Split into mask/colour tables; pointers as `W` |
| `$BD3F`        | Is it the sector number (1–3)?                |
| `$FA00`        | Attribute mirror: `@equ` name and its bits    |
| `$B3B0`        | Game terms for structure end + bar pieces     |
| `$B096`        | Off-edge column ≥ 32 lands on next row: bug?  |
| `$B04F`        | What does `$B507` draw with the INC DE patch? |
| glossary       | Register "hostile object" (Not: drone)        |
