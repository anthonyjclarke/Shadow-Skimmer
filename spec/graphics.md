# The graphics engine

How the game draws a screen and what moves over it. The draw matters to play in one place above all: each bright graphic writes the marks that decide what blocks what. The [Graphics page](../reference/graphics.html) shows every graphic, and the [hull](hull.md) page says what a screen's layout places.

---

## The screen

The control panel fills character rows 0–5, and the play area rows 6–23, across all 32 columns. The screen clear, `clear_screen`, blanks every pixel and colours every cell white ink on black paper. It also gives every cell of the attribute mirror the bright graphic mark that stops the Skimmer, the hostile objects and the shots. Each screen entry clears the marks of the play area again, so the panel's cells keep that mark through a game.

The [hull](hull.md#what-a-screen-shows) page covers the hull surface and the play area's colours. The [Control panel](control-panel.md) page covers rows 0–5.

---

## Graphics, colour patterns and cell masks

The draw of a graphic, `draw_graphic`, places it at a cell from its record in the graphic directory. The entry `outer_graphic_dir` tables the record format: the pixels, the width and height in cells, a colour pattern and a cell mask. A graphic holds 8 bytes per cell, one per pixel row, cell by cell along each row of cells. Its pixels replace what the screen held.

Three passes follow the pixels: colour, marks and shadow. The layout record's ink decides which of them run. #TABLE(default)
{ =h Pass | =h A bright graphic                     | =h A graphic with no ink       }
{ Colour  | Its ink on black, or its colour pattern | White on black, or its pattern }
{ Marks   | Its cell mask's bits, cell by cell      | None                           }
{ Shadow  | Cast on the outer hull                  | None                           }
TABLE#

A colour pattern holds one byte per cell. A 0 byte keeps the cell's colour, $FF gives the cell the graphic's own colour, and any other byte is the cell's attribute. A graphic with no pattern gives every cell its own colour. The patterns start at `colour_pat_1`.

A cell mask holds one byte per cell too. A 0 byte skips the cell, which keeps its pixels and its marks. Any other byte is the set of marks that the cell takes. The masks start at `cell_mask_1`. A graphic with no mask draws every cell, and the [Workspace page](../reference/workspace.html#attribute-mirror) says what marks a bright one then sets.

The animated graphics draw their frames with the attribute $80, in `step_animations`. That draws the pixels alone and keeps the cells' colours and marks.

---

## The attribute mirror

The attribute mirror holds one byte of marks for each cell of the screen, at $FA00. Each mark is one bit, and a cell can hold several. The [Workspace page](../reference/workspace.html#attribute-mirror) tables the marks and what each stops, lets through or hides.

These things write marks. #TABLE(default)
{ =h Writer       | =h Marks                          | =h Routine                         }
{ Bright graphics | Their cell masks' bits            | `mark_graphic`                     }
{ Bars            | The bar mark                      | `join_horizontal`, `join_vertical` }
{ The Skimmer     | Its mark, moved with it each pass | `toggle_skimmer_mark`              }
{ Hostile objects | Their mark, or the explosion mark | `toggle_hostile_marks`             }
{ Shots and hits  | The shot or hit marks             | `draw_shot`, `score_shot_hit`      }
TABLE#

The [Collisions](collision.md) page says what each meet does. Besides the checks for a block, the draw code reads the marks in three places. The marks build the cover maps, keep shadows off, and hide a shot in a cell with the bright graphic or bar mark.

---

## Shadows

On the outer hull, a bright graphic casts a shadow through `cast_shadow`. Inside the hull, nothing casts one. The shadow covers the cells that the graphic sweeps when it slides one cell down and one cell right. That is a band one cell deep under the graphic, and one cell wide up its right side. Each end of the band is cut at 45°.

A shadow shades each cell through one of the shadow masks at `shadow_mask_full`, which clear pixels of the hull surface. It leaves a cell alone when one of its marks keeps shadows off, or when the cell lies below row 23 (`shadow_cell`).

A run of one graphic casts one shadow, as one block the size of the run. The [hull](hull.md#special-graphics) page lists the graphics that cast an extra shadow, a lone shadow cell, or no shadow over a run.

---

## Bars

A layout joins two graphics with a bar through graphic 3 or graphic 5. The second graphic draws, and then a bar of `bar_cell_h` or `bar_cell_v` cells fills the gap from the previous graphic. The bar takes the second graphic's colour and the bar mark. That mark lets shots through, hides the Skimmer and does not stop it. #TABLE(default)
{ =h Bar     | =h Where it runs                 | =h Its shadow                }
{ Horizontal | Along the left end's second row  | Two rows below the bar       }
{ Vertical   | Down the top end's second column | Two columns right of the bar }
TABLE#

BUG: after a run, the layout records the last graphic's size as the previous graphic's cell (`shadow_layout_run`). So a bar that joins the end of a run starts from the wrong cell.

---

## The Skimmer and the hostile objects

The Skimmer and the hostile objects draw over the screen through one draw loop, `skimmer_draw_row`. Each keeps a background store, the screen bytes behind it. Each byte the loop writes is the background through the mask, with the image over it. A step puts back the strip of background that the thing leaves, and saves the strip it enters.

A cover map marks the cells where the thing does not draw. The loop leaves those screen bytes as they are, so whatever hides the thing there stays whole. #TABLE(default)
{ =h Feature         | =h The Skimmer                                | =h A hostile object                }
{ Image              | 3×3 cells, one of 4 by horizontal offset      | 16×16 pixels, one of 4 by offset   }
{ Background store   | `skimmer_bg_store`, 4 bytes per pixel row     | Its slot, 3 bytes per pixel row    }
{ Cover map          | `skimmer_cover_map`, 4×4 cells                | Its slot, 3×3 cells                }
{ Hidden by          | Bright graphics, bars, hostile objects, shots | Bright graphics, bars, the Skimmer }
{ Cover map built by | `map_skimmer_cover`                           | `map_hostile_cover`                }
{ Draws              | Each pass, or each hatchway step              | On each of its moves               }
TABLE#

The Skimmer's images sit pre-shifted at `skimmer_image_1`, 2 pixels apart. At its cell's left edge, the fourth column of its cover map hides it too, since the image leaves that column empty. A hostile object's four images come from its design when it launches, shifted by `preshift_hostile`. The defence device draws its design as it is, through the first explosion mask.

---

## The hatch animation

The hatch is the 3×3 cells at a hatchway's centre, with its pixels in `hatch_bitmap`. The animation shows the hatch in two halves, at one of 13 steps between shut and open. The part of each half that shows at a step comes from `find_hatch_graphic`.

While the hatch lies under the Skimmer, the halves go into the Skimmer's background store (`animate_hatchway`). The Skimmer then draws over them. While the hatch lies over the Skimmer, the Skimmer draws first, and the halves then draw onto the screen over it. On the trip out, the store starts blank, so the Skimmer first draws over black. The [Game flow](game-flow.md#the-hatchway-trip) page gives the phases and how long each lasts.

---

## Text

The game prints its messages line by line, each line at its own cell and in its own attribute (`print_message`). The entry `msg_title` tables the format. Each character draws from `font`, which holds a space, the digits, the capitals and a slash that prints for [, in `print_char`. The control panel's numbers use the same font in their own way, as the [Control panel](control-panel.md#how-the-readouts-roll) page shows.
