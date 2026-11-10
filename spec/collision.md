# Collisions

Every collision in the game is a test of the marks in the attribute mirror, one byte for each cell of the screen. Nothing compares positions or pixels. A mover reads the marks of the cells it is about to enter, and the marks decide what happens. The [Workspace page](../reference/workspace.html#attribute-mirror) gives each mark and what it stops.

---

## The marks the movers leave

Each mover marks the cells it covers on the play area. #TABLE(default)
{ =h Mover                | =h Mark in each cell it covers             }
{ The Skimmer             | The Skimmer's mark                         }
{ A hostile object        | The hostile object mark                    }
{ An object that explodes | The explosion mark                         }
{ A shot that shows       | The Skimmer's and the hostile object marks }
{ A hit                   | The Skimmer's and the hostile object marks }
TABLE#

A shot and a hit carry the same pair of marks, so every test treats them alike. A shot hidden under the bright graphic or bar mark leaves no mark.

---

## Who meets what

Each meet has one outcome, by the mover and what its cell holds. #TABLE(default)
{ =h Mover         | =h Meets                       | =h Result                                 }
{ The Skimmer      | A hostile object               | Turns back, and the cell becomes a hit    }
{ The Skimmer      | A shot or a hit                | Turns back, with a push of 20 passes      }
{ The Skimmer      | A graphic that stops it        | Turns back                                }
{ The Skimmer      | An object in its explosion     | Turns back                                }
{ A shot           | The Skimmer                    | The shot ends, with a push of 20 passes   }
{ A shot           | A hostile object               | The shot ends, with a hit and 20 points   }
{ A shot           | Any other mark that stops it   | The shot ends                             }
{ A shot           | The bright graphic or bar mark | Goes on, hidden                           }
{ A hostile object | The Skimmer                    | Explodes, with a push of 35 passes        }
{ A hostile object | A shot or a hit                | Explodes, and the player scores 20 points }
{ A hostile object | Another object or a graphic    | Turns back                                }
{ A hostile object | An object in its explosion     | Turns back                                }
TABLE#

The Skimmer that steps into a hostile object also gets a push of 35 passes, back the way it came. The object explodes at its next move, from the hit. The [Skimmer](skimmer.md#pushes) page gives the pushes, and the [Shots](shots.md) page what a cell does to a shot.

A hit marks a cell of a hostile object that a shot strikes, and `hit_count` counts the hits. At its next move, the object finds the hit cells under it and takes them off the count. It then explodes. So the object explodes within two passes of the hit, and the 20 points come with the hit.

A hostile object that runs into a shot or a hit takes both marks out of the cell. A shot it runs into flies on.

A launch onto a blocked cell meets it as a hostile object's move does, and launches nothing. So a launch can push the Skimmer in the new object's start direction, or score 20 points. A kept object that comes back onto a blocked cell in the hold meets it the same way. It then vanishes. The [Hostile objects](hostile-objects.md) page gives the launch and the hold.

The Skimmer's tests are `check_skimmer_column` and `check_skimmer_row`, and a shot's is `check_shot_cell`. A hostile object's are `check_hostile_block` and `hostile_collision`.

---

## Explosions

A hostile object explodes from a hit, or when its own move strikes the Skimmer, a shot or a hit. The explosion swaps its hostile object mark for the explosion mark. So it still blocks the Skimmer, shots and other objects. When the explosion ends, the object leaves the game and its cells lose the mark. The [Effects and sound](effects-sound.md#explosion) page gives the frames.

An explosion inside the hull destroys the sector's defence device, as the [Hostile objects](hostile-objects.md#the-defence-device) page gives.

---

## Defects

### A struck object escapes when another object runs into its hit

A hit waits in its cell for the move of its own object. If another hostile object runs into the cell first, that object explodes and scores 20 points. Its collision also clears the struck object's mark from the cell. So the struck object finds no hit at its move, and flies on. The routine at fault is `hostile_collision`.

Each move of the struck object then toggles its mark in the cell the wrong way round. Once it moves off the cell, its mark stays behind there until the next screen draw.

### A shot launched onto the Skimmer pushes it the wrong way

The hostile objects' shot can launch with the Skimmer in its first cell. The Skimmer then gets a push in a direction that `hostile_fire` never sets. The direction comes from the object's draw, and is always down, whichever way the object fires. The push reports a stop, so no shot launches.
