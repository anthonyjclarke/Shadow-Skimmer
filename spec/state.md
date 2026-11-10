# State

This page reads the game as a decision process. The step is one pass of the play loop, which waits for an interrupt. So the game runs at most 50 passes a second. The state is the RAM below, the actions are the six controls, and the reward is the score. The other pages give the rules each variable takes part in.

---

## Game state

These hold the game as a whole. #TABLE(default)
{ =h Address | =h Label             | =h Holds                   | =h Values                                    }
{ $BD3C      | `shields`            | Shields left               | 0–3                                          }
{ $BD3D      | `game_over`          | End of the game            | 0 for a game on, 1 for its end               }
{ $BD3E      | `inside_hull`        | Place of the Skimmer       | 1 for inside, 0 for the outer hull           }
{ $BD3F      | `sector`             | Sector of the Skimmer      | 1–3                                          }
{ $BD40      | `device_destroyed_1` | Sector 1 defence device    | 0 if it stands, $FF if destroyed             }
{ $BD41      | `device_destroyed_2` | Sector 2 defence device    | 0 if it stands, $FF if destroyed             }
{ $BD42      | `device_destroyed_3` | Sector 3 defence device    | 0 if it stands, $FF if destroyed             }
{ $BD24      | `control_method`     | Control method             | 0–3 for keyboard, Kempston, Sinclair, cursor }
{ $BC1F      | `control_keys`       | Keys of the three key sets | 8 bytes per set                              }
{ $BD43      | `hull_one_band`      | Bands of the hull pattern  | 1 for one band, 0 to repeat it               }
TABLE#

---

## The current screen

These hold the screen the Skimmer is on. #TABLE(default)
{ =h Address | =h Label             | =h Holds                         | =h Values                          }
{ $BD25      | `screen_column`      | Column on the hull map           | 0–9, from the left                 }
{ $BD26      | `screen_row`         | Row on the hull map              | 0–10, from the top                 }
{ $BD27      | `screen_number`      | Number of the screen             | 0–109, ten per row plus the column }
{ $BD28      | `launch_cells`       | Launch cells, 2 bytes each       | Column and direction, then row     }
{ $BD30      | `launch_cell_ptr`    | Next free launch cell            | Address in the launch cells        }
{ $BD33      | `launch_cell_count`  | Launch cells on the screen       | 0–3                                }
{ $D2C7      | `hatchway_cell`      | Hatchway's top-left cell         | Column, then row, both 0 for none  }
{ $C909      | `animation_list`     | Animated graphics, 13 bytes each | Room for two, $FF after the last   }
{ $C924      | `animation_list_end` | End byte of the list             | Address                            }
TABLE#

---

## The Skimmer and the play loop

These hold the Skimmer and the timers of the play loop. #TABLE(default)
{ =h Address | =h Label              | =h Holds                            | =h Values                             }
{ $D2B0      | `skimmer_scr_addr`    | Screen address of its top-left byte | Pixel row in the high byte's low bits }
{ $D2B2      | `skimmer_x_shift`     | Horizontal offset                   | 0–3, in steps of 2 pixels             }
{ $D2B6      | `skimmer_column`      | Column of its top-left cell         | 0–29                                  }
{ $D2B7      | `skimmer_row`         | Row of its top-left cell            | 6–21                                  }
{ $D2B8      | `skimmer_mirror_addr` | Its top-left cell in the mirror     | $FAC0–$FCBD                           }
{ $D2BA      | `old_mirror_addr`     | The same, before the latest step    | $FAC0–$FCBD                           }
{ $D2BC      | `old_skimmer_span`    | Columns, then rows, under it        | 3 or 4 each                           }
{ $D2B3      | `skimmer_stepped`     | Steps on the latest pass            | 0–2                                   }
{ $D2BE      | `screen_exit`         | Edge crossed on the pass            | 0 for none, 1–4 for left to bottom    }
{ $D2BF      | `speed_x`             | Horizontal speed                    | 3 for left to −3 for right            }
{ $D2C0      | `speed_x_step`        | Horizontal step                     | 1 or 2 steps of 2 pixels              }
{ $D2C1      | `speed_x_mask`        | Horizontal step mask                | 1 for every second pass, 0 for all    }
{ $D2C2      | `speed_x_phase`       | Horizontal step phase               | 0 to step, 1 to skip                  }
{ $D2C3      | `speed_y`             | Vertical speed                      | 3 for up to −3 for down               }
{ $D2C4      | `speed_y_step`        | Vertical step                       | 2 or 4 pixel rows                     }
{ $D2C5      | `speed_y_mask`        | Vertical step mask                  | 1 for every second pass, 0 for all    }
{ $D2C6      | `speed_y_phase`       | Vertical step phase                 | 0 to step, 1 to skip                  }
{ $D2D3      | `skimmer_moving`      | Movement flag                       | 0 for at rest square on a cell        }
{ $D2CB      | `push_time`           | Passes left in a push               | 0 for none, at most 35                }
{ $D2D1      | `flip_step`           | Frame of the flip                   | 1–3, 0 for no flip                    }
{ $D2D2      | `flipped`             | Way up                              | 1 for flipped, 0 for the right way    }
{ $D2CF      | `skimmer_image_set`   | Image entries in use                | Normal or flipped image entries       }
{ $D2C9      | `hatchway_step`       | Hatchway animation step             | 0 for none, others below              }
{ $D2CA      | `anim_divider`        | Pass count of hatch or flip         | Low two bits                          }
{ $D2D4      | `shield_loss_step`    | Stage of a shield loss              | 0–7, 0 for none                       }
{ $D2D5      | `shield_loss_ticks`   | Pass count of shield losses         | 0–255                                 }
{ $D48D      | `shield_loss_due`     | Shield loss due                     | 1 for due, 0 for none                 }
{ $D2B4      | `control_bits`        | Controls in force                   | One bit per control                   }
{ $D2AF      | `interrupt_flag`      | Interrupt not yet taken             | $FF for one, 0 for none               }
{ $D2B5      | `speaker_byte`        | Byte for the speaker clicks         | Speaker bit flips per click           }
TABLE#

The Skimmer's pixel position follows from its column, offset and screen address, as the [Skimmer](skimmer.md#position) page gives.

### Hatchway steps

The step's high four bits name the phase, and its low four bits the step. #TABLE(default)
{ =h Step | =h Phase                                     }
{ 0       | None                                         }
{ $01–$0D | The hatch opens under the Skimmer            }
{ $11–$1D | The hatch closes under the Skimmer           }
{ $21–$2D | The hatch opens over the Skimmer             }
{ $31–$3D | The hatch closes over the Skimmer            }
{ $EE     | The Skimmer starts to leave an inner section }
TABLE#

---

## Shots

These hold the shots and their clicks. #TABLE(default)
{ =h Address | =h Label           | =h Holds                      | =h Values                        }
{ $C928      | `pulse_laser_shot` | The pulse laser shot          | 14 bytes, below                  }
{ $C936      | `hostile_shot`     | The hostile objects' shot     | 14 bytes, below                  }
{ $C927      | `shot_range`       | Range of the shot that moves  | 0–30 cells, or 255 from a defect }
{ $C944      | `current_shot`     | The shot that moves           | Address of its record            }
{ $D2CD      | `shot_click_row`   | First pixel row of the clicks | 0 for all, $FE or $FF for none   }
{ $D2CE      | `shot_click_time`  | Passes left in the clicks     | 0–2                              }
TABLE#

Both shots take the same 14 bytes. #TABLE(default)
{ =h Byte | =h Holds                             | =h Values                       }
{ 0       | Direction                            | 0–3 for left, right, up or down }
{ 1       | Range left                           | Cells                           }
{ 2–3     | Attribute mirror address of its cell | $FAC0–$FCFF                     }
{ 4       | Colour of the cell under it          | Attribute                       }
{ 5–12    | Pixel rows of the cell under it      | From the top                    }
{ 13      | Unused                               |                                 }
TABLE#

The direction byte holds $FF while the shot is out of flight. The hostile objects' shot adds 4 to its direction, 4–7 for left, right, up or down. A new shot holds bit 7 of the direction set until its first move.

---

## Hostile objects

These hold the hostile objects and their moves. #TABLE(default)
{ =h Address | =h Label             | =h Holds                         | =h Values                      }
{ $F800      | `hostile_slots`      | The four hostile object slots    | 80 bytes per slot, below       }
{ $C0AC      | `hostile_image_bufs` | Image buffer of each slot        | Addresses from $5B00           }
{ $C947      | `hostile_screen_pos` | Record of the object that moves  | 16 bytes, below                }
{ $C95D      | `hostile_slot`       | Slot of the object that moves    | Address of the slot            }
{ $C958      | `hostile_tick`       | Count of the moves               | 0–255, even for the first pair }
{ $C946      | `hostiles_counted`   | The pair's objects of the screen | 0–4                            }
{ $C962      | `hostiles_removed`   | Objects removed in the call      | 0–2                            }
{ $C961      | `new_hostile_slot`   | New object's slot in its pair    | 0 or 1                         }
{ $C957      | `hostile_moved`      | Step in the latest move          | 1 for a step, 0 for none       }
{ $C95C      | `hostile_turned`     | Turn in the latest move          | 1 for a turn, 0 for none       }
{ $C95B      | `hit_count`          | Hit cells that wait              | 0–255                          }
{ $D2CC      | `hostile_hold_time`  | Hold on a new screen             | $FE or $FF in a hold, else 0   }
{ $C95F      | `preshift_pos`       | Image build position             | Address in an image buffer     }
TABLE#

The slots lie at $F800 and $F850, which move on even counts, and at $F900 and $F950, which move on odd counts. Each slot takes 80 bytes. #TABLE(default)
{ =h Offset | =h Holds                                   }
{ $00–$08   | Cover map, one byte per cell of its 3×3    }
{ $09–$38   | Background store, 16 pixel rows of 3 bytes }
{ $39–$48   | The object's record                        }
{ $49–$4F   | Unused: nothing found reads them           }
TABLE#

The record is the 16 bytes that each move copies to the current hostile object at $C947. #TABLE(default)
{ =h Byte | =h Label               | =h Holds                        | =h Values                      }
{ 0–1     | `hostile_screen_pos`   | Screen address of its top row   | Pixel row in the high byte     }
{ 2       | `hostile_pixel_offset` | Offset in its column            | 0–3, in steps of 2 pixels      }
{ 3       | `hostile_column`       | Column of its left cell         | −2 to 32                       }
{ 4       | `hostile_row`          | Row of its top cell             | 4–24                           }
{ 5–6     | `hostile_attr_pos`     | Its top-left cell in the mirror | Address                        }
{ 7       | `hostile_state`        | State                           | Below                          }
{ 8–9     | `hostile_cover_ptr`    | Its cover map                   | The slot's first byte          }
{ 10–11   | `hostile_bg_ptr`       | Its background store            | The slot's tenth byte          }
{ 12–13   | `hostile_image_ptr`    | Its shifted images              | Its buffer, or a device design }
{ 14      | `hostile_steer_count`  | Whole cells to its next steer   | Cells                          }
{ 15      | `hostile_screen_num`   | Its screen                      | 0–109                          }
TABLE#

The state takes these values. #TABLE(default)
{ =h State | =h The object                       }
{ 0–3      | Moves up, down, left or right       }
{ $17      | Is the defence device               }
{ $80–$86  | Shows explosion frame 1–7           }
{ $FE      | Is no object: the slot is empty     }
{ $FF      | Is struck, and explodes at its move }
TABLE#

A struck object that turns back in its move takes $FE for that move alone, and explodes in it. The defence device holds 23 in its count of cells too.

---

## Score and the Damage Report Indicator

These hold the readouts. #TABLE(default)
{ =h Address | =h Label         | =h Holds                         | =h Values                 }
{ $D47F      | `damage_digits`  | Damage Report Indicator          | 0–999, three digits       }
{ $D482      | `score_digits`   | Score                            | Six digits                }
{ $D48A      | `points_due`     | Points still to count in         | Eighths of a point        }
{ $D488      | `step_count`     | Score steps left                 | 0–65,535                  }
{ $D479      | `score_step`     | Size of a score step, six digits | An eighth to 4 points     }
{ $D48C      | `step_doublings` | Doublings of the score step      | 0–5                       }
{ $D473      | `slow_drain`     | Drain with no push               | An eighth of a unit       }
{ $D476      | `fast_drain`     | Drain in a push                  | Three units and an eighth }
TABLE#

A digit takes one byte: eight times its value, plus its eighths on the way to the next value, 0–79.

---

## Screen draw

These hold the work of the screen draw, and change only while a screen draws. #TABLE(default)
{ =h Address | =h Label                 | =h Holds                                | =h Values                                 }
{ $BD11      | `graphic_attr_addr`      | Attribute address of the latest graphic | Address                                   }
{ $BD13      | `pattern_mirror_addr_lo` | Mirror address of a pattern, low byte   | Low byte of an address                    }
{ $BD14      | `pattern_mirror_addr_hi` | Mirror address of a pattern, high byte  | High byte of an address                   }
{ $BD15      | `draw_attr`              | Attribute of the draw                   | Attribute, or $80 to keep the colours     }
{ $BD16      | `plot_width`             | Width in cells of the graphic           | Cells                                     }
{ $BD17      | `layout_column`          | Column of the layout graphic            | 0–31                                      }
{ $BD18      | `layout_flags`           | Flags of the layout record              | 0–7, with 4–7 for a run                   }
{ $BD19      | `layout_row`             | Row of the layout graphic               | 6–23                                      }
{ $BD1A      | `graphic_width`          | Width in cells of the latest graphic    | Cells                                     }
{ $BD1B      | `graphic_height`         | Height in cells of the latest graphic   | Cells                                     }
{ $BD1C      | `run_cells_left`         | Cells to the end of a run               | Cells                                     }
{ $BD1D      | `prev_layout_cell`       | Cell of the graphic before              | Column, then row                          }
{ $BD1F      | `prev_layout_graphic`    | Number of the graphic before            | Graphic number                            }
{ $BD20      | `layout_graphic`         | Number of the layout graphic            | Graphic number                            }
{ $BD21      | `graphic_pixel_addr_lo`  | Screen address of a graphic, low byte   | Low byte of an address                    }
{ $BD22      | `graphic_pixel_addr_hi`  | Screen address of a graphic, high byte  | High byte of an address                   }
{ $BD23      | `mirror_mark`            | Mark the graphic sets                   | 0 for none, 1 for cell masks, 2 for a bar }
{ $BD32      | `colour_pattern`         | Colour pattern of the latest graphic    | Twice its number, 0 for one colour        }
{ $BD34      | `skip_shadow`            | Shadow switch                           | 0 for own shadows, any other for none     }
{ $BD35      | `run_length`             | Length of a run in cells                | Cells                                     }
TABLE#

---

## Workspace

These regions lie above the program image. The [Workspace page](../reference/workspace.html) defines each one and every mark. #TABLE(default)
{ =h Address | =h Name             | =h Holds                             | =h Values                           }
{ $FA00      | `attr_mirror`       | The marks of each cell of the screen | $FA00–$FCFF, one byte per cell      }
{ $FDFD      | `int_jump`          | Jump to the interrupt routine in use | A jump instruction, 3 bytes         }
{ $FE00      | `int_vectors`       | Interrupt vectors                    | 257 bytes, each $FD                 }
{ $FF10      | `skimmer_bg_store`  | Screen bytes behind the Skimmer      | $FF10–$FF6F, 24 rows of 4 bytes     }
{ $FF70      | `skimmer_cover_map` | Cells that hide the Skimmer, 4×4     | $FF70–$FF7F, $FF to hide, 0 to show }
TABLE#

---

## Actions

An action is the set of controls held, six bits, which the [Controls](input.md) page gives. The controls come in at the end of a pass. The speed changes and the start of a flip use them in that pass. The fire test uses them at the start of the next. A push replaces them with the game's own, and its last four passes hold none.

---

## Dynamics

The [Architecture](architecture.md#the-play-loop) page gives the order of a pass, and the steps that cut it short. Hostile objects move 2 pixels on every second pass, and shots one cell per pass. The other pages give each rule.

The calls of `random_below` found pick the launch cell and the design of a new hostile object. Each takes the remainder of the Z80's refresh register by the number of choices. The [Hostile objects](hostile-objects.md#launch) page gives the launch.

---

## Reward and the end of an episode

The reward is the score. Every award is 20 points, as the [Score](score.md) page gives. The score digits lag the award, since `points_due` and `step_count` hold what is still to count in. The [Economy](economy.md) page gives the indicator and the shields. #TABLE(default)
{ =h Event    | =h Trigger                           | =h Result            }
{ Shield loss | The indicator drops under zero       | One shield fewer     }
{ GAME OVER   | The loss of the last shield          | The game returns 1   }
{ WALL DONE   | The inner section at column 5, row 0 | The game returns $5E }
TABLE#

Each end returns to the title screen, and a new game needs the start key. The [Game flow](game-flow.md) page gives the ends, and the start of a game with its state.
