# Shots

Two shots exist: the Skimmer's pulse laser shot, and the hostile objects' shot, which all the hostile objects share. Each is one cell, and moves one cell per pass along a row or a column. It ends when its range runs out or a cell stops it. At most one of each flies at a time. The [State](state.md#shots) page gives their records, at `pulse_laser_shot` and `hostile_shot`.

---

## The pulse laser shot

Fire with one direction alone launches the shot that way, on these conditions. The [Controls](input.md#fire) page gives the rest of what fire does. #TABLE(default)
{ =h Direction | =h The Skimmer needs                     | =h First cell                }
{ Left         | Offset of half a cell, column 1 or more  | Left of its second cell row  }
{ Right        | Offset of half a cell, column 26 or less | Right of its second cell row }
{ Up           | Top half a cell down, row 7 or more      | Above its second column      }
{ Down         | Top half a cell down, row 19 or less     | Below its second column      }
TABLE#

For left and right, half a cell means a horizontal offset of 4 pixels. For up and down, it means a top pixel row 4 rows into its cell row. So the Skimmer fires only along an axis it moves on, and only at the middle of a cell. At rest on a cell it cannot fire at all.

The [Controls](input.md) page gives when the fire test reads the controls.

---

## The hostile objects' shot

The shot fires from the hostile object that moves, when these all hold. The routine is `hostile_fire`. #TABLE(default)
{ =h Condition                                }
{ The object lies half a cell into its travel }
{ The hostile objects' shot is out of flight  }
{ It will not steer at its next whole cell    }
{ The object belongs to the current screen    }
{ The object does not explode                 }
TABLE#

It fires at right angles to the object's travel, toward the Skimmer's side. An object that moves up or down fires right when its column lies left of the Skimmer's. Otherwise it fires left. One that moves left or right fires down when its row lies above the Skimmer's, and up otherwise. The test compares the top-left cells of the object and the Skimmer. #TABLE(default)
{ =h Direction | =h The object needs | =h First cell                }
{ Left         | Column 1–30         | Left of its middle cell row  }
{ Right        | Column 27 or less   | Right of its middle cell row }
{ Up           | Character row 7–22  | Above its middle column      }
{ Down         | Character row 6–20  | Below its middle column      }
TABLE#

An object that moves up or down sits square on a cell across its travel. So at the middle of its travel it covers two columns and three rows. One that moves left or right covers three columns and two rows. The defence device never lies half a cell into a travel, so it never fires. The [Hostile objects](hostile-objects.md) page gives the count of cells to an object's next steer.

---

## Range

The launch sets the range: the number of cells from the first cell to the end of the line, the first cell included. #TABLE(default)
{ =h Shot               | =h Left  | =h Right  | =h Up             | =h Down             }
{ Pulse laser shot      | Column 0 | Column 31 | The play area top | The screen's bottom }
{ Hostile objects' shot | Column 0 | Column 30 | The play area top | The screen's bottom }
TABLE#

So each shot reaches the edge of the play area, but for the hostile objects' shot to the right. That one stops one column short of the screen's right edge.

---

## Flight, pass by pass

Both shots move one cell per pass once they leave their first cell. #TABLE(default)
{ =h Pass         | =h Pulse laser shot     | =h Hostile objects' shot }
{ Launch          | Drawn in its first cell | Drawn in its first cell  }
{ Next pass       | Moves one cell          | Holds its first cell     }
{ Each later pass | Moves one cell          | Moves one cell           }
{ Range runs out  | Ends, with no draw      | Ends, with no draw       }
TABLE#

The pulse laser shot launches early in a pass, and that pass's move only clears its launch mark. The hostile objects' shot launches late in a pass, in the move of the hostile objects. So it holds its first cell through the whole next pass. A shot with a range of R shows in R cells, and ends on the move after its last cell.

Each move puts back the cell the shot leaves, then checks the next cell. A move that ends the shot draws nothing more. Both shots move in `move_shots`, the pulse laser shot first.

---

## What a cell does to a shot

The marks of the cell the shot enters decide, in `check_shot_cell`. The [Workspace page](../reference/workspace.html#attribute-mirror) defines the marks. #TABLE(default)
{ =h Marks in the cell                  | =h What happens                          }
{ None that stop a shot                 | The shot enters and shows                }
{ Only the bright graphic or bar mark   | The shot enters, hidden                  }
{ The Skimmer's, with no hostile object | A push on the Skimmer, and the shot ends }
{ A hostile object's, with no Skimmer   | A hit, 20 points, and the shot ends      }
{ Any other mark that stops a shot      | The shot ends                            }
TABLE#

The rule is the same for both shots. The [Score](score.md#awards) page gives the points for each shot. A shot that ends at its first cell leaves no shot in flight. A pulse laser shot launched onto a hostile object scores the hit at once, and no shot appears. The [Collisions](collision.md) page gives what a hit does, and the [Skimmer](skimmer.md#pushes) page gives the push.

A hidden shot leaves the cell's colour, pixels and marks alone. A shot that shows gives its cell the marks of a shot. It saves the cell's colour and pixels, and draws its graphic for its direction. A shot that shows stops the other shot, as any shot cell does.

---

## Colour and sound

The pulse laser shot draws in bright red ink on black paper, and the hostile objects' shot in bright yellow ink on black paper. The [Graphics page](../reference/graphics.html#shots) shows the graphics for each direction.

A launch of either shot sets off the shot's clicks, over two passes. The [Effects and sound](effects-sound.md#sounds) page gives the clicks.
