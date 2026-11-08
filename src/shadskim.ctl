; Shadow Skimmer (The Edge, 1987) - SkoolKit control file for the game's code
; block, $61A8-$F9FF (LOAD "SHADOWSKIM"CODE 25000, 39000 bytes).
;
; Code/data map: every c block below is backed by execution evidence - the
; addresses tools/coverage_trace.py saw executed while playing the game under
; SkoolKit's simulator, extended by tools/extend_map.py to the branches of
; those routines that play did not take. Everything else is b (bytes) until
; the code shows otherwise. See docs/DISASSEMBLY.md.
@ $61A8 start
@ $61A8 org
b $61A8
@ $61FD label=game_entry
c $61FD Game entry point
D $61FD The BASIC loader's RANDOMIZE USR starts the game here.
b $6200
s $6703
b $6705
s $6B64
b $6B6C
s $6B74
b $6B75
s $7CD2
b $7CD4
@ $8B00 label=*
B $8B00
@ $9020 label=*
B $9020
@ $94E0 label=*
B $94E0
@ $9500 label=*
B $9500
@ $9520 label=*
B $9520
@ $95D0 label=*
B $95D0
@ $99A0 label=*
B $99A0
@ $99A9 label=*
B $99A9
@ $99C7 label=*
B $99C7
@ $9E08 label=*
B $9E08
@ $9F58 label=*
B $9F58
s $A0D7
b $A0D9
s $A12F
b $A131
@ $A158 label=*
B $A158
s $A2B7
b $A2B8
@ $A458 label=*
@ $A818 label=*
@ $B000 label=boot
c $B000 Jump to the main loop
@ $B003 label=clear_screen
c $B003 Clear the screen
D $B003 Blanks the pixels and sets every attribute to white ink on black. It also sets every byte of the attribute mirror to 1.
@ $B02A label=draw_hull_surface
c $B02A Draw the hull surface
D $B02A Fills the play area below the control panel with the hull pattern of the current sector at #R$BD3F. Inside the hull it clears the play area instead.
@ $B032 ssub=LD ($B058),A
@ $B04F label=draw_hull_rows
@ $B058 label=hull_pattern_step
@ $B080 label=cell_addrs
c $B080 Find the screen addresses of a cell
D $B080 Gives the pixel address and the attribute address of the character cell at a row and a column.
@ $B096 label=edge_cell_addrs
c $B096 Find the screen addresses of a cell that may lie off the screen's sides
D $B096 Gives the pixel and attribute addresses of a cell whose column may lie off the left or the right edge of the screen?
@ $B0BE label=cell_mask_addrs
b $B0BE Cell mask addresses
D $B0BE The address of each graphic's cell mask, by mask number from 1. The top five bits of a graphic's height give its mask number, and 0 draws every cell.
W $B0BE,14,2
@ $B0CC label=cell_mask_1
b $B0CC Cell masks
D $B0CC Each graphic's mask holds one byte per character cell, row by row. A 0 byte leaves its cell's pixels as they are, and any other value draws the cell and marks it in the attribute mirror.
B $B0CC,6
@ $B0D2 label=cell_mask_2
B $B0D2,9,3
@ $B0DB label=cell_mask_3
B $B0DB,16,4
@ $B0EB label=cell_mask_4
B $B0EB,16,4
@ $B0FB label=cell_mask_5
B $B0FB,16,4
@ $B10B label=cell_mask_6
B $B10B,16,4
@ $B11B label=cell_mask_7
B $B11B,20,4
@ $B12F label=colour_pat_addrs
b $B12F Colour pattern addresses
D $B12F The address of each colour pattern, by pattern number from 1. The top five bits of a graphic's width give its pattern number, and 0 colours the whole graphic in one colour. The control panel's two halves take patterns 33 and 34.
W $B12F,30,2
S $B14D,34 Patterns 16–32, which hold no address
W $B16F,4,2 Addresses of the colour patterns of the control panel's two halves
@ $B173 label=colour_pat_1
b $B173 Colour patterns
D $B173 Each colour pattern holds one attribute per character cell, row by row. A 0 byte leaves its cell's colour as it is, and $FF gives the cell the graphic's own colour. Some patterns share bytes, so one can start inside another.
B $B173,4
@ $B177 label=colour_pat_3
B $B177,1
@ $B178 label=colour_pat_4
B $B178,1
@ $B179 label=colour_pat_2
B $B179,4,2
@ $B17D label=colour_pat_5
B $B17D,20,5
@ $B191 label=colour_pat_6
B $B191,16,4
@ $B1A1 label=colour_pat_7
B $B1A1,20,5
@ $B1B5 label=colour_pat_8
B $B1B5,16,4
@ $B1C5 label=colour_pat_9
B $B1C5,24,6
@ $B1DD label=colour_pat_10
B $B1DD,6,2
@ $B1E3 label=colour_pat_11
B $B1E3,9,3
@ $B1EC label=colour_pat_12
B $B1EC,6,2
@ $B1F2 label=colour_pat_13
B $B1F2,6,3
@ $B1F8 label=colour_pat_14
B $B1F8,9,3
@ $B201 label=colour_pat_15
B $B201,9,3
@ $B20A label=draw_graphic
c $B20A Draw a graphic
D $B20A Draws a graphic by its number at a row and a column, and colours it. Inside the hull it takes the graphic from the inner-section set.
@ $B231 label=plot_graphic
@ $B27D label=plot_unmasked
@ $B33B label=cast_shadow
@ $B34A label=draw_shadow
@ $B38E label=colour_graphic
c $B38E Colour a graphic from a colour pattern
D $B38E Writes the attributes of a graphic's cells. A pattern byte of 0 leaves its cell as it is, and $FF gives the cell the graphic's own colour.
@ $B3B0 label=join_vertical
c $B3B0 Draw a graphic joined to the one before by a vertical bar
D $B3B0 Draws a graphic and a vertical bar with its shadow from the layout's previous graphic down to this one?
@ $B3F0 label=join_horizontal
c $B3F0 Draw a graphic joined to the one before by a horizontal bar
D $B3F0 Draws a graphic and a horizontal bar with its shadow from the layout's previous graphic across to this one?
@ $B427 label=animation_template
b $B427 Animated graphic template
D $B427 The first fields of a new animation list entry for an animated graphic.
@ $B432 label=stamp_hatch_pattern
c $B432 Stamp a pattern into the hatchway graphic
D $B432 Copies one cover pattern into the hatchway graphic's buffer at #R$99A0?
@ $B449 label=draw_hatchway
c $B449 Draw a hatchway
D $B449 Draws a hatchway and records its cell at #R$D2C7. Its cover patterns depend on the screen number?
@ $B4A7 label=draw_animated
c $B4A7 Draw an animated graphic
D $B4A7 Adds an animated graphic to the #R$C909(animation list) and draws its first frame?
@ $B4D9 label=draw_screen
c $B4D9 Draw the current screen
D $B4D9 Shows the sector's defence device on the control panel, then draws the screen's layout from the outer-hull map or the inner-section map?
@ $B501 ssub=LD ($B058),A
@ $B640 label=draw_layout_graphic
c $B640 Draw one graphic of a screen's layout
D $B640 Draws one graphic of the layout at a cell. Some graphics also place the hatchway, an animation, a shadow or the defence device?
@ $B6DD label=draw_inner_graphic
@ $B70B label=set_hostile_cell
c $B70B Set the current hostile object's cell
@ $B71E label=init_defence_device
c $B71E Set up the defence device
D $B71E Places the current sector's defence device at a cell, with its graphic from the sector's entry at #R$9520.
@ $B751 ssub=LD ($CC32),A
@ $B756 ssub=LD ($C80D+1),A
@ $B75A label=find_device_flag
c $B75A Find the current sector's defence device flag
b $B766
@ $B789 label=colour_rectangle
c $B789 Colour a rectangle of the screen
D $B789 Gives bright white paper and black ink to the cells between the cell at #R$BD1D and this one?
@ $B7B7 label=shadow_cell
c $B7B7 Shade one cell
D $B7B7 Lays a shadow mask over a cell's pixels, unless the attribute mirror marks the cell as one that takes no shadow?
@ $B7CE label=mirror_pixel_addr
c $B7CE Find a cell's pixel address from its attribute mirror address
@ $B7DA label=shadow_mask_full
b $B7DA Shadow masks
D $B7DA The pixel masks of the cells of a shadow.
B $B7DA,8
@ $B7E2 label=shadow_mask_lead
B $B7E2,8
@ $B7EA label=shadow_mask_tail
B $B7EA,8
@ $B7F2 label=shadow_mask_hbar
B $B7F2,8
@ $B7FA label=shadow_mask_vbar
B $B7FA,8
@ $B802 label=bar_cell_h
b $B802 Bar cells
D $B802 The patterns of the bars that join graphics, drawn by #R$BC70 and #R$BCB3.
B $B802,8
@ $B80A label=bar_cell_v
B $B80A,8
@ $B812 label=draw_control_panel
c $B812 Draw the control panel
@ $B84B label=clear_play_area
c $B84B Clear the play area
@ $B850 label=clear_screen_top
c $B850 Clear the top of the screen
@ $B856 label=clear_pixel_rows
@ $B859 label=clear_fill
@ $B874 label=colour_play_area
c $B874 Colour the play area
@ $B87A label=play_area_colour
@ $B889 label=print_shields
c $B889 Print the number of shields
@ $B88F label=print_digit
@ $B89F label=msg_title
t $B89F Title screen text
D $B89F The title, the menu and the copyright line of the title screen, printed by #R$BAC6. The four control-method lines end in spaces, so each one fills the 21-cell bar that #R$BAAE inverts over the selected method.
N $B89F Every message that #R$BB4A prints is a run of lines in this format. All of them print on black paper.
N $B89F #TABLE(default,,,:w) { =h Byte | =h Content | =h Values } { 1 | Column | 0–31 } { 2 | Row | 0–23 } { 3 | Attribute | One for every character on the line } { 4 onward | Characters | Space, digits, capitals and [ } { Last | End of the message | $00 } { Last | End of the line | $80–$FF, with the next line after it } TABLE#
T $B89F,18,n3:14:n1 Game title in bright white
T $B8B1,25,n3:21:n1 Keyboard option in bright yellow
T $B8CA,25,n3:21:n1 Kempston joystick option in bright yellow
T $B8E3,25,n3:21:n1 Sinclair joystick option in bright yellow
T $B8FC,25,n3:21:n1 Cursor joystick option in bright yellow
T $B915,21,n3:17:n1 Redefine-keys option in bright yellow
T $B92A,18,n3:14:n1 Start-game option in bright yellow
T $B93C,34,n3:30:n1 Copyright line in bright cyan. The font draws [ as a slash.
@ $B95E label=msg_redefine
t $B95E Redefine-keys screen text
D $B95E The title and the prompt of the redefine-keys screen, printed by #R$BA3C in the message format of #R$B89F. Each control name from #R$B9BD prints into the gap after PRESS THE.
T $B95E,17,n3:13:n1 Title in bright cyan
T $B96F,24,n3:20:n1 Prompt in bright cyan
@ $B987 label=key_names
t $B987 Key names
D $B987 The name of each key as the redefine-keys screen shows it, indexed by key code from 0 to 39, in the key order of #R$BC04. The first character of a name has bit 7 set, and the name runs up to the next byte with bit 7 set.
N $B987 BUG: the name for the F key is E, so the redefine-keys screen shows E for a control defined on F.
T $B987,54,1*24,1:2,1*7,1:4,1:4,1*5,1:3,n1 One name per line, then a byte that only ends the last name
@ $B9BD label=msg_controls
t $B9BD Control names
D $B9BD The six controls that the redefine-keys screen asks a key for, in the order it asks. Each is a one-line message in the format of #R$B89F, with its own end byte. All six print in the gap of the prompt at #R$B95E.
T $B9BD,54,n3:5:n1 One control per line, in bright white
@ $B9F3 label=menu_keys
b $B9F3 Title-screen menu keys
D $B9F3 The key code of each title-screen menu option, one byte per option in menu order. The key names at #R$B987 give the key for each code.
B $B9F3,6,1
  $B9F3 Key 1 for the keyboard
  $B9F4 Key 2 for the Kempston joystick
  $B9F5 Key 3 for the Sinclair joystick
  $B9F6 Key 4 for the cursor joystick
  $B9F7 Key 5 to redefine the keys
  $B9F8 Key 0 to start the game
@ $B9F9 label=msg_game_over
t $B9F9 Game over message
D $B9F9 One line printed by #R$BAC6 in the message format of #R$B89F.
T $B9F9,13,n3:9:n1 Bright white
@ $BA06 label=msg_wall_done
t $BA06 Wall-done message
D $BA06 Three lines printed by #R$B4D9 in the message format of #R$B89F.
T $BA06,53,n3:9:n1,n3:13:n1,n3:20 Bright white
s $BA3B
@ $BA3C label=redefine_keys
c $BA3C Redefine-keys screen
D $BA3C Asks for a key for each of the six controls of #R$B9BD and stores the key codes from #R$BC21. It shows the name of each key from #R$B987.
b $BAA7
@ $BAAE label=toggle_method_bar
c $BAAE Highlight bar on the selected control method
D $BAAE Toggles the highlight bar over the title-screen line of the control method at #R$BD24. A second call removes the highlight.
@ $BAC6 label=main_loop
c $BAC6 Main loop
D $BAC6 Shows the title screen, acts on its menu keys and runs a game when the player starts one, then shows the title screen again. After a game it first prints the game-over message, unless the game ends on the WALL DONE screen that sets #R$BD3D.
@ $BACE ssub=LD ($B859+1),A
@ $BB4A label=print_message
c $BB4A Print a message
D $BB4A Prints a message in the format of #R$B89F, one line at a time.
@ $BB6D label=print_char
c $BB6D Print a character
D $BB6D Draws one character of the game's font and colours its cell with #R$BD15.
@ $BBA2 label=read_controls
c $BBA2 Read the controls
D $BBA2 Reads the six controls from the keys or the joystick of the control method at #R$BD24, one bit per control. While a push on the Skimmer runs, it returns a forced direction and then none in place of the controls?
@ $BC04 label=test_key
c $BC04 Test one key
D $BC04 Reads whether one key is held, by its key code. A key code runs from 0 for B to 39 for CAPS SHIFT. Its low three bits pick the half-row, and the rest pick the key in it.
@ $BC1F label=control_keys
b $BC1F Control keys
D $BC1F The key code of each control for the keyboard, the Sinclair joystick and the cursor joystick.
@ $BC21 label=redefinable_keys
B $BC21
@ $BC37 label=scan_keyboard
c $BC37 Scan the keyboard
D $BC37 Finds the key that is held, if any, and gives its #R$BC04(key code).
@ $BC57 label=wait_new_key
c $BC57 Wait for a new key press
D $BC57 Waits until no key is held, then until one key is held, and returns its key code.
@ $BC5D label=wait_key
b $BC68
@ $BC70 label=draw_pattern_row
c $BC70 Draw a row of one pattern
D $BC70 Draws one 8×8 pattern again and again along a row of character cells, coloured with #R$BD15.
@ $BCB3 label=draw_pattern_column
c $BCB3 Draw a column of one pattern
D $BCB3 Draws one 8×8 pattern again and again down a column of character cells, coloured with #R$BD15.
u $BD0F Unused bytes
@ $BD11 label=graphic_attr_addr
g $BD11 Game variables
W $BD11,2 Attribute address of the top-left cell of the current graphic or pattern
@ $BD13 label=pattern_mirror_addr_lo
B $BD13,1 Low byte of the attribute-mirror address of the first cell of the last pattern row or column
@ $BD14 label=pattern_mirror_addr_hi
B $BD14,1 High byte of the attribute-mirror address of the first cell of the last pattern row or column
@ $BD15 label=draw_attr
B $BD15,1 Attribute of the current graphic, pattern or character, with $80 for a graphic that keeps the old colours of its cells
@ $BD16 label=plot_width
B $BD16,1 Width in cells of the current graphic
@ $BD17 label=layout_column
B $BD17,1 Column of the current layout graphic, 0–31
@ $BD18 label=layout_flags
B $BD18,1 Flags of the current layout entry, 0–7, with 4–7 for a run of one graphic to an end cell?
@ $BD19 label=layout_row
B $BD19,1 Character row of the current layout graphic, counted from the top of the screen
@ $BD1A label=graphic_width
B $BD1A,1 Width in cells of the last graphic drawn
@ $BD1B label=graphic_height
B $BD1B,1 Height in cells of the last graphic drawn
@ $BD1C label=run_cells_left
B $BD1C,1 Distance in cells from the current layout graphic to the end of its run
@ $BD1D label=prev_layout_cell
B $BD1D,2 Column, then row, of the layout graphic before the current one
@ $BD1F label=prev_layout_graphic
B $BD1F,1 Number of the layout graphic before the current one
@ $BD20 label=layout_graphic
B $BD20,1 Number of the current layout graphic
@ $BD21 label=graphic_pixel_addr_lo
B $BD21,1 Low byte of the screen address of the top pixel row of the current graphic's top-left cell
@ $BD22 label=graphic_pixel_addr_hi
B $BD22,1 High byte of the screen address of the top pixel row of the current graphic's top-left cell
@ $BD23 label=mirror_mark
B $BD23,1 0 for no attribute mirror mark, 1 for a bright graphic, marked with its mask bytes, 2 for a bar, marked with 2
@ $BD24 label=control_method
B $BD24,1 Control method: 0 for the keyboard, 1 for a Kempston joystick, 2 for a Sinclair joystick, 3 for a cursor joystick
@ $BD25 label=screen_column
B $BD25,1 Column of the current screen on the hull map, 0–9 from left to right
@ $BD26 label=screen_row
B $BD26,1 Row of the current screen on the hull map, 0–10 from top to bottom
@ $BD27 label=screen_number
B $BD27,1 Number of the current screen, from its column and its row on the hull map
@ $BD28 label=launch_cells
B $BD28,8,2 Four launch cells for hostile objects, each a column byte that also holds the start direction, then a row byte
@ $BD30 label=launch_cell_ptr
W $BD30,2 Address of the next free launch cell
@ $BD32 label=colour_pattern
B $BD32,1 Twice the number of the current graphic's colour pattern in #R$B12F, 0 for a graphic in one colour
@ $BD33 label=launch_cell_count
B $BD33,1 Number of launch cells on the current screen
@ $BD34 label=skip_shadow
B $BD34,1 0 if each graphic casts its own shadow, any other value if it casts none
@ $BD35 label=run_length
B $BD35,1 Length in cells of the current layout run
u $BD36 Unused bytes
@ $BD3C label=shields
g $BD3C Game state
B $BD3C,1 Number of shields the Skimmer has left, 0–3
@ $BD3D label=game_over
B $BD3D,1 0 while a game runs, any other value once it has ended
@ $BD3E label=inside_hull
B $BD3E,1 1 while the Skimmer is in an inner section of the hull, 0 while it is on the outer hull
@ $BD3F label=sector
B $BD3F,1 Sector of the hull that the Skimmer is in, 1–3
@ $BD40 label=device_destroyed_1
B $BD40,1 0 if the defence device of sector 1 stands, $FF if it is destroyed?
@ $BD41 label=device_destroyed_2
B $BD41,1 0 if the defence device of sector 2 stands, $FF if it is destroyed?
@ $BD42 label=device_destroyed_3
B $BD42,1 0 if the defence device of sector 3 stands, $FF if it is destroyed?
@ $BD43 label=hull_one_band
B $BD43,1 1 to draw the hull pattern as one band of 16 pixel rows, 0 to repeat it down to the bottom of the screen
@ $BD44 label=handle_fire
c $BD44 Handle the fire key
D $BD44 With fire and one direction held and no pulse laser shot in flight, it fires that way if the Skimmer lines up on that axis? When it fires nothing, over a hatchway? it starts the hatchway animation, and every call ends with a move of the shots.
@ $BD96 ssub=LD A,($D2B0+1)
@ $BDB5 ssub=LD A,($D2B0+1)
@ $BE11 label=fire_laser_shot
c $BE11 Fire a pulse laser shot
D $BE11 Launches the pulse laser shot from the cell beside the Skimmer in the chosen direction, unless that cell stops it.
@ $BE1E label=launch_shot
@ $BE44 label=move_shots
c $BE44 Move the shots
D $BE44 Moves the pulse laser shot and the hostile objects' shot one cell each. It ends a shot whose range runs out or whose cell stops it.
@ $BE4D label=move_one_shot
@ $BE94 label=step_cell
c $BE94 Step one cell in a direction
D $BE94 Moves a position on the play area one cell left, right, up or down.
@ $BEB9 label=erase_shot
c $BEB9 Erase a shot
D $BEB9 Puts back the pixels and colour of the cell a shot covered.
@ $BEE0 label=push_skimmer_from_shot
c $BEE0 Push the Skimmer after a shot strikes
D $BEE0 Starts a push on the Skimmer whose direction follows the shot's?
@ $BEEF label=score_shot_hit
c $BEEF Score a shot's hit
D $BEEF Marks the struck cell as hit, counts the hit and adds 160 to the score total at #R$D48A?
@ $BF04 label=check_shot_cell
c $BF04 Check the cell a shot enters
D $BF04 Decides whether a shot can enter a cell, and hands a cell that the shot strikes to the push or the score routine.
@ $BF16 label=report_shot_stopped
c $BF16 Report a stopped shot
@ $BF19 label=draw_shot
c $BF19 Draw a shot
D $BF19 Draws a shot in its new cell and saves what was there, or reports that the cell stops the shot.
@ $BF6A label=find_hatch_graphic
c $BF6A Find the graphic for a step of the hatchway animation
D $BF6A Works out where the rows of the hatchway graphic for one animation step start, and how many rows it shows?
@ $BF8B label=animate_hatchway
c $BF8B Step the hatchway animation
D $BF8B Every fourth call, draws the next step of the hatchway as it opens or closes. It returns the step after that one, or zero once the animation is over?
@ $C09B label=random_below
c $C09B Random number below a limit
D $C09B Returns a number from zero to one less than the limit, the remainder of the refresh register divided by the limit.
@ $C0AC label=hostile_image_bufs
b $C0AC Image buffers of the hostile objects
D $C0AC The address of each hostile object's image buffer, which holds its shifted images and masks.
W $C0AC,8,2
@ $C0B4 label=move_hostile_objects
c $C0B4 Move the hostile objects
D $C0B4 Moves two of the four hostile objects on each call and the other two on the call after.
D $C0B4 It brings a new hostile object in while fewer are out than the limit at #R$BD33?
@ $C0B5 ssub=LD ($CC32),A
@ $C0D6 ssub=LD ($C80D+1),A
@ $C12B ssub=LD ($C80D+1),A
@ $C227 label=preshift_hostile
c $C227 Build a hostile object's shifted images
D $C227 Builds the four images and four masks of the current hostile object from its design, each copy shifted 2 pixels further right.
@ $C22D label=preshift_hostile_image
@ $C244 ssub=LD A,($C95F+1)
@ $C249 ssub=LD ($C95F+1),A
@ $C24E label=preshift_hostile_mask
@ $C25E label=shift_image_row
c $C25E Shift one design row four ways
D $C25E Writes one row of a design four times, each copy shifted 2 pixels further right, and moves the build position to the next row.
@ $C269 label=shift_image_row_copy
@ $C275 label=shift_image_row_bits
@ $C28D label=draw_hostile
c $C28D Draw a hostile object
D $C28D Draws the current hostile object's image for its pixel offset through its mask.
@ $C299 label=draw_hostile_offset
@ $C2A2 label=draw_hostile_mask
@ $C2A9 label=draw_hostile_mask_ok
@ $C2B4 label=draw_hostile_args
@ $C2BD label=plot_hostile_image
@ $C2C7 label=save_hostile_bg
c $C2C7 Save the background behind a hostile object
D $C2C7 Copies the screen under the current hostile object into its background store.
@ $C2C9 label=save_hostile_bg_col
b $C2DA
@ $C2DB label=update_hostile
c $C2DB Update a hostile object
D $C2DB Runs one move of the current hostile object, in which it steers toward the Skimmer along the axis of the larger distance. It explodes when a pulse laser shot hits it?
@ $C2FD label=scan_hit_row
@ $C300 label=scan_hit_cell
@ $C30E label=scan_hit_next
@ $C31A label=scan_hit_down
@ $C330 label=update_hostile_hold
@ $C349 label=update_hostile_steer
@ $C354 ssub=LD A,($C947+1)
@ $C39D label=steer_pick_axis
@ $C3A8 label=steer_next_axis
@ $C3B7 label=remove_hostile
c $C3B7 Remove a hostile object
D $C3B7 Empties the current hostile object's slot and puts back the background behind it.
@ $C3DB label=remove_hostile_col
@ $C3F5 label=advance_hostile
c $C3F5 Advance a hostile object
D $C3F5 Moves the current hostile object 2 pixels in its direction. A blocked hostile object turns back, and one that reaches the edge of the play area leaves the game.
@ $C404 label=advance_hostile_right
@ $C40D label=advance_hostile_up
@ $C416 label=advance_hostile_down
@ $C41D label=advance_hostile_done
@ $C42F label=advance_hostile_moved
@ $C437 label=redraw_hostile
@ $C43E label=finish_explosion
c $C43E End a hostile object's explosion
D $C43E Paints the current hostile object's cells white on black and removes the hostile object.
@ $C445 ssub=LD ($C80D+1),A
@ $C44B label=explode_hostile
c $C44B Animate a hostile object's explosion
D $C44B Starts the current hostile object's explosion or shows its next frame.
@ $C45E ssub=LD ($C80D+1),A
@ $C470 label=explode_hostile_first
@ $C472 label=explode_hostile_frame
@ $C47D ssub=LD ($CC0A+1),A
@ $C48A ssub=LD ($CC0A+1),A
@ $C48E label=vanish_hostile
@ $C494 label=colour_hostile_cells
c $C494 Colour a hostile object's cells
D $C494 Colours the current hostile object's cells that hold no ink, and clicks the speaker once per cell row?
@ $C4A3 label=colour_hostile_row
@ $C4A7 label=colour_hostile_cell
@ $C4AE label=colour_hostile_next
@ $C4C7 label=colour_hostile_down
@ $C4CB label=image_offsets
b $C4CB Image offsets
D $C4CB The distance of each image from the start of a hostile object's shifted images or of the explosion frames. There are eight, one word each, in steps of 48 bytes, the size of one image.
W $C4CB,16,2
@ $C4DB label=add_image_offset
c $C4DB Add an image offset
@ $C4E5 label=add_image_offset_get
@ $C4F2 label=draw_explosion
c $C4F2 Draw a hostile object's explosion frame
D $C4F2 Draws the current explosion frame at the hostile object's position, after it shifts the frame to the hostile object's pixel offset when they differ.
@ $C508 label=draw_explosion_shift
@ $C526 label=shift_explosion
c $C526 Shift an explosion frame
D $C526 Shifts one explosion frame in place to the current hostile object's pixel offset and records that offset.
@ $C533 label=expl_right_row
@ $C535 label=expl_right_pass
@ $C549 label=expl_left
@ $C557 label=expl_left_row
@ $C559 label=expl_left_pass
@ $C56D label=step_hostile_left
c $C56D Move a hostile object left
D $C56D Moves the current hostile object 2 pixels left, and turns it back when a new column is blocked.
@ $C57A label=step_left_vacate
@ $C598 label=step_left_column
@ $C5B8 label=step_left_open
@ $C5DA label=step_left_store
@ $C5E2 label=undo_step_right
c $C5E2 Turn back a hostile object blocked on the right
D $C5E2 Undoes the current hostile object's last step right and reverses its direction.
@ $C5E6 label=reverse_hostile
@ $C5F3 label=step_hostile_right
c $C5F3 Move a hostile object right
D $C5F3 Moves the current hostile object 2 pixels right, and turns it back when a new column is blocked.
@ $C61C label=step_right_column
@ $C650 label=step_right_store
@ $C658 label=step_hostile_up
c $C658 Move a hostile object up
D $C658 Moves the current hostile object 2 pixels up, and turns it back when a new row is blocked.
@ $C661 ssub=LD A,($C947+1)
@ $C68D label=step_up_open
@ $C692 label=step_up_pixels
@ $C6A5 label=step_up_line
@ $C6B3 label=step_up_shift
@ $C6E1 label=step_hostile_down
@ $C6E1 ssub=LD A,($C947+1)
c $C6E1 Move a hostile object down
D $C6E1 Moves the current hostile object 2 pixels down, and turns it back when a new row is blocked.
@ $C6F2 ssub=LD ($C947+1),A
@ $C6F8 ssub=LD A,($C947+1)
@ $C6FC ssub=LD ($C947+1),A
@ $C702 label=step_down_pixels
@ $C716 label=step_down_shift
@ $C743 label=step_down_draw
@ $C75E label=step_down_store
@ $C766 label=mark_cell_inked
c $C766 Mark an inked cell
@ $C76A label=mark_hostile_cells
c $C76A Mark the inked cells under a hostile object
D $C76A Marks each cell of the current hostile object on the play area whose colour has ink?
@ $C770 label=mark_cells_clear
@ $C779 label=mark_cells_row
@ $C77D label=mark_cells_cell
@ $C785 label=mark_cells_store
@ $C79A label=clip_hostile
c $C79A Find a hostile object's cells on the play area
D $C79A Clips the cells of the current hostile object to the play area.
@ $C7AC label=clip_hostile_rows
@ $C7AC ssub=LD A,($C947+1)
@ $C7B4 label=clip_hostile_right
@ $C7BD label=clip_right_loop
@ $C7C8 label=clip_left_loop
@ $C7D3 label=clip_hostile_bottom
@ $C7DB label=clip_bottom_loop
@ $C7E6 label=clip_top_loop
@ $C7F2 label=clip_top_next
@ $C7FA label=clip_hostile_done
@ $C802 label=toggle_hostile_flag
c $C802 Toggle a hostile object's flag in the attribute mirror
D $C802 Flips a flag bit in each attribute mirror cell under the current hostile object, so a second call puts it back?
@ $C809 label=toggle_flag_row
@ $C80C label=toggle_flag_cell
@ $C80D label=hostile_flag_bits
@ $C819 label=hostile_collision
c $C819 Handle a hostile object's collision
D $C819 Reports a blocked cell to the caller, and makes the hostile object explode on a cell of the Skimmer or one marked by a hit? A hit cell also adds 160 to the score total at #R$D48A, and a Skimmer cell pushes the Skimmer.
@ $C82D label=hostile_hit_skimmer
@ $C83C label=hostile_hit_explode
@ $C841 label=hostile_hit_done
@ $C845 label=push_skimmer
c $C845 Start a push on the Skimmer
D $C845 Starts a push on the Skimmer up, down, left or right.
@ $C84F label=push_skimmer_down
@ $C856 label=push_skimmer_left
@ $C860 label=push_skimmer_right
@ $C866 label=check_hostile_block
c $C866 Check a hostile object's cells for a block
D $C866 Reports whether an attribute mirror cell under the current hostile object blocks it, and handles the collision there?
@ $C86E label=check_block_row
@ $C871 label=check_block_cell
@ $C87E label=check_block_clear
@ $C880 label=hostile_fire
c $C880 Let a hostile object fire
D $C880 Fires the hostile objects' shot from the current hostile object toward the Skimmer, across the object's line of travel?
@ $C8C1 label=hostile_fire_right
@ $C8D0 label=hostile_fire_vert
@ $C8EB label=hostile_fire_down
@ $C8F7 label=hostile_fire_launch
@ $C909 label=animation_list
g $C909 Animation list
D $C909 The animated graphics of the current screen, 13 bytes each: the fields of #R$B427, then the screen address of the graphic. A $FF byte follows the last entry, and the list has room for two.
S $C909,27 Room for two entries and the end byte
@ $C924 label=animation_list_end
g $C924 End of the animation list
W $C924,2 Address of the end byte of the #R$C909(animation list), where the next entry goes
u $C926 Unused bytes
@ $C927 label=shot_range
g $C927 Shot range
B $C927,1 Range in cells of the current shot
@ $C928 label=pulse_laser_shot
g $C928 Pulse laser shot
B $C928,1 Direction of the shot, 0–3 for left, right, up or down, or $FF for no shot, with bit 7 set before its first move
B $C929,1 Range left, in cells
W $C92A,2 Attribute mirror address of the shot's cell
S $C92C,9 Colour, then the eight pixel rows, of the cell under the shot
B $C935,1 Unused
@ $C936 label=hostile_shot
g $C936 Hostile objects' shot
D $C936 The hostile objects' shot, in the format of #R$C928, with directions 4–7 for left, right, up or down.
B $C936,1 Direction of the shot
B $C937,1 Range left, in cells
W $C938,2 Attribute mirror address of the shot's cell
S $C93A,9 Colour, then the eight pixel rows, of the cell under the shot
B $C943,1 Unused
@ $C944 label=current_shot
g $C944 Current shot
W $C944,2 Address of the shot to move, #R$C928 or #R$C936
@ $C946 label=hostiles_counted
g $C946 Hostile objects counted
B $C946,1 Number of hostile objects counted on the current screen during one move of the hostile objects
@ $C947 label=hostile_screen_pos
g $C947 Current hostile object
D $C947 A copy of the record of the hostile object that moves, from its slot.
W $C947,2 Screen address of the hostile object's top pixel row
@ $C949 label=hostile_pixel_offset
B $C949,1 Pixel offset of the hostile object to the right of its column, in steps of 2 pixels?
@ $C94A label=hostile_column
B $C94A,1 Column of the hostile object's left cell
@ $C94B label=hostile_row
B $C94B,1 Character row of the hostile object's top cell
@ $C94C label=hostile_attr_pos
W $C94C,2 Attribute mirror address of the hostile object's top-left cell
@ $C94E label=hostile_state
B $C94E,1 Direction 0–3 for up, down, left or right, $17 for the defence device, or a negative value during an explosion or after removal?
@ $C94F label=hostile_marks_ptr
W $C94F,2 Address of the hostile object's marks of inked cells
@ $C951 label=hostile_bg_ptr
W $C951,2 Address of the hostile object's background store
@ $C953 label=hostile_image_ptr
W $C953,2 Address of the hostile object's shifted images
@ $C955 label=hostile_counter
B $C955,1 Moves until the hostile object next steers toward the Skimmer?
@ $C956 label=hostile_spawn_key
B $C956,1 Number of the screen that the hostile object is on
@ $C957 label=hostile_moved
g $C957 Hostile object moved
B $C957,1 1 if the current hostile object moved during its move, 0 if not?
@ $C958 label=hostile_tick
g $C958 Hostile object tick
B $C958,1 Count of the moves of the hostile objects, 0–255
u $C959 Unused bytes
@ $C95B label=hit_count
g $C95B Hit count
B $C95B,1 Number of cells that pulse laser shots marked as hit
@ $C95C label=hostile_turned
g $C95C Hostile object turned
B $C95C,1 1 if the current hostile object turned back during its move, 0 if not?
@ $C95D label=hostile_slot
g $C95D Current hostile object's slot
W $C95D,2 Address of the slot of the hostile object that moves
@ $C95F label=preshift_pos
g $C95F Shifted-image build position
W $C95F,2 Address in the image buffer of the next copy of a design row
@ $C961 label=new_hostile_slot
g $C961 New hostile object's slot
B $C961,1 Slot of a new hostile object in the pair of slots that moves, 0 or 1
@ $C962 label=hostiles_removed
g $C962 Hostile objects removed
B $C962,1 Number of hostile objects removed during one move of the hostile objects
@ $C963 label=move_skimmer_left
c $C963 Move the Skimmer left
D $C963 Moves the Skimmer left by its horizontal step. A blocked move turns it back, and the left edge of the screen flags an exit.
@ $C97B label=move_left_blocked
c $C97B Turn the Skimmer back after a blocked move left
D $C97B Reverses the Skimmer's horizontal motion after a blocked move to the left.
@ $C97C label=turn_skimmer_x
@ $C985 label=move_left_cell
c $C985 Move the Skimmer into the cell on its left
D $C985 Moves the Skimmer one cell left when nothing blocks that cell, and otherwise turns it back.
@ $C99E label=move_left_px
c $C99E Move the Skimmer left inside its cell
D $C99E Moves the Skimmer left without a change of cell, and puts back the background of the column it leaves at the cell's left edge.
@ $C9B7 label=move_left_scroll
c $C9B7 Shift the Skimmer's background store one cell left
D $C9B7 Moves the Skimmer's screen position one cell left and saves the background of the column it enters.
@ $C9D2 label=store_left_px
@ $C9DA label=exit_screen_right
c $C9DA Flag an exit to the screen on the right
D $C9DA Flags that the Skimmer leaves the screen across its right edge.
@ $C9E0 label=move_skimmer_right
c $C9E0 Move the Skimmer right
D $C9E0 Moves the Skimmer right by its horizontal step. A blocked move turns it back, and the right edge of the screen flags an exit.
@ $CA07 label=move_right_px
@ $CA46 label=store_right_px
@ $CA4E label=exit_screen_top
c $CA4E Flag an exit to the screen above
D $CA4E Flags that the Skimmer leaves the screen across its top edge.
@ $CA54 label=move_skimmer_up
c $CA54 Move the Skimmer up
D $CA54 Moves the Skimmer up by its vertical step. A blocked move turns it back, and the top of the play area flags an exit.
@ $CA59 ssub=LD A,($D2B0+1)
@ $CA7D label=turn_skimmer_y
@ $CA86 label=move_up_row_clear
@ $CA8E label=move_up_px
@ $CAA4 label=move_up_line
@ $CAB1 label=move_up_source
@ $CABE label=move_up_draw
@ $CAD0 label=move_up_small_step
@ $CAD6 label=move_up_scroll
@ $CAEA label=exit_screen_bottom
c $CAEA Flag an exit to the screen below
D $CAEA Flags that the Skimmer leaves the screen across its bottom edge.
@ $CAF0 label=move_skimmer_down
@ $CAF0 ssub=LD A,($D2B0+1)
c $CAF0 Move the Skimmer down
D $CAF0 Moves the Skimmer down by its vertical step. A blocked move turns it back, and the bottom of the play area flags an exit.
@ $CB0C ssub=LD A,($D2B0+1)
@ $CB11 label=move_down_px
@ $CB27 label=move_down_source
@ $CB45 label=move_down_big_step
@ $CB4B label=move_down_scroll
@ $CB5D label=move_down_draw
@ $CB6A label=move_down_draw_at
@ $CB85 label=move_down_store
b $CB8E
@ $CBA8 label=draw_skimmer
c $CBA8 Draw the Skimmer
D $CBA8 Draws the Skimmer through its mask over its saved background, and leaves undrawn the cells its #R$CD3A(cover map) marks.
@ $CBAA ssub=LD ($CC32),A
@ $CBBB label=skimmer_draw_seq
@ $CBCA label=skimmer_draw_shift
@ $CBD1 label=skimmer_draw_frame
@ $CBF3 label=skimmer_draw_row
@ $CBF6 label=skimmer_draw_byte
@ $CC03 label=skimmer_draw_next
@ $CC0A label=skimmer_draw_sound
@ $CC17 label=skimmer_draw_down
@ $CC2A label=skimmer_draw_rows_left
@ $CC2E label=skimmer_draw_rewind
@ $CC32 label=skimmer_draw_map_back
@ $CC38 label=skimmer_draw_covered
@ $CC42 label=save_skimmer_bg
c $CC42 Save the background behind the Skimmer
D $CC42 Copies the screen under the Skimmer into its background store.
@ $CC4A label=skimmer_bg_col
@ $CC57 label=save_bg_column
@ $CC5A label=bg_save_row
@ $CC73 label=restore_bg_column
c $CC73 Put back one column of the Skimmer's background
D $CC73 Copies one column of the Skimmer's background store back to the screen, and leaves out the cells its cover map marks.
@ $CC77 label=bg_restore_row
@ $CC7F label=bg_restore_next
@ $CC9B label=save_screen_block
c $CC9B Save a block of the screen
D $CC9B Copies a block of the screen, as many pixel rows deep as the count at #R$D2C4, into a store.
@ $CCA1 label=block_save_row
@ $CCA4 label=block_save_byte
@ $CCB0 label=restore_screen_block
c $CCB0 Put back a block of the screen
D $CCB0 Copies a stored block, as many pixel rows deep as the count at #R$D2C4, back onto the screen. It leaves out the columns a cover map marks?
@ $CCB6 label=block_restore_row
@ $CCB9 label=block_restore_byte
@ $CCC2 label=block_restore_next
@ $CCD3 label=check_skimmer_column
c $CCD3 Check the cells beside the Skimmer
D $CCD3 Checks a column of cells beside the Skimmer for anything that blocks it. The flipped Skimmer ignores one more attribute mirror mark, so cells with only that mark do not block it.
R $CCD3 O:F carry set if the way is clear
@ $CCDE label=check_skimmer_col_len
@ $CCE0 ssub=LD A,($D2B0+1)
@ $CCE8 label=check_skimmer_col_go
@ $CCEB label=check_skimmer_col_cell
@ $CCF4 label=skimmer_blocked
@ $CD06 label=skimmer_blocked_mark
@ $CD16 label=skimmer_blocked_done
@ $CD18 label=check_skimmer_row
c $CD18 Check the cells above or below the Skimmer
D $CD18 Checks a row of cells above or below the Skimmer for anything that blocks it.
R $CD18 O:F carry set if the way is clear
@ $CD23 label=check_skimmer_row_len
@ $CD2D label=check_skimmer_row_cell
@ $CD36 label=mark_cell_covered
c $CD36 Mark a cell in the Skimmer's cover map
@ $CD3A label=map_skimmer_cover
c $CD3A Build the Skimmer's cover map
D $CD3A Marks each cell under the Skimmer that the attribute mirror marks, and the fourth column when the Skimmer sits on a cell edge?
@ $CD49 label=cover_map_row
@ $CD4F label=cover_map_cell
@ $CD5D label=cover_map_store
@ $CD6E label=get_skimmer_span
c $CD6E Find the cells under the Skimmer
D $CD6E Gives the Skimmer's top-left cell in the attribute mirror and how many rows and columns of cells lie under it. Each count is four, or three where the Skimmer sits exactly on a cell edge.
@ $CD7C label=get_skimmer_span_rows
@ $CD7C ssub=LD A,($D2B0+1)
@ $CD86 label=toggle_skimmer_flag
c $CD86 Toggle the Skimmer's flag in the attribute mirror
D $CD86 Flips a flag bit in each attribute mirror cell under the Skimmer?
@ $CD89 label=toggle_cells_flag
@ $CD8C label=toggle_cells_flag_row
@ $CD8F label=toggle_cells_flag_cell
@ $CD9C label=skimmer_images
b $CD9C Skimmer images, normal and flipped
D $CD9C Each entry is two words: the address of an image, then the address of its mask. The first four are the Skimmer's images at each pixel offset.
B $CD9C,16,4
@ $CDAC label=skimmer_flipped_images
N $CDAC The flipped Skimmer at each pixel offset
B $CDAC,16,4
@ $CDBC label=skimmer_flip_frames
b $CDBC Skimmer flip frames
D $CDBC The three frames of the flip, each laid out as an entry of the #R$CD9C(Skimmer images).
B $CDBC,12,4
@ $CDC8 label=shield_loss_frames
b $CDC8 Skimmer frames for a shield loss
D $CDC8 Eight frames, each laid out as an entry of the #R$CD9C(Skimmer images). The stage of a shield loss at #R$D2D4 picks the frame.
B $CDC8,32,4
@ $CDE8 label=init_interrupts
c $CDE8 Set up the interrupt routine
D $CDE8 Fills the interrupt vector table so that every interrupt jumps to the #R$CE26(flag routine), and switches to vectored interrupts.
@ $CDEF label=init_interrupts_fill
@ $CE07 label=readouts_interrupt
c $CE07 Interrupt routine that updates the readouts
D $CE07 Runs the #R$D343(readout update) on each interrupt, then sets the flag at #R$D2AF.
@ $CE26 label=flag_interrupt
@ $CE30 label=skimmer_cells_changed
c $CE30 Check whether the cells under the Skimmer changed
D $CE30 Compares the Skimmer's attribute mirror address and span with the ones saved at #R$D2BA and #R$D2BC.
R $CE30 O:F zero set if nothing changed
@ $CE38 ssub=LD A,($D2B8+1)
@ $CE4B label=colour_play_area_split
c $CE4B Colour the play area with a black left strip
D $CE4B Sets the play area to black on black in its left 11 columns and to white on black in the right 21.
@ $CE4D label=split_colour_row
@ $CE51 label=split_colour_left
@ $CE59 label=split_colour_right
@ $CE61 label=animate_flip
c $CE61 Step the Skimmer's flip animation
D $CE61 Every fourth call, advances the flip frame. After the third frame of the flip, it toggles the flipped state and switches to the Skimmer images for the new state.
@ $CE82 label=animate_flip_frames
@ $CE85 label=animate_flip_done
@ $CE86 label=row_first_screen
b $CE86 First screen number of each hull map row
D $CE86 One byte per row of the hull map: the number of the row's first screen. A screen's number is this byte plus its column.
B $CE86,11,1
@ $CE91 label=play_game
c $CE91 Play a game
D $CE91 Runs a game until the last shield goes or the Skimmer reaches the WALL DONE screen, one pass of its loop for each interrupt.
R $CE91 O:A $5E if the game ends on the WALL DONE screen
@ $CEDB label=enter_screen
@ $CEDF label=enter_screen_hatchway
@ $CEE0 ssub=LD HL,$CE07
@ $CF0C ssub=LD ($D2C7+1),A
@ $CF3C ssub=LD ($B87A+1),A
@ $CF53 ssub=LD ($B87A+1),A
@ $CF70 ssub=LD HL,$CE26
@ $CF92 label=play_loop
@ $CFA6 ssub=LD ($CC0A+1),A
@ $CFB2 ssub=LD A,($D2B0+1)
@ $D10D label=play_loop_update
@ $D10F ssub=LD ($CC0A+1),A
@ $D191 ssub=LD A,($D2B0+1)
@ $D1E2 ssub=LD A,($D2B0+1)
@ $D219 label=set_speed_rates
c $D219 Set the step rates of a Skimmer speed
D $D219 Sets the Skimmer's step rates on one axis from its speed on that axis and the table at #R$D2A6. While no push runs, a flipped Skimmer takes the rates of the next slower speed.
@ $D24A label=lose_shield
c $D24A Lose a shield
D $D24A Once the Damage Report Indicator runs out, advances a shield loss by one stage every fourth call, or every eighth with one shield left. Its eighth stage takes away a shield, fills the indicator again and ends the game when it takes the last shield.
@ $D292 label=fill_damage_report
c $D292 Fill the Damage Report Indicator
D $D292 Sets the Damage Report Indicator to 999.
@ $D29D label=pause
c $D29D Pause
@ $D2A6 label=speed_rates
b $D2A6 Skimmer speed rates
D $D2A6 One record of two bytes for each Skimmer speed, from speed 0 to speed 3. The first byte is the size of one step? The second is 1 for a step on every second pass of the play loop, or 0 for a step on every pass.
B $D2A6,8,2
u $D2AE Unused bytes
@ $D2AF label=interrupt_flag
g $D2AF Play loop variables
B $D2AF,1
@ $D2B0 label=skimmer_scr_addr
W $D2B0,2
@ $D2B2 label=skimmer_x_shift
B $D2B2,1
@ $D2B3 label=skimmer_stepped
B $D2B3,1
@ $D2B4 label=control_bits
B $D2B4,1
@ $D2B5 label=speaker_byte
B $D2B5,1 Byte the clicks send to the border and speaker port?
@ $D2B6 label=skimmer_column
B $D2B6,1
@ $D2B7 label=skimmer_row
B $D2B7,1
@ $D2B8 label=skimmer_mirror_addr
W $D2B8,2
@ $D2BA label=old_mirror_addr
B $D2BA,2
@ $D2BC label=old_skimmer_span
B $D2BC,2
@ $D2BE label=screen_exit
B $D2BE,1
@ $D2BF label=speed_x
B $D2BF,1
@ $D2C0 label=speed_x_step
B $D2C0,1 Size of one step on the X axis?
@ $D2C1 label=speed_x_mask
B $D2C1,1
@ $D2C2 label=speed_x_phase
B $D2C2,1
@ $D2C3 label=speed_y
B $D2C3,1
@ $D2C4 label=speed_y_step
B $D2C4,1 Size of one step on the Y axis, in pixel rows?
@ $D2C5 label=speed_y_mask
B $D2C5,1
@ $D2C6 label=speed_y_phase
B $D2C6,1
@ $D2C7 label=hatchway_cell
W $D2C7,2 Column, then row, of the hatchway's cell on the current screen
@ $D2C9 label=hatchway_step
B $D2C9,1
@ $D2CA label=anim_divider
B $D2CA,1 Count of hatchway and flip animation calls, read modulo 4
@ $D2CB label=push_time
B $D2CB,1
@ $D2CC label=hostile_hold_time
B $D2CC,1 Hold count of the hostile objects, $FE or $FF while they hold and 0 once they move?
@ $D2CD label=shot_click_row
B $D2CD,1 First pixel row of a cell at which the Skimmer draw clicks the speaker, 0 for every row and $FE or $FF for none
@ $D2CE label=shot_click_time
B $D2CE,1 Passes of the play loop left before the clicks of a pulse laser shot stop, 0 when none run?
@ $D2CF label=skimmer_image_set
B $D2CF,2
@ $D2D1 label=flip_step
B $D2D1,1
@ $D2D2 label=flipped
B $D2D2,1
@ $D2D3 label=skimmer_moving
B $D2D3,1
@ $D2D4 label=shield_loss_step
B $D2D4,1 Stage of a shield loss, 0–7, with 0 when no shield loss runs
@ $D2D5 label=shield_loss_ticks
B $D2D5,1
@ $D2D6 label=print_readout
c $D2D6 Print a control panel number
D $D2D6 Prints a run of digits in inverse video at a character cell of the control panel.
@ $D2E6 label=print_inverse_digit
c $D2E6 Print one control panel digit
D $D2E6 Prints one digit in inverse video and moves to the next cell on the right.
@ $D2FD label=add_score_digits
c $D2FD Add to the score digits
D $D2FD Adds a number held as decimal digits to the score, digit by digit.
@ $D31E label=subtract_damage_digits
c $D31E Subtract from the Damage Report Indicator
D $D31E Takes a number held as decimal digits away from the Damage Report Indicator, digit by digit.
@ $D343 label=update_readouts
c $D343 Update the Damage Report Indicator and the score
D $D343 Runs down the Damage Report Indicator, faster while a push on the Skimmer runs, and starts a shield loss when it runs out?
D $D343 It then prints the indicator and counts points still due into the score?
@ $D372 label=show_readouts
@ $D3F7 label=add_points
c $D3F7 Add points to the score
D $D3F7 Adds points to the total still to count into the score?
@ $D401 label=reset_score
c $D401 Reset the score
D $D401 Fills the Damage Report Indicator, sets the score to zero and prints it.
@ $D41A label=step_animations
c $D41A Step the animated graphics
D $D41A Advances the timers of the animated graphics in the #R$C909(animation list), and draws the next frame of the first one whose timer reaches its limit.
b $D473
@ $D475 label=*
B $D475
@ $D478 label=*
B $D478
@ $D47E label=*
B $D47E
@ $D47F label=*
B $D47F
@ $D481 label=*
B $D481
@ $D482 label=*
B $D482
@ $D487 label=*
B $D487
@ $D488 label=*
B $D488
@ $D48A label=*
B $D48A
@ $D48C label=*
B $D48C
@ $D48D label=*
B $D48D
@ $D800 label=*
B $D800
@ $EA00 label=*
B $EA00
@ $F000 label=play_title_tune
c $F000 Play the title tune
D $F000 Plays the title tune with interrupts off, over and over until the player presses a key.
@ $F006 label=run_title_tune
c $F006 Decrypt and run the title tune player
D $F006 Decrypts the tune player at #R$F009 and runs straight into it. The player encrypts itself again before it returns.
b $F009 Encrypted routine
D $F009 These bytes are code XOR-encrypted in place: #R$F45F decrypts them (key $41 for the first byte, one more for each byte after it) and the routine at #R$F006 runs straight into the result.
b $F30A
@ $F45F label=crypt_title_tune
c $F45F Decrypt or re-encrypt the title tune player
D $F45F Decrypts the title tune player at #R$F009, or encrypts it again. XOR is its own inverse, so one pass does either.
b $F473
@ $F480 label=*
B $F480
@ $F7F8 label=*
B $F7F8
@ $F800 label=*
B $F800
@ $F809 label=*
B $F809
@ $F840 label=*
B $F840
@ $F848 label=*
B $F848
@ $F890 label=*
B $F890
@ $F940 label=*
B $F940
@ $F990 label=*
B $F990
i $FA00
