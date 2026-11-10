# The hull

The map of screens the Skimmer crosses, and how the map splits into sectors. What a screen's layout holds, and the graphics that do more than draw. The [Screens page](../reference/screens.html) shows every screen as the game draws it.

---

## The hull map

The hull is a map of 10×11 screens. Its 10 columns run 0–9 from the left, and its 11 rows run 0–10 from the top. A screen's number is 10 × its row + its column, from 0 to 109. The number of each row's first screen sits at `row_first_screen`, and `enter_screen` adds the column to it.

The Skimmer's place on the map is in `screen_column` and `screen_row`, and the screen's number in `screen_number`. A game starts on screen 1, at column 1, row 0. The [hull map](../reference/screens.html#hull-map) shows the outer hull as one picture.

Each screen number has two layouts. One is on the outer hull, at `outer_layout_addrs`, and one in the inner sections, at `inner_layout_addrs`. The flag `inside_hull` says which of the two the Skimmer is on. The [Game flow](game-flow.md#edge-crossings) page says how the Skimmer moves from screen to screen.

---

## Sectors

The sector follows from the screen's place on the map alone. Each screen entry works it out, in `enter_screen`, and keeps it in `sector`. #TABLE(default)
{ =h Sector | =h Map columns | =h Map rows | =h Hull surface  }
{ 1         | 0–1            | 0–10        | `hull_surface_1` }
{ 2         | 2–9            | 5–10        | `hull_surface_2` }
{ 3         | 2–9            | 0–4         | `hull_surface_3` }
TABLE#

The sector picks the hull surface pattern and the digit on the control panel. It also picks the defence device that the panel pictures and that the screen's graphics read. No boundary between sectors blocks the Skimmer.

---

## What a screen shows

Each screen entry prepares the play area, rows 6–23, before the layout draws. On the outer hull, `draw_hull_surface` tiles it with the sector's pattern, in bands of 16 pixel rows. Inside the hull, the same routine blanks the play area.

The play area then takes white ink on black paper. A screen in the map's column 0 colours its left 11 columns black ink on black paper (`colour_play_area_split`). So nothing drawn there shows. The marks of every play area cell in the attribute mirror clear.

### Layouts

The screen draw, `draw_screen`, then draws the screen's layout: a list of records that each place one graphic at one cell. The entry `outer_layout_0` tables the format of a record, and the inner sections use the same format at `inner_layout_0`. The records draw in order, so a later graphic draws over an earlier one.

A record's ink decides what its graphic does to the play. A graphic with an ink draws bright on black paper. It marks its cells in the attribute mirror through its cell mask, and on the outer hull it casts a shadow. A graphic with no ink draws in white, not bright, and marks no cell and casts no shadow.

So of the layout's graphics, only bright ones can block the Skimmer, a hostile object or a shot. A cell's marks, from the cell mask, decide which of them it blocks. The [graphics engine](graphics.md#graphics-colour-patterns-and-cell-masks) page covers the draw, and the [Workspace page](../reference/workspace.html#attribute-mirror) tables the marks.

A record can start a run, which repeats its graphic toward the next record's cell, one graphic width or height apart. The run goes across to the next record's column, or down to its row when the two share a column. It stops short of that cell, where the next record draws its own graphic. A run casts one shadow over the whole run.

The outer hull draws its graphics from `outer_graphic_dir`, and the inner sections from `inner_graphic_dir`. The [Graphics page](../reference/graphics.html#outer-hull-graphics) shows both sets by graphic number.

---

## Special graphics

Some graphic numbers have a task of their own beside the draw, or in its place, in `draw_layout_graphic`. On the outer hull these are the graphics below. #TABLE(default)
{ =h Graphic | =h What it does                              | =h Routine            }
{ 3          | Joins a horizontal bar to the graphic before | `join_horizontal`     }
{ 5          | Joins a vertical bar to the graphic before   | `join_vertical`       }
{ 26         | Shades a lone cell, one down and one right   | `test_shaded_graphic` }
{ 31–34      | Records a launch cell for hostile objects    | `store_launch_cell`   }
{ 35         | Draws a hatchway with its hatch              | `draw_hatchway`       }
{ 38         | Shades one cell, and draws nothing           | `test_shadow_cell`    }
{ 43         | Draws the animated graphic                   | `draw_animated`       }
{ 63         | Casts no shadow over a run down              | `run_down_done`       }
{ 67         | Casts no shadow over a run across            | `run_across_done`     }
{ 79         | Casts a second shadow, one cell further out  | `cast_far_shadow`     }
{ 150        | Draws only while the sector's device stands  | `test_gate_graphic`   }
TABLE#

In the inner sections, these graphics do more than draw. #TABLE(default)
{ =h Graphic | =h What it does                          | =h Routine              }
{ 16         | Records a hatchway, and draws it         | `record_inner_hatchway` }
{ 17         | Sets up the defence device, if it stands | `draw_inner_graphic`    }
TABLE#

Graphic 43 adds an entry to `animation_list`, which has room for two. The [animated graphic](../reference/graphics.html#animated-graphic) on the Graphics page shows its frames. The [Effects and sound](effects-sound.md) page says how often they change.

---

## Launch cells

A launch graphic records a launch cell one cell down and one cell right of its top-left cell. It also gives the cell a start direction, by the graphic's number. The launch cells sit at `launch_cells`, with room for four, and `launch_cell_count` counts them. Each screen entry clears the count.

Hostile objects enter the screen only at its launch cells. A screen with no launch graphic has none, and so does every inner section. The [Hostile objects](hostile-objects.md) page covers the launch rule and the defect in the start direction.

---

## Hatchways

A hatchway is a graphic of 5×5 cells, and its hatch is the 3×3 cells at its centre. A screen holds at most one, since `hatchway_cell` records one cell. A screen with no hatchway leaves it at column 0, row 0.

On the outer hull, the hatchway draws first and then the hatch over its centre (`draw_hatchway`). Two of the eight `hatch_patterns` decorate the hatch. The screen number picks them: it indexes the ROM from $0400, and the byte's two nibbles each choose a pattern. So a screen's hatch looks the same on every visit. The [hatch](../reference/graphics.html#hatch) on the Graphics page shows one.

Each hatchway joins the outer hull and the inner section with the same screen number. The Skimmer arrives on the same cell of the screen on the other side. The [Game flow](game-flow.md#the-hatchway-trip) page covers the trip.

---

## Defence devices

Each sector has one defence device, and `device_destroyed_1` to `device_destroyed_3` say whether it stands. A game starts with all three in place. Inner graphic 17 places a device, and the device belongs to the sector its screen lies in.

When the Skimmer enters that screen, the device takes the first hostile object slot (`init_defence_device`). Its picture comes from `device_designs`, by the sector. The device is a hostile object that never moves and never fires. The [Hostile objects](hostile-objects.md) page covers it, and the [Collisions](collision.md) page how a shot destroys it.

An explosion inside the hull sets the current sector's flag to $FF, in `explode_hostile`. The readers of the flags found are two tests in `draw_layout_graphic`. From the next screen draw on, a destroyed device no longer appears on its inner screen. No graphic 150 draws on the outer screens of its sector either.

The control panel's device picture stays the same. The leaflet says a sector's device must go before the Skimmer can pass into the next sector. In the code, the devices change the hull through graphic 150 alone.

---

## Inner sections

The Skimmer reaches the inner sections only through a hatchway. Inside, it crosses screen edges by the same map as outside.

The inner sections differ from the outer hull in these ways. #TABLE(default)
{ =h Inside the hull                            | =h Where the code says so }
{ The play area is blank, with no hull surface  | `draw_hull_surface`       }
{ Nothing casts a shadow                        | `cast_shadow`             }
{ The graphics come from their own directory    | `draw_graphic`            }
{ No launch cells, so no hostile objects launch | `draw_inner_graphic`      }
{ The only hostile object is the defence device | `draw_inner_graphic`      }
TABLE#

An inner screen whose layout holds no records shows an empty play area. Inner screen 5 is the [WALL DONE screen](game-flow.md#wall-done-the-win), which ends the game before any layout draws.
