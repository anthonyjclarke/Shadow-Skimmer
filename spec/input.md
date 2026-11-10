# Controls

The game reads six controls once per pass of the play loop, at the end of the pass, and keeps them in `control_bits`. The speed changes of that pass use them at once. The fire test at the start of the next pass uses them too. The [Architecture](architecture.md#the-play-loop) page gives the order of the pass.

---

## The controls in force

The read gives one bit for each control, set while the control is held. The routine is `read_controls`. #TABLE(default)
{ =h Bit | =h Control | =h What it does                            }
{ 0      | Right      | Speeds the Skimmer up to the right         }
{ 1      | Left       | Speeds the Skimmer up to the left          }
{ 2      | Down       | Speeds the Skimmer up downward             }
{ 3      | Up         | Speeds the Skimmer up upward               }
{ 4      | Fire       | Fires a pulse laser shot, or opens a hatch }
{ 5      | Flip       | Turns the Skimmer over, or back            }
TABLE#

A direction changes the speed only while the Skimmer sits square on a cell along its axis. Two opposite directions held together count as neither. The [Skimmer](skimmer.md) page gives the speed rules, the flip and its conditions.

---

## Control methods

The title screen selects the control method, which `control_method` holds. The [Game flow](game-flow.md#the-title-screen-and-its-menu) page gives the menu keys.

Three sets of six keys sit at `control_keys`, one key per control. The keyboard reads the first set, the Sinclair joystick the second and the cursor joystick the third. #TABLE(default)
{ =h Control | =h Keyboard | =h Sinclair joystick | =h Cursor joystick }
{ Flip       | CAPS SHIFT  | CAPS SHIFT           | CAPS SHIFT         }
{ Fire       | 0           | 5                    | 0                  }
{ Up         | O           | 4                    | 7                  }
{ Down       | K           | 3                    | 6                  }
{ Left       | Z           | 1                    | 5                  }
{ Right      | X           | 2                    | 8                  }
TABLE#

The table holds the keys the game starts with. They are the keys the instruction leaflet gives. The read tests the six keys of the set one by one with `test_key`. So any number of them can count as held at once.

The Kempston joystick reads port $1F for right, left, down, up and fire. It takes flip from the keyboard's set, CAPS SHIFT until a redefinition.

### Redefined keys

The [Game flow](game-flow.md#the-redefine-keys-screen) page gives the redefine-keys screen. It accepts any of the 40 keys, the same key twice included.

The new keys replace the whole keyboard set. The new flip key also replaces the flip key of the Sinclair and the cursor joystick sets. So it serves the Kempston joystick too. The joysticks keep their other keys.

---

## Fire

Fire does one of two things, by the directions held with it. Both need the pulse laser shot to be out of flight, since `handle_fire` ignores fire while the shot flies. #TABLE(default)
{ =h Held with fire      | =h Result                              }
{ One direction alone    | A pulse laser shot that way, if it can }
{ No direction           | A hatchway trip, over a hatch          }
{ Two or more directions | Nothing                                }
TABLE#

The [Shots](shots.md) page gives the conditions for a pulse laser shot. A direction held with fire that fails them fires nothing, and starts no trip. The [Game flow](game-flow.md#the-hatchway-trip) page gives the conditions for a hatchway trip.

---

## When the controls count for nothing

Some states set aside part of the controls. #TABLE(default)
{ =h While                       | =h What the controls do                   }
{ A push runs                    | The game holds the directions it moves in }
{ The last four passes of a push | The game holds no control                 }
{ A shield loss is due           | Directions change no speed                }
{ The hatchway animation runs    | The Skimmer takes no step                 }
{ A flip runs                    | The Skimmer takes no step                 }
{ The pulse laser shot flies     | Fire does nothing                         }
TABLE#

During a push, the read gives the game's own controls in place of the player's. So fire and flip count as released. The [Skimmer](skimmer.md#pushes) page gives the push. In a shield loss, fire and flip still work.

Through the hatchway animation and the flip, the speeds still change with the directions held. The Skimmer then moves at those speeds once the animation ends.
