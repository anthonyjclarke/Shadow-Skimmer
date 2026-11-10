# Game flow

The states the game passes through, and what starts and ends each one. How long each hold lasts. The [Architecture](architecture.md) page shows the loops that run them.

---

## The states

Each state ends on one event, and leads to the next. #TABLE(default)
{ =h State      | =h Ends when                             | =h Next state            }
{ Title screen  | The player presses a menu key            | Redefine keys, or a game }
{ Redefine keys | The sixth key is taken                   | Title screen             }
{ Play          | The last shield goes                     | GAME OVER                }
{ Play          | The Skimmer reaches the WALL DONE screen | WALL DONE                }
{ Hatchway trip | The hatch closes behind the Skimmer      | Play, on the other side  }
{ Shield loss   | Its eighth stage takes a shield          | Play, or GAME OVER       }
{ GAME OVER     | About 6 seconds pass                     | Title screen             }
{ WALL DONE     | A little over 9 seconds pass             | Title screen             }
TABLE#

---

## The title screen and its menu

The title screen starts at `show_title`, which clears the screen to white ink on black paper and prints `msg_title`. A bar then lies over the line of the selected control method, from `toggle_method_bar`. It swaps yellow and black in each of the line's 21 cells. The keyboard is the selected method when the game loads, and a choice holds for every later game.

The title tune then plays with interrupts off until a key is pressed, at `menu_tune`. The game takes that key, and looks it up among `menu_keys`. #TABLE(default)
{ =h Key | =h Option         | =h Result                                    }
{ 1      | KEYBOARD          | Selects the method, and the tune plays again }
{ 2      | KEMPSTON JOYSTICK | Selects the method, and the tune plays again }
{ 3      | SINCLAIR JOYSTICK | Selects the method, and the tune plays again }
{ 4      | CURSOR JOYSTICK   | Selects the method, and the tune plays again }
{ 5      | REDEFINE KEYS     | The redefine-keys screen                     }
{ 0      | START GAME        | A game starts                                }
TABLE#

Any other key restarts the tune and changes nothing. Each play of the tune starts from its introduction, as the [Sound page](../reference/sound.html#title-tune) shows. The [Controls](input.md) page covers the keys and ports of each method.

---

## The redefine-keys screen

The screen clears, and `redefine_keys` prints `msg_redefine`. It asks for six controls in turn: up, down, left, right, fire and flip. For each, it prints the control's name into the prompt. It waits until no key is held, then for one key alone.

The screen then shows the key's name for about 0.3 s, and hides it before it asks for the next control. After the sixth key, the title screen returns. The [Controls](input.md) page says which sets of keys the new keys replace.

BUG: the key names at `key_names` give E for the F key. So a control defined on F shows as E. The key works as F.

---

## The start of a game

The shields stand at 3 from `new_game` on. When the player starts a game, `start_game` sets up the panel and the hull, and `play_game` the Skimmer. #TABLE(default)
{ =h Order | =h What it sets up                          }
{ 1        | Pixels of rows 1–4 blank, but edge columns  }
{ 2        | The control panel and the shield count draw }
{ 3        | Screen 1: map column 1, row 0               }
{ 4        | All three defence devices stand             }
{ 5        | The Damage Report Indicator fills to 999    }
{ 6        | The score goes to zero                      }
{ 7        | The Skimmer flies the right way up, at rest }
{ 8        | The Skimmer sits square on its cell         }
{ 9        | No push and no shot clicks run              }
{ 10       | The four hostile object slots empty         }
{ 11       | The Skimmer takes column 21, row 18         }
TABLE#

Each game starts its score from zero at `reset_score`. The title screen shows no score.

---

## A new screen

Every screen starts at `enter_screen`: at the start of a game, after the Skimmer crosses an edge, and after a hatchway trip. The trip out of an inner section enters at `enter_screen_hatchway`, with its animation under way. Every other entry clears the hatchway animation first. #TABLE(default)
{ =h Order | =h What happens                             }
{ 1        | Each interrupt updates the readouts         }
{ 2        | The animation list empties                  }
{ 3        | Both shots go                               }
{ 4        | Hatchway cell, launch cells and hits clear  }
{ 5        | The game cancels a shield loss, due or begun }
{ 6        | The sector is set, and its digit prints     }
{ 7        | The play area takes its surface and colours }
{ 8        | The play area's marks clear                 }
{ 9        | The device picture and the layout draw      }
{ 10       | The WALL DONE screen ends the game here     }
{ 11       | The interrupts go back to the flag alone    }
{ 12       | The Skimmer saves its background            }
{ 13       | The Skimmer maps its cover, draws and marks }
{ 14       | The hostile objects' hold starts            }
TABLE#

The cancel at order 5 does not refill the Damage Report Indicator. The indicator stays at zero, and its next drain takes it below zero. So the loss falls due again, from its first stage. The [Economy](economy.md) page covers the drain.

The [hull](hull.md) page covers the sectors and the layouts. The [Hostile objects](hostile-objects.md) page covers the hold.

### Edge crossings

A step across an edge of the screen flags an exit, and `check_screen_exit` acts on it. The Skimmer keeps its place along the edge. #TABLE(default)
{ =h Edge | =h Next screen on the hull map | =h The Skimmer's new column | =h The Skimmer's new row }
{ Left    | One column left                | 29                          | As it was                }
{ Right   | One column right               | 0                           | As it was                }
{ Top     | One row up                     | As it was                   | 21                       }
{ Bottom  | One row down                   | As it was                   | 6                        }
TABLE#

At an edge of the hull map no screen lies beyond, and the Skimmer stays at the edge of its screen. The inner sections join up through the same map. The [Skimmer](skimmer.md) page covers how a step reaches an edge.

---

## The hatchway trip

Fire starts a trip through a hatchway only while the Skimmer rests over the hatch. Its top-left cell must lie one column and one row inside the hatchway's top-left cell, so it covers the hatch. It must rest square on its cell, with no speed and no direction held. No pulse laser shot may be in flight, and no hatchway animation may run. The fire key's routine, `handle_fire`, checks each of these. The [Controls](input.md) page covers fire's other use, the pulse laser shot.

The animation runs in two phases of 13 steps, one step on every fourth pass, in `animate_hatchway`. The trip in runs its first step on the pass that fire starts it. The trip out first enters the outer hull's screen, and runs its first step on the next pass. So the 26 steps of a trip take 101 passes. Through the whole trip the Skimmer holds its place, and the other tasks of each pass go on. #TABLE(default)
{ =h Trip | =h Phase                           | =h Then                                      }
{ In      | The hatch opens under the Skimmer  | The next phase                               }
{ In      | The hatch closes over the Skimmer  | A pause of about 0.3 s, and the inner screen }
{ Out     | The hatch opens over the Skimmer   | The next phase                               }
{ Out     | The hatch closes under the Skimmer | Play resumes                                 }
TABLE#

The trip in enters the inner section's screen with the same number, and the Skimmer keeps its cell. The trip out enters the outer hull's screen with the same number, and its first phase starts on that screen. Both trips empty the four hostile object slots first. The [graphics engine](graphics.md#the-hatch-animation) page shows how the hatch draws.

---

## Shield loss

When the Damage Report Indicator drops below zero, a shield loss falls due. While it is due, the Skimmer slows on each axis as it comes square on the grid, until it rests. The [Economy](economy.md) page gives the drain and the eight stages of the loss.

At the eighth stage, `lose_shield` takes a shield and refills the indicator to 999. With shields left, it draws the Skimmer whole again and blinks the shield count four times. Each blink shows the count for about 0.3 s and hides it for about 0.3 s. The game holds for those 2.4 s or so.

When the loss takes the last shield, the game ends, and the shield count shows 0. The game loop then returns, and GAME OVER follows.

---

## GAME OVER

The main loop prints `msg_game_over` over the play area, at row 12. It holds the message for 20 pauses, about 6 seconds at the 3.5 MHz clock. Through this hold the interrupts only raise the flag, so the readouts stand still. A new game is then set up, and the title screen returns.

---

## WALL DONE: the win

The WALL DONE screen is inner screen 5, at column 5, row 0 of the hull map. A hatchway on outer screen 5 leads to it. That screen lies in sector 3, where the leaflet puts the entry-way to the mothership.

The screen draw, `draw_screen`, draws no layout there. It ends the game and prints `msg_wall_done`, which reads "WALL DONE", "CAPTAIN BLATT" and "YOUR MISSION IS OVER". It holds the message for 30 pauses, a little over 9 seconds at the 3.5 MHz clock.

The readouts interrupt is still in use through this hold, since the screen draw still runs. So points still count into the score, and the indicator still drains. The game loop then returns, and the title screen follows with no GAME OVER.
