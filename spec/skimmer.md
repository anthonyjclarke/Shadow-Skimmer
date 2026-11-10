# The Skimmer

The Skimmer is what the player flies. It moves over the play area in steps of 2 or 4 pixels, one axis after the other. A pass of the play loop takes at most one step on each axis. Its speed on each axis is a whole number from −3 to 3. The speed changes only while the Skimmer sits square on a cell along that axis.

The [Controls](input.md) page gives the controls that set the speed. The [Collisions](collision.md) page gives what the Skimmer meets.

---

## Position

Four variables place the Skimmer, and the [State](state.md) page gives their addresses. #TABLE(default)
{ =h Variable        | =h Holds                                 }
{ `skimmer_column`   | Column of the top-left cell, 0–29        }
{ `skimmer_row`      | Character row of the top-left cell, 6–21 }
{ `skimmer_x_shift`  | Horizontal offset, 0–3 steps of 2 pixels }
{ `skimmer_scr_addr` | Screen address of the top pixel row      }
TABLE#

The left edge of the Skimmer lies 8 pixels per column from the screen's left edge, plus 2 pixels per step of its horizontal offset. Its top pixel row lies 8 pixels per character row down, plus its pixel row within that cell row. That pixel row is the low three bits of the screen address's high byte. The attribute mirror address of the top-left cell sits in `skimmer_mirror_addr`.

The Skimmer is 24 pixel rows deep, and its images are 4 bytes wide. It covers 3×3 cells while it sits square on a cell. A horizontal offset above 0 adds a fourth column. A top pixel row below a cell's top adds a fourth row.

---

## Speed

The speeds sit in `speed_x` and `speed_y`, from −3 to 3. A positive horizontal speed moves the Skimmer left, and a positive vertical speed moves it up. Each speed has a step size and a step mask, from its record in `speed_rates`. #TABLE(default)
{ =h Speed | =h Step  | =h Steps on       | =h Pixels per pass }
{ 0        | None     | No pass           | 0                  }
{ 1        | 2 pixels | Every second pass | 1                  }
{ 2        | 2 pixels | Every pass        | 2                  }
{ 3        | 4 pixels | Every pass        | 4                  }
TABLE#

The rates hold on both axes. A horizontal step of 2 pixels is one step of the horizontal offset, and a step of 4 pixels is two. A step never crosses a cell edge partway, since each step size divides a cell.

A step mask of 1 makes the axis step on every second pass. The step phase flips on each pass, and the axis steps on the passes that leave it at 0. The play loop sets the phase to the mask whenever it sets the rates. So the first step comes on the next pass.

While no push runs, the flipped Skimmer takes the rates of the next slower speed. Its speed 3 then moves 2 pixels per pass, and its speed 2 moves 1 pixel per pass. Speed 0 has the rates of speed 1, so the flipped Skimmer at speed 1 keeps its pace. The routine is `set_speed_rates`.

### When the speed changes

The play loop sets the speed on an axis once per pass, after the steps. It does so only while the Skimmer sits square on a cell along that axis. Horizontally that means an offset of 0, and vertically a top pixel row at a cell's top. #TABLE(default)
{ =h Controls on the axis | =h Change of speed                  }
{ One direction held      | One unit that way, up to 3          }
{ Both directions held    | One unit toward 0                   }
{ Neither held            | One unit toward 0                   }
{ A shield loss is due    | One unit toward 0, whatever is held }
TABLE#

So a held direction reaches speed 3 at the third whole cell on that axis, the one where it starts included. The rates change with the speed, at the same moment.

A Skimmer with no direction held slows by one unit at each whole cell. From speed 3 it comes to rest within three cells. The [Economy](economy.md) page gives the shield loss.

---

## Moves and blocks

Each pass steps the vertical axis first, then the horizontal one. A step checks the cells ahead only when the Skimmer reaches into a new column or row of cells. #TABLE(default)
{ =h Step | =h When it checks             | =h Cells it checks            }
{ Left    | The offset would drop under 0 | The column on its left        }
{ Right   | The offset is 0               | The column right of its third }
{ Up      | Its top lies on a cell's top  | The row above it              }
{ Down    | Its top lies on a cell's top  | The row below its third       }
TABLE#

The check spans four cells when the Skimmer sits off the grid on the other axis, and three otherwise. The marks in the attribute mirror decide, through `check_skimmer_column` and `check_skimmer_row`. The [Workspace page](../reference/workspace.html#attribute-mirror) gives the marks that stop the Skimmer.

A blocked step leaves the Skimmer where it stands on that axis for the pass. It also reverses the speed on that axis, at the same size. So the Skimmer turns back from a block at the speed it had. A hostile object, a shot or a hit in the blocked cell also starts a push, as below.

The flipped Skimmer passes the cells of the bright graphics that stop it the right way up. Every other mark that stops it the right way up stops it flipped too.

---

## Screen exits

A step across an edge of the play area flags an exit in `screen_exit`. The [Game flow](game-flow.md#edge-crossings) page gives the screen it leads to, and where the Skimmer enters. #TABLE(default)
{ =h Edge | =h The step that crosses it               }
{ Left    | Left from column 0, at an offset of 0     }
{ Right   | Right from column 29, at an offset of 0   }
{ Top     | Up from the top cell row of the play area }
{ Bottom  | Down from character row 21                }
TABLE#

The vertical steps cross from a top pixel row at a cell's top. Each step size divides a cell, so the Skimmer always reaches an edge square on a cell. It enters the new screen square on a cell too, and keeps both its speeds.

---

## The flip

The flip turns the Skimmer over, or back the right way up. It starts at the end of a pass, when all of these hold. #TABLE(default)
{ =h Condition                       }
{ Flip is held                       }
{ No direction is held               }
{ The Skimmer rests square on a cell }
{ No flip runs already               }
{ No cell of its 3×3 hides it        }
TABLE#

The last condition reads the top-left 3×3 cells of the Skimmer's cover map. A cell with a bright graphic's mark, the bright graphic or bar mark, or a shot's marks hides the Skimmer. So the Skimmer cannot flip under a bar, or under a graphic that hides it. The cells of the bright graphics that the flipped Skimmer passes do not hide it. So it can flip back while it lies under one.

The flip shows the three flip frames in order, whichever way the Skimmer turns. Frame 1 shows for 3 passes, and frames 2 and 3 for 4 passes each. On the twelfth pass the flipped state changes, and the Skimmer draws with the images of its new state. The Skimmer takes no step through those twelve passes. The routine is `animate_flip`.

The flipped Skimmer differs in three things: its images, the marks that stop it, and its rates. The instruction leaflet says the flipped Skimmer is more vulnerable to attack. Besides the flip, which toggles it and picks the images, the readers of `flipped` found are the two block checks and `set_speed_rates`. So the code gives it no other difference.

---

## Pushes

A push throws the Skimmer about for a set number of passes. The passes left sit in `push_time`, and a new push starts the count again. #TABLE(default)
{ =h What starts the push           | =h Passes | =h Direction                     }
{ A shot enters a Skimmer cell      | 20        | The way the shot travels         }
{ The Skimmer steps into a shot     | 20        | Back the way it came             }
{ The Skimmer steps into a hit      | 20        | Back the way it came             }
{ A hostile object rams the Skimmer | 35        | The way the object travels       }
{ The Skimmer rams a hostile object | 35        | Back the way it came             }
{ A launch onto the Skimmer's cells | 35        | The new object's start direction }
TABLE#

A push from a shot or a hostile object sets the speed on the push's axis to 3 toward the push. A push from the Skimmer's own step comes from the block, which reverses the speed at its own size. The step rates change only at the next whole cell on that axis, as above.

While a push runs, the controls hold the direction of each axis the Skimmer moves on. So the Skimmer speeds up to 3 on each such axis, as it crosses whole cells. Over the last four passes of the push the controls hold nothing, and the Skimmer slows. The [Controls](input.md) page gives what the player loses. The indicator drains faster through the whole push, as the [Economy](economy.md) page gives.
