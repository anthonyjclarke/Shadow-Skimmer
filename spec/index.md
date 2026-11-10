# Behaviour specification

How Shadow Skimmer behaves, part by part, in numbers the code fixes. Each page gathers facts that lie spread across many routines of the disassembly, and names those routines and variables by their labels. A label in the HTML pages links to its place in the listing.

The disassembly is the source of truth. The control file `src/shadskim.ctl` rebuilds the game byte for byte, and where a page here and the listing differ, the listing holds.

---

## The pages

Each page covers one part of the game. #TABLE(default)
{ =h Page                               | =h What it covers                           }
{ [Architecture](architecture.md)       | Start-up, main loop, interrupts, the pass   }
{ [Game flow](game-flow.md)             | Title, screens, hatchway trips, game end    }
{ [The hull](hull.md)                   | Map, sectors, layouts, hatchways, devices   }
{ [The graphics engine](graphics.md)    | Graphics, marks, shadows, bars, the Skimmer }
{ [Control panel](control-panel.md)               | The readouts and how they roll              }
{ [The Skimmer](skimmer.md)             | Speeds, steps, the flip, blocks, pushes     }
{ [Controls](input.md)                  | Keys, joysticks and what each control does  }
{ [Hostile objects](hostile-objects.md) | Slots, launches, moves and fire             }
{ [Shots](shots.md)                     | Both shots: range, motion, what stops them  }
{ [Collisions](collision.md)            | Every meet of two things, and what follows  }
{ [Economy](economy.md)                 | Shields, the indicator, shield loss         }
{ [Score](score.md)                     | Every award, and how points count in        }
{ [Effects and sound](effects-sound.md) | Explosions, animations and sounds           }
{ [State](state.md)                     | Variables, actions, rewards and game ends   }
TABLE#


---

## Units and words

The pages count time in passes of the play loop. The game runs at most one pass for each 50 Hz interrupt. So a pass lasts 20 ms or more, and the [Architecture](architecture.md#the-interrupts) page says why it can last longer. A time in seconds assumes the 3.5 MHz clock and one pass per interrupt.

A cell is a character cell of 8×8 pixels. Columns run 0–31 from the left and character rows 0–23 from the top. The play area is rows 6–23, below the control panel.

The pages use the game's own words, and the project's words where the game has none. The [Glossary](../reference/glossary.html) lists them, with the words that never name the same things.
