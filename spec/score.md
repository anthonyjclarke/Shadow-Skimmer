# Score

The score is a six-digit count of points that starts from zero in each game. Every award is 20 points, and the control panel counts each award in a step at a time. The title screen shows no high score.

---

## Awards

An award goes onto `points_due`, in eighths of a point, through `add_points`. The awards come from `score_shot_hit` and `hostile_collision`, 20 points each. #TABLE(default)
{ =h Event                                   | =h Points }
{ A shot strikes a hostile object            | 20        }
{ A hostile object runs into a shot or a hit | 20        }
{ A launch lands on a shot or a hit          | 20        }
{ The Skimmer rams a hostile object          | 0         }
{ A hostile object explodes                  | 0         }
{ A hostile object rams the Skimmer          | 0         }
TABLE#

Either shot scores. The hostile objects' shot that strikes a hostile object scores the player 20 points, as the pulse laser shot does. The defence device scores 20 points for the shot that strikes it, and nothing more for its destruction. The [Collisions](collision.md) page gives each event.

The game has no bonus, and no score earns anything. The end of the game on the WALL DONE screen adds no points.

---

## The count-in

The readout update counts the points due into the score, one step per call, and prints the score. The routine is `update_readouts`, and the [Economy](economy.md#the-damage-report-indicator) page gives when it runs.

The steps left sit in `step_count`, and the size of a step in `score_step`. The times the step doubled from one eighth of a point sit in `step_doublings`.

Each call first looks at the steps left. With none left, the step goes back to one eighth of a point, and the call adds nothing to the score. Otherwise the call adds one step to the score. Before it does, an even count of 256 steps or more halves, and the step doubles, while the step is under four points. Last, the call moves the points due into the count, as whole steps of the current size. Points due that make no whole step wait for the next call.

So one award of 20 points takes 161 calls: one to move it into the count, then 160 steps of an eighth. That is a little over three seconds at one pass per 50 Hz interrupt. Two awards that wait together make 320 steps. So the step doubles once, and they count in at a quarter of a point per call.

The score's digits count in eighths, as the indicator's do. A carry out of the first digit is lost. So the score passes 999,999 back to zero. The [Control panel](control-panel.md) page gives where the score shows, and how its digits roll.
