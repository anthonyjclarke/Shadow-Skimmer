# Research notes – Shadow Skimmer

NON-AUTHORITATIVE. These are the Researcher's leads from a read of the code (no outside sources). Every claim needs a Worker's claim set and a Challenger before it reaches the disassembly.

---

## Leads from the code

| Subject           | Lead                                          |
|:------------------|:----------------------------------------------|
| Graphic storage   | Row-major cells, 8 bytes each (`#UDGARRAY`)   |
| Graphic directory | 4 bytes: address, width+pattern, height+mask  |
| Outer directory   | `$6200`, 151 entries                          |
| Inner directory   | `$A818`, 18 entries                           |
| Hull map          | One 10×11 grid of screens                     |
| Screen number     | `$CE86`[row] + column                         |
| Sectors           | Column < 2: 1; row ≥ 5: 2; otherwise 3        |
| Outer layouts     | `$D800`: 110 pointers, lists from `$D8DC`     |
| Inner layouts     | `$EA00`: lists from `$EADC`; index unknown    |
| Hostile designs   | 13 × 64 bytes at `$9A88`, image then mask     |
| Explosion frames  | `$9E08`, masks at `$9F58`                     |
| Skimmer images    | From `$8800`, 96 bytes each (4 × 24)          |
| Font              | `$A020`: 0–9, spare, space, A–Z, "/"          |
| Control panel     | `$A158`/`$A458`, patterns `$A758`/`$A7B8`     |
| Defence devices   | 48 bytes per sector at `$9520`                |
| Hull patterns     | `$8B00`, `$94E0`, `$9500`                     |
| Title tune data   | `$F30A–$F45E`, likely                         |
| Sound sites       | `$C4B9`, `$CC15`, `$BAD1`, `$CF93`            |

### Layout record (parse loop `$B548–$B625`)

| Byte | Content                                         |
|:-----|:------------------------------------------------|
| b0   | Graphic number; `$FF` ends the list             |
| b1   | Column (bits 0–4) and ink (bits 5–7)            |
| b2   | Row − 6 (bits 0–4) and flags (bits 5–7)         |
| b3   | Run end column, when flag bit 2 is set          |
| b4   | Run end row, for a vertical run                 |

---

## Devices, in priority order

| #  | Device                                  | Waits on                     |
|:---|:----------------------------------------|:-----------------------------|
| 1  | Hull-map render (tools generator)       | Graphics engine, layouts     |
| 2  | Layout-record `#TABLE` and markup       | Layout format confirmed      |
| 3  | Outer graphic gallery                   | Directory and masks          |
| 4  | Hostile objects, explosion `#FRAMES`    | Mask polarity, frame order   |
| 5  | Skimmer images and frames               | `$CD9C` as `W`, `$CDC8`      |
| 6  | Control panel and device pictures       | Pattern `$FF` rule           |
| 7  | Font strip with character table         | Glyph order                  |
| 8  | Title tune `#AUDIO`                     | Decrypted `$F009` listing    |
| 9  | In-game click `#AUDIO`                  | `$CC0B` patch values         |
| 10 | Attribute-mirror mark `#TABLE`          | `$FA00` single-owner task    |
| 11 | Behaviour spec by subsystem             | Depth passes                 |
| 12 | Bugs, facts and pokes                   | Code-derived only            |

---

## Proposed depth order

1. Graphics engine core: `$B20A–$B38E`, mask and pattern tables.
2. Screen layout interpreter `$B4D9`, `$B640`/`$B6DD`, bars and shadows, with the layouts at `$D800`/`$EA00`. Run it together with step 3.
3. Attribute mirror `$FA00` and its `@equ` names (single owner).
4. `play_game` `$CE91`, the play loop variables `$D2AF–$D2D5`, the interrupt task `$D343`.
5. Hostile objects `$C0B4–$C880`, designs and explosions.
6. Skimmer movement, drawing and flip `$C963–$CE86`, `$D219`.
7. Firing and hatchways `$BD44–$C09B`.
8. Damage, shields, score and control panel `$D24A–$D41A`, `$B812`, `$B889`, font.
9. Decrypted title tune player and its data, in parallel at any time.
