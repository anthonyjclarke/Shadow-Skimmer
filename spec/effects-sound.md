# Effects and sound

The game's animations run on passes of the play loop. Its sounds in play are clicks of the speaker from the code that draws. The [Graphics page](../reference/graphics.html) shows each frame, and the [Sound page](../reference/sound.html) plays each sound.

---

## Explosion

A hostile object explodes in 7 frames, one per move of its pair. So each frame shows for two passes, and the frames take 14 passes in all. The move that starts the explosion shows frame 1, and the next six moves show frames 2–7. The eighth move ends the explosion, and the object leaves the game. The routines are `explode_hostile` and `finish_explosion`.

Each frame paints the object's cells on the play area bright yellow ink on black paper. It then draws the frame through an explosion mask. The end paints the cells white ink on black paper, and puts back the background behind the object. Cells that hide the object keep their colours and pixels throughout. The [Graphics page](../reference/graphics.html#explosion) shows the frames.

---

## Flip

The [Skimmer](skimmer.md#the-flip) page gives the flip, its conditions and how long it lasts. The [Graphics page](../reference/graphics.html#flip) shows its frames.

---

## Shield loss

Each stage of a shield loss draws the Skimmer in a shield loss frame, through `draw_skimmer`. The [Economy](economy.md#a-shield-loss) page gives the stages and how long each lasts.

A defect in the draw skips the first frame, so each stage draws the frame after its own number. Stage 1 draws frame 2, and stage 7 draws frame 8. So frame 1 never shows. The [Graphics page](../reference/graphics.html#shield-loss) shows the frames the game draws.

---

## The animated graphic

A screen's layout can hold the animated graphic, a 3×3 graphic of 8 frames. Its draw shows the first frame and adds the graphic to `animation_list`, through `draw_animated`. Each frame lasts as many passes as the layout record's flags plus 2.

On each pass, `step_animations` counts on the time of each graphic in the list. It stops at the first graphic whose time is up, and draws that one's next frame. The graphics after it in the list skip that pass, so a later graphic's frame can last a pass longer. The frames loop from the eighth back to the first.

The frames draw with no mask, over the cells' colours and marks, which stay as they are. The [Graphics page](../reference/graphics.html#animated-graphic) shows the frames.

---

## The hatchway animation

The [Game flow](game-flow.md#the-hatchway-trip) page gives the phases of a trip and how long each lasts. The [graphics engine](graphics.md#the-hatch-animation) page gives how the hatch draws.

The Skimmer draws only on the passes that run a step. That matters for the shot's clicks, below.

---

## Sounds

Each sound has one trigger. #TABLE(default)
{ =h Sound   | =h When it plays                        | =h Routine        }
{ Title tune | On the title screen, until a key press  | `play_title_tune` }
{ Shot       | The launch of either shot               | `draw_skimmer`    }
{ Explosion  | Each frame of an explosion, and its end | `explode_hostile` }
TABLE#

The shot's clicks run for two passes from the launch. The launch sets them up in `shot_click_row` and `shot_click_time`. The Skimmer's draw sounds them, so they sound only on passes where the Skimmer draws. In the hatchway animation that is every fourth pass. So a shot launched then clicks only if a step of the animation falls in its two passes.

The explosion sounds with each of its frames, every second pass, and once more as it ends. The paint of its cells, in `colour_hostile_cells`, and the draw of each frame play it. The [Sound page](../reference/sound.html#explosion) plays it, as it plays [the shot](../reference/sound.html#shot).

At the start of each pass, the play loop turns the speaker off and the border black.
