# Architecture

How the program starts and which loop runs when. What one pass of the play loop does, and which routines make up each part of the game.

---

## Start-up

The BASIC loader runs the game at `game_entry`, which jumps through `boot` to `main_loop`. The main loop sets the stack to grow down from $F7F8, just below the hostile object slots at `hostile_slots`. It then calls `init_interrupts` once, makes the pixel clear write blank bytes, and turns the border black and the speaker off. Nothing after that returns to the start-up code.

The program image runs from $61A8 to $F9FF. The stack and `hostile_slots` sit at its top end. Above $FA00 lies the workspace: the attribute mirror, the interrupt jump and vectors, and the Skimmer's background store and cover map. The [Workspace page](../reference/workspace.html) defines each region.

---

## The main loop

`main_loop` cycles through four states. [Game flow](game-flow.md) says what each state shows, what ends it and how long it holds. #TABLE(default)
{ =h State      | =h Routine       | =h Leads to                           }
{ Title screen  | `show_title`     | Redefine keys, or a game              }
{ Redefine keys | `redefine_keys`  | Title screen                          }
{ Game          | `play_game`      | GAME OVER, or a new game at WALL DONE }
{ GAME OVER     | `hold_game_over` | Title screen, with a new game set up  }
TABLE#

A new game starts at `new_game`, which refills the shields, clears the end of the game and puts the Skimmer on the outer hull. The title screen follows at once. So every return to the title screen comes with a fresh game set up behind it.

---

## The interrupts

The game takes its interrupts through a table of vectors, set up by `init_interrupts`. Each vector holds $FD, so whatever byte the data bus holds, an interrupt reaches the interrupt jump at $FDFD. That jump leads to one of two routines. #TABLE(default)
{ =h Routine           | =h What it does                       | =h In use                           }
{ `flag_interrupt`     | Raises `interrupt_flag`               | Everywhere else                     }
{ `readouts_interrupt` | Runs `update_readouts`, then the flag | While `enter_screen` draws a screen }
TABLE#

The play loop waits for `interrupt_flag` and clears it. So it runs at most one pass for each 50 Hz interrupt. A pass that takes longer than one interrupt period starts the next pass at once, and the interrupts that fall within it count as one. The game therefore runs at 50 passes per second or fewer. Every timer in the spec counts passes, and a time in seconds assumes one pass per interrupt.

The title tune plays with interrupts off (`play_title_tune`). The busy wait of `pause`, about 0.3 s at the 3.5 MHz clock, leaves them on. So a pause lasts longer by the time the interrupt routine takes.

---

## The play loop

A game starts in `play_game`, which sets it up and then enters a screen at `enter_screen`. The [Game flow](game-flow.md#a-new-screen) page lists what a screen entry does. Play then runs in `play_loop`, one pass at a time, in this order. #TABLE(default)
{ =h Step | =h What runs                                  | =h Routine             }
{ 1       | Wait for the interrupt flag, and clear it     | `wait_interrupt`       }
{ 2       | Fire or start a trip, and move the shots      | `handle_fire`          }
{ 3       | Advance a shield loss that is due             | `lose_shield`          }
{ 4       | Run a step of the hatchway animation          | `animate_hatchway`     }
{ 5       | Run a step of the flip                        | `animate_flip`         }
{ 6       | Step the Skimmer: vertical, then horizontal   | `step_skimmer`         }
{ 7       | Leave the screen across an edge               | `check_screen_exit`    }
{ 8       | Draw the Skimmer, and move its mark           | `show_skimmer`         }
{ 9       | Count down the clicks of a shot               | `play_loop_update`     }
{ 10      | Move the hostile objects of one pair of slots | `move_hostile_objects` }
{ 11      | Step the animated graphics                    | `step_animations`      }
{ 12      | Drain the indicator and count in the score    | `update_readouts`      }
{ 13      | Read controls, set speeds, start a flip       | `read_controls`        }
TABLE#

Several steps cut the pass short. Step 3 runs only while the Skimmer sits square on the cell grid. With a loss due and the Skimmer off the grid, the pass goes straight to step 6. So the Skimmer can reach a cell first. When step 3 takes the last shield, the game ends at once.

While the hatchway animation runs, step 4 replaces steps 5 to 8, and the Skimmer holds its place. A flip in progress replaces steps 6 and 7. A screen exit at step 7 leaves the pass and enters the new screen. Every pass that stays on its screen runs steps 9 to 13, the passes of the hatchway animation included.

Steps 13 and 2 split the controls between two passes. Step 13 reads them into `control_bits`, and the next pass's step 2 acts on fire. The [Controls](input.md) page covers what each control does.

---

## The module map

Each part of the game, its main routines, and the page of the spec that describes it. #TABLE(default)
{ =h Part                    | =h Main routines                         | =h Spec page                          }
{ Start-up and main loop     | `main_loop`, `init_interrupts`           | This page                             }
{ Play loop and screen entry | `play_game`, `enter_screen`              | [Game flow](game-flow.md)             }
{ Hull map and layouts       | `draw_screen`, `draw_layout_graphic`     | [The hull](hull.md)                   }
{ Graphics and shadows       | `draw_graphic`, `cast_shadow`            | [The graphics engine](graphics.md)    }
{ The Skimmer                | `move_skimmer_left`, `set_speed_rates`   | [The Skimmer](skimmer.md)             }
{ Controls                   | `read_controls`, `scan_keyboard`         | [Controls](input.md)                  }
{ Hostile objects            | `move_hostile_objects`, `update_hostile` | [Hostile objects](hostile-objects.md) }
{ Shots                      | `handle_fire`, `move_shots`              | [Shots](shots.md)                     }
{ Collisions                 | `check_shot_cell`, `hostile_collision`   | [Collisions](collision.md)            }
{ Shields and damage         | `update_readouts`, `lose_shield`         | [Economy](economy.md)                 }
{ Score                      | `add_points`, `add_score_digits`         | [Score](score.md)                     }
{ Animations and sound       | `explode_hostile`, `step_animations`     | [Effects and sound](effects-sound.md) }
{ Control panel              | `draw_control_panel`, `print_readout`    | [Control panel](control-panel.md)               }
{ Game state                 | `shields`, `interrupt_flag`              | [State](state.md)                     }
TABLE#

The title tune player has a listing of its own, the [title tune player](../tune/index.html). The program image holds its bytes encrypted, and `run_title_tune` decrypts them before each play.
