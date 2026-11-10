# Hostile objects

Hostile objects are the hull's moving defences. Up to four exist at once, each 16×16 pixels in one of 13 designs. Each steers toward the Skimmer at whole cells. They launch from the launch cells of the outer hull's screens. Inside the hull the only one is the sector's defence device, which never moves.

---

## Slots and pairs

The four hostile object slots start at `hostile_slots`, in two pairs. Each pass moves one pair, through `move_hostile_objects`. The first pair moves on an even count of `hostile_tick`, and the second on an odd count. So each object moves once every second pass. The [State](state.md#hostile-objects) page gives a slot's contents.

Each move copies the object's record into the current hostile object, moves it, and copies it back. It passes over an empty slot.

Each object belongs to the screen it launched on, which `hostile_screen_num` holds. An object of another screen keeps its slot unchanged while the Skimmer is away. It shows again when the Skimmer comes back to its screen. The game empties all four slots at the start of a game, and on each trip into or out of the hull.

---

## The hold on a new screen

Each new screen starts with a hold, which lasts two calls of the move. So each pair gets one move of the hold. The count of the hold sits in `hostile_hold_time`. #TABLE(default)
{ =h Object in the hold                | =h What the hold does                }
{ Of the new screen, in a free place   | Shows again where it was             }
{ Of the new screen, on a blocked cell | Vanishes, after the cell's collision }
{ In its explosion                     | Vanishes                             }
{ The defence device                   | Draws first after the hold           }
{ Of another screen                    | Stays as it is                       }
TABLE#

A vanished object leaves its slot empty and draws nothing. The blocked cell's collision is the one the [Collisions](collision.md) page gives for a hostile object's move. So it can score, or push the Skimmer. No launch happens during the hold.

---

## Launch

The [hull](hull.md#launch-cells) page gives where the launch cells lie. After the hold, a call of the move can launch one object into the pair it moves, when these all hold. #TABLE(default)
{ =h Condition                                 }
{ The call removed no object                   }
{ The pair has fewer objects than launch cells }
{ The pair has a slot free for the launch      }
{ The launch cell is free                      }
TABLE#

The pair's count takes in its objects of the current screen and every object in its explosion. So a screen with one launch cell holds up to two objects, one in each pair. A screen with two or more holds up to four. In the move where a hit makes an object explode, the count takes that object twice.

A slot is free when it is empty, or when its object belongs to another screen. The launch takes an empty slot first, and that other object loses its slot only when no slot is empty. It picks one of the screen's launch cells at random: the remainder of the Z80's refresh register by the number of cells. It picks one of the 13 [designs](../reference/graphics.html#hostile-objects) the same way.

The new object starts at the left edge of its cell, square on the cell's top. If a mark blocks any of its cells, the call launches nothing, but the cell's collision still applies. Otherwise the object takes its slot, with a count of 5 cells to its first steer. It first draws at its next move.

### Start direction

Each launch graphic gives its launch cell a start direction. A defect in `draw_layout_graphic` stores the direction one bit higher than the move reads it. So every new object starts up or left. #TABLE(default)
{ =h Launch graphic | =h Direction stored | =h Direction taken }
{ 31                | Right               | Left               }
{ 32                | Up                  | Up                 }
{ 33                | Left                | Up                 }
{ 34                | Down                | Left               }
TABLE#

The [Graphics page](../reference/graphics.html#outer-hull-graphics) shows the launch graphics under these numbers.

---

## Movement

A move steps the object 2 pixels in its direction, which `hostile_state` holds. So an object moves 1 pixel per pass, and 8 passes take it across a cell. The [State](state.md#hostile-objects) page gives the values of the state.

The offset of the image in its column, 0–3 in steps of 2 pixels, sits in `hostile_x_shift`. The object covers 2 columns at offset 0, and 3 otherwise. It covers 2 rows when its top lies on a cell's top, and 3 otherwise.

An object can leave the play area. It moves on until its column is −2 or 32, or its row is 4 or 24. There it can move no further, and its next move takes it out of the game. Cells off the play area take no marks and no draw.

### Steers

An object steers only on a whole cell that lies wholly on the play area. That means offset 0, its top on a cell's top, column 0–30 and character row 6–22. Each such cell counts down `hostile_steer_count`, and the object steers when the count reaches 0.

To steer, the move takes the distance in cells from the object's top-left cell to the Skimmer's, in each of the four directions. A distance the wrong way is negative. The object turns the way of the longest distance, and the count takes that distance. So it heads for the Skimmer's row or column, and steers again once it reaches it.

A tie goes to the later direction in the order up, down, left, right. So between equal distances across and down, the object goes across. The routine is `update_hostile`. It writes the four distances into the first four cells of the attribute mirror, under the control panel.

### Blocks

A move checks the cells ahead when the object reaches into a new column or row of cells, in `check_hostile_block`. The [Workspace page](../reference/workspace.html#attribute-mirror) gives the marks that stop a hostile object. A blocked object turns back: up and down swap, and so do left and right. A block from the Skimmer, a shot or a hit makes it explode, as the [Collisions](collision.md) page gives.

The object lifts its own mark while it moves, so it never blocks itself.

---

## Draw

The draw puts the object's image through its mask over its background store, at its horizontal offset. The launch builds the four shifted images and masks of the design, through `preshift_hostile`. The draw writes pixels only, so the object takes the colours of the cells it crosses. The routine is `draw_hostile`.

The object does not draw in a cell that a bright graphic, a bar or the Skimmer marks. Its cover map records those cells, as the Skimmer's does.

---

## Fire

Each move ends with a test for a shot, which can launch the hostile objects' shot. The [Shots](shots.md#the-hostile-objects-shot) page gives when and where.

---

## The defence device

Each sector has a defence device in its own design, which the [Graphics page](../reference/graphics.html#defence-devices) shows. The [hull](hull.md#defence-devices) page gives where it stands and the flag that marks it destroyed.

The device takes the slot at `hostile_slots`, through `init_defence_device`. Its state marks it as the device, and its count of cells never runs down. It draws its design through a solid mask, at offset 0, and never moves, steers or fires.

A shot that strikes it makes a hit, and the device explodes at its next move, as any object does. The Skimmer that rams it explodes it too. An explosion inside the hull marks the sector's device destroyed. It stays destroyed for the rest of the game.

Inside the hull no launch cell exists, so the device is the only hostile object there.
