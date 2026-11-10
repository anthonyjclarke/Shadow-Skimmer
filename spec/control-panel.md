# Control panel

The control panel across the top of the screen: what it shows, and where. When each part draws, and how its numbers roll. The [Economy](economy.md) page gives the rate at which the Damage Report Indicator runs down. The [Score](score.md) page gives the rate at which points count into the score.

---

## What the panel shows

The panel draws over character rows 0–5, as two halves of 16 columns (`draw_control_panel`). Each half takes its colours from a colour pattern of its own, `colour_pat_33` and `colour_pat_34`. The [control panel](../reference/graphics.html#control-panel) on the Graphics page shows it. These readouts sit on it. #TABLE(default)
{ =h Readout              | =h Character row | =h Columns | =h Drawn by     }
{ Damage Report Indicator | 1                | 4–6        | `print_readout` }
{ Defence device picture  | 1                | 15–16      | `draw_screen`   }
{ Score                   | 1                | 24–29      | `print_readout` }
{ Shield count            | 3                | 5          | `print_shields` }
{ Sector digit            | 3                | 26         | `print_digit`   }
TABLE#

The shield count and the sector digit print in bright white ink on black paper. The indicator and the score print in inverse video, in the colours that the panel's pattern gives their cells. The device picture is 16×16 pixels, and it starts half a cell down from the top of row 1.

The instruction leaflet puts the shield count on the far right of the control panel. The code prints it in the left half, and the digit on the right is the sector.

---

## When each part draws

Each part of the panel draws on events of its own. #TABLE(default)
{ =h Event                        | =h What draws                             }
{ A game starts                   | The whole panel, and the shield count     }
{ A screen is entered             | The sector digit and the device picture   }
{ Each pass of the play loop      | The indicator and the score               }
{ Each interrupt in a screen draw | The indicator and the score               }
{ A shield is lost                | The shield count, which blinks four times }
{ The last shield is lost         | The shield count, at 0                    }
TABLE#

At the start of a game, the pixels of rows 1–4 go blank and the panel draws over them (`start_game`). Nothing draws the panel's graphic again in that game. The device picture shows the design of the current sector's device at `device_designs`, whether that device stands or not.

The readouts roll only while `update_readouts` runs. So they stand still through the GAME OVER hold and the blinks of a shield loss. They go on through every screen draw, the WALL DONE hold included. The [Game flow](game-flow.md) page gives those holds.

---

## How the readouts roll

The indicator and the score are rows of decimal digits at `damage_digits` and `score_digits`, three and six of them. Each digit takes one byte: eight times its value, plus its eighths on the way to the next value. So a digit runs from 0 to 79, in eighths of a unit.

A digit draws from the font as many pixel rows into its glyph as it has eighths (`print_inverse_digit`). The draw runs on into the top rows of the next glyph. So as its eighths grow, the digit rolls up its cell toward the next one. The font holds a second 0 after the 9, so a 9 rolls on into a 0.

The digits move together as an odometer does. While the last digit rolls from 9 on to 0, the digit on its left rolls with it by the same eighths (`add_score_digits`). The indicator rolls back the same way from 0 to 9 (`subtract_damage_digits`).

Each update moves a readout by one step. The indicator loses its drain, and the score gains its score step. The score step is the amount at `score_step`, from one eighth of a point up to 4 points.
