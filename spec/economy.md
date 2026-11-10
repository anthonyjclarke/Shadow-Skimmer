# Economy

The Skimmer starts a game with 3 shields, which `shields` counts. The Damage Report Indicator runs down all the time, and faster while a push runs. When it runs out, a shield loss follows, and the indicator fills again. The loss of the last shield ends the game. The writers found of the shield count are the start of a game and `lose_shield`, so no event adds a shield.

The instruction leaflet says shields go after several hits. In the code, a hit costs the indicator only through the push it starts. Time alone also empties it. The [Control panel](control-panel.md) page gives where the count and the indicator show.

---

## The Damage Report Indicator

The indicator sits in `damage_digits`, as three decimal digits, 0–999. Each digit counts in eighths. So the indicator moves in eighths of a unit. It fills to 999 at the start of a game and at the end of each shield loss, through `fill_damage_report`.

The readout update drains it once on each call. The play loop calls it once per pass. While a screen draws, the interrupt calls it once per interrupt. The routine is `update_readouts`. #TABLE(default)
{ =h While     | =h Drain per call          | =h Drain     }
{ No push runs | One eighth of a unit       | `slow_drain` }
{ A push runs  | Three units and one eighth | `fast_drain` }
TABLE#

The slow drain takes a full indicator to under zero in 7,993 calls. That is about 160 seconds, at one pass of the play loop per 50 Hz interrupt.

### The fast drain falls short

A digit that drops under 0 lands one eighth short of 10, however far under 0 it goes. So a drain of more than one eighth falls short whenever the last digit rolls back. The routine is `subtract_damage_digits`.

Under the fast drain, after the last digit's first roll back, each four calls take exactly 10 units. Three take three units and an eighth, and the fourth takes what the roll leaves. So a full indicator lasts 399 calls under a push, where full drains would last 320. A push of 20 passes costs about 50 units, and one of 35 passes about 87 or 89, by where the last digit's roll stands.

---

## A shield loss

The indicator runs out when a drain would take it under zero. The update then holds it at 000 and sets `shield_loss_due`. The indicator stays at 000 until the loss ends.

While the loss is due, the Skimmer slows as if no control were held. It comes to rest on a cell, as the [Skimmer](skimmer.md#when-the-speed-changes) page gives. The loss moves on only in passes that start with the Skimmer square on a cell on both axes.

Those passes count up in `shield_loss_ticks`, and the loss moves on one stage every fourth pass. With one shield left it moves on every eighth pass. The count runs on from one loss to the next. So the first stage comes within 4 passes, or 8. The stage sits in `shield_loss_step`, and the routine is `lose_shield`. #TABLE(default)
{ =h Stage | =h What happens                          }
{ 1–7      | The Skimmer draws in a shield loss frame }
{ 8        | The loss ends                            }
TABLE#

So a loss takes 29–32 of those passes, or 57–64 with the last shield. The [Effects and sound](effects-sound.md#shield-loss) page gives the frames.

At the end of the loss, the indicator fills to 999 and the Skimmer loses a shield. The [Game flow](game-flow.md#shield-loss) page gives the blink of the shield count that follows. A move to another screen during a loss starts it again from its first stage, as the [Game flow](game-flow.md#a-new-screen) page gives.

---

## Game over

The loss of the last shield sets `game_over`, shows 0 shields, and ends the game. The [Game flow](game-flow.md#game-over) page gives GAME OVER, and the WALL DONE screen, which ends the game the other way.
