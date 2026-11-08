# Plan – Shadow Skimmer disassembly

The Manager's plan and dig-task queue (`references/roles/manager.md`). It has one current state: update it in place and never append history.

---

## Phase and coverage

| Item                | State                                     |
|:--------------------|:------------------------------------------|
| Phase               | 3 – deep-document (starting)              |
| Gate                | `CHECKS PASS` (SkoolKit 10.1, gate 14)    |
| Baseline findings   | 194                                       |
| Routines to the bar | 0 of 120                                  |
| Data documented     | screen text `$B89F–$BA3A`                 |
| Glossary            | not started                               |
| Catalogs            | graphics, sound, data: not started        |
| Behaviour spec      | not started                               |
| Relocatability      | label-clean; unproven                     |

---

## In flight

| Target                  | Lane | State                         |
|:------------------------|:-----|:------------------------------|
| Screen text `$B89F`     | code | fixed; Challenger re-review   |

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
| `$CE91`       | Does it run a whole game?                     |
| `$BA45`       | Dead store to the text attribute              |
| `$A020`       | Map and render the font; `$A150` is the "/"   |
