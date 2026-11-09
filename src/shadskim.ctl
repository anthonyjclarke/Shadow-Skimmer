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
@ $61A8 equ=attr_mirror=$FA00
@ $61A8 equ=int_jump=$FDFD
@ $61A8 equ=int_vectors=$FE00
@ $61A8 equ=skimmer_bg_store=$FF10
@ $61A8 equ=skimmer_cover_map=$FF70
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
@ $9520 label=device_designs
N $9520 The design of each sector's defence device.
N $9520 #UDGTABLE { #UDGARRAY2,,6,3($9520;$9521;$9538;$9539)(device_design_1) | #UDGARRAY2,,6,3($9550;$9551;$9568;$9569)(device_design_2) | #UDGARRAY2,,6,3($9580;$9581;$9598;$9599)(device_design_3) } { Sector 1 | Sector 2 | Sector 3 } TABLE#
B $9520
@ $95D0 label=animated_frames
B $95D0
@ $99A0 label=hatch_bitmap
B $99A0
@ $99A9 label=hatch_upper_patch
B $99A9
@ $99C7 label=hatch_lower_patch
B $99C7
@ $99E8 label=hatch_patterns
B $99E8
@ $9A68 label=*
B $9A68
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
R $B080 I:B character row, 0–23
R $B080 I:C column, 0–31
R $B080 O:DE attribute address of the cell
R $B080 O:HL screen address of the cell's top pixel row
  $B080 The row's screen third picks the high byte of the pixel address.
  $B086 The same third picks the high byte of the attribute address.
  $B08C,9 The row within its third, × 32, plus the column, gives the low byte of both addresses.
@ $B096 label=edge_cell_addrs
c $B096 Find the screen addresses of a cell that may lie off the screen's sides
D $B096 Gives the pixel and attribute addresses of a cell, as #R$B080 does. Its column may lie off the left or the right edge of the screen.
N $B096 Each step past an edge moves both addresses one cell along screen memory, within the row's screen third. A column off the left edge lands near the end of the row above, or of the third's bottom row from its top row. A column off the right edge lands at the start of the row below, or of the third's top row from its bottom row.
R $B096 I:B character row, 0–23
R $B096 I:C column, from −128 to 127, negative for a column off the left edge
R $B096 O:DE attribute address of the cell
R $B096 O:HL screen address of the cell's top pixel row
  $B096 Is the column off the left edge?
  $B099 Jump if not
  $B09C Find the addresses of the row's first cell, and count the columns past the edge.
@ $B0A4 label=edge_step_left
  $B0A4,5 Step both addresses one cell back for each column past the edge.
@ $B0AA label=edge_test_right
  $B0AA Is the column on the screen?
  $B0AC If so, find its addresses the usual way
  $B0AE Find the addresses of the row's last cell, and count the columns past it.
@ $B0B6 label=edge_step_right
N $B0B6 BUG: the loop goes on while the column count is below 31, which it never is past the right edge. So it stops after one step, and every column past the edge gives the cell after column 31. The game passes only columns 0–31 here, so the defect has no effect.
  $B0B6,7 Step both addresses one cell on.
@ $B0BE label=cell_mask_addrs
b $B0BE Cell mask addresses
D $B0BE The address of each cell mask, by mask number from 1.
W $B0BE,14,2
@ $B0CC label=cell_mask_1
b $B0CC Cell masks
D $B0CC Each cell mask holds one byte per character cell of a graphic, row by row from the top. A 0 byte is a cell the graphic does not draw, which keeps its pixels and marks. Any other byte is the mark a bright graphic sets in the cell's attribute mirror entry. A graphic reads only as many bytes as it has cells, so one mask serves graphics of several sizes.
B $B0CC,6,3
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
D $B12F The address of each colour pattern, by pattern number from 1.
W $B12F,30,2
S $B14D,34 Patterns 16–32, which hold no address
W $B16F,4,2 Addresses of the colour patterns of the control panel's two halves
@ $B173 label=colour_pat_1
b $B173 Colour patterns
D $B173 Each colour pattern holds one byte per character cell of a graphic, row by row from the top. A 0 byte leaves the cell's colour as it is, and $FF gives the cell the graphic's own colour. Any other byte is the cell's attribute. Some patterns share bytes, so one can start inside another.
B $B173,4,2
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
D $B20A Draws a graphic from the graphic directory at a cell and colours it. A bright graphic also marks its cells in the attribute mirror and, on the outer hull, casts a shadow.
R $B20A I:A graphic number
R $B20A I:B character row of the graphic's top-left cell
R $B20A I:C column of the graphic's top-left cell
R $B20A I:D attribute of the graphic, or $80 to draw its pixels alone
R $B20A O:HL' attribute mirror address of the cell below the graphic's bottom-left cell, or of its top-left cell if it marks nothing, or unchanged when the attribute is $80
  $B20A Keep the attribute and the cell.
  $B20C Start from the outer hull's directory.
  $B20F Is the Skimmer on the outer hull?
  $B214 Jump if so
  $B216 Take the inner sections' directory instead.
@ $B219 label=find_graphic_entry
  $B219 Point at the graphic's entry, 4 bytes per graphic.
  $B228 Fetch the address of the graphic's pixels, then the width byte and the height byte.
  $B22F Recover the cell and the attribute.
@ $B231 label=plot_graphic
N $B231 This entry point draws a graphic from outside the directories. The caller holds the pixel address, the two size bytes, the cell and the attribute as the directory path leaves them.
  $B231 Keep the attribute for the colour pass.
  $B234 Is the graphic bright?
  $B236 Jump if not
  $B238 A bright graphic marks its cells in the attribute mirror.
@ $B23C label=plot_no_mark
  $B23C Any other graphic marks nothing.
@ $B23E label=plot_store_mark
  $B23E Store the choice for the mark and shadow passes.
  $B241 Find the cell's pixel and attribute addresses, and record both.
  $B251 Split the width byte: the low three bits are the width in cells, and the top five bits give the colour pattern, kept doubled.
  $B25F Split the height byte: the low three bits are the height in cells, and the top five bits the mask number. Does the graphic have a mask?
  $B268 Jump if not
  $B26A Index the mask table by the mask number.
@ $B26D ssub=ADD A,(cell_mask_addrs-$02)%$100
@ $B270 ssub=LD H,(cell_mask_addrs-$02)/$100
  $B274 Never runs: no mask number carries past the page.
@ $B275 label=read_mask_addr
  $B275 Push the mask's address for the three passes.
@ $B27D label=plot_unmasked
N $B27D This entry point draws a graphic with no mask. A caller that enters here sets the attribute, the mirror mark and the colour pattern first, and the top-left cell's attribute address (#R$BD11). Its size can then run past 7 cells each way.
  $B27D Use the attribute mirror's top rows, from column 4, as the mask. #R$B003 fills them with 1, and later marks only set more bits, so every cell draws.
@ $B27E ssub=LD BC,attr_mirror+4
@ $B283 label=plot_store_size
  $B283 Record the size, keep it for the later passes, and keep the width for each row of cells.
@ $B28C label=plot_row
N $B28C The pixel pass. A graphic holds 8 bytes per cell, one per pixel row from the top, cell by cell along each row of cells. A cell the mask skips still takes its 8 bytes.
  $B28C Keep the screen address of the row's first cell.
@ $B28D label=plot_cell
  $B28D Does the mask cover this cell?
  $B295 Jump if so
  $B298 Skip the cell's pixel data.
  $B29E Cross into the next page of the pixel data.
@ $B2A1 label=copy_cell_pixels
  $B2A1 Walk the cell's pixel rows from the top.
@ $B2A3 label=copy_pixel_row
  $B2A3 Copy each pixel row of the cell onto the screen, over what was there.
@ $B2A9 label=next_plot_cell
  $B2A9 Move one cell right, until the row of cells is done.
  $B2B0 Back at the row's first cell, step down one character row.
  $B2BB Cross into the next screen third.
@ $B2BF label=next_plot_row
  $B2BF Draw the next row of cells.
  $B2C1 Does the graphic keep the colours of its cells?
  $B2C6 Jump if not
  $B2C8,2 Drop the size and the mask address. The graphic leaves its cells' colours and marks as they are, and casts no shadow.
@ $B2CB label=apply_colours
N $B2CB The colour pass. The graphic's own colour is its attribute without flash.
  $B2CB Switch register sets for the colour, mark and shadow passes, and keep the graphic's own colour.
  $B2CF Fetch the size and the mask address, and start at the top-left cell's attribute.
  $B2D6 Does the graphic have a colour pattern?
  $B2DB Jump if not
  $B2DD Index the colour pattern table by the pattern number.
@ $B2DE ssub=LD H,(colour_pat_addrs-$02)/$100
@ $B2E0 ssub=ADD A,(colour_pat_addrs-$02)%$100
  $B2E4 Never runs: no pattern number carries past the page.
@ $B2E5 label=read_pattern_addr
  $B2E5 Fetch the pattern's address and colour the cells from it.
@ $B2EF label=fill_row
N $B2EF With no colour pattern, every cell the mask covers takes the graphic's own colour.
  $B2EF Start a row of cells.
@ $B2F2 label=fill_cell
  $B2F2 Does the mask cover this cell?
  $B2F5 Jump if not
  $B2F7 Give the cell the graphic's own colour.
@ $B2FA label=next_fill_cell
  $B2FA Go on along the row.
  $B2FE Step down to the next row of attributes.
  $B305 Cross into the next third of the attributes.
@ $B306 label=next_fill_row
  $B306 Colour the next row.
@ $B309 label=mark_graphic
N $B309 The mark pass. A marked graphic sets the bits of each covered cell's mask byte in that cell's marks in the attribute mirror.
  $B309 Fetch the size and the mask address, and find the top-left cell in the attribute mirror.
@ $B310 ssub=ADD A,(attr_mirror-$5800)/256
  $B313 Does the graphic mark its cells?
  $B318 Jump if not
@ $B31A label=mark_row
  $B31A Start a row of cells.
@ $B31D label=mark_cell
  $B31D Does the mask cover this cell?
  $B320 Jump if not
  $B322 Set the mask byte's bits in the cell's marks.
@ $B324 label=next_mark_cell
  $B324 Go on to the next cell.
  $B328 Step down one row of the attribute mirror.
  $B32F Cross into the next page of the attribute mirror.
@ $B330 label=next_mark_row
  $B330 Mark the next row.
@ $B333 label=check_shadow
  $B333 Recover the size.
  $B334 Does the graphic leave its shadow to the caller?
  $B339 Jump if so
@ $B33B label=cast_shadow
N $B33B This entry point casts the shadow of a block of cells. It takes the block's size and the attribute mirror address of the cell below its bottom-left cell. It returns with the two register sets exchanged, the address in HL'.
N $B33B A shadow covers the cells the block sweeps over as it slides one cell down and one cell right. It forms a band under the block and up its right side, with a half cell cut at 45° at each end. It shades only cells that the attribute mirror leaves clear (#R$B7B7).
  $B33B Is the block unmarked?
  $B341 Jump if so: it casts no shadow
  $B343 Is the Skimmer inside the hull?
  $B348 Jump if so: nothing casts a shadow there
@ $B34A label=draw_shadow
N $B34A This entry point casts the shadow of any block, marked or not. It leaves through a pop that takes its own return address, so a CALL to it returns to its caller's caller.
  $B34A Is the bottom edge's first cell in column 0?
  $B34E Jump if so: it starts with a full cell
  $B350 Start the bottom edge with its cut corner.
  $B356 Count the cell.
  $B357 Jump if that was the whole bottom edge
@ $B359 label=next_shadow_cell
  $B359 Move one cell right.
@ $B35A label=shade_bottom_cell
  $B35A Shade the rest of the bottom edge in full, one cell per column of the block.
@ $B363 label=shade_right_side
  $B363 Step past the block's right side. Does that column, counted from the current layout graphic, lie off the screen?
  $B36B Jump if so: no right edge
  $B36D The right edge rises one cell per row of the block.
@ $B36E label=shade_right_cell
  $B36E Shade the right edge in full, from the bottom row up.
  $B37B Is the layout graphic on the top row of the play area? If so, its top cell is in full.
  $B383 Jump if so
  $B385 Otherwise cut the top corner.
@ $B388 label=shade_top_cell
  $B388 Shade the cell beside the block's top row.
@ $B38B label=shadow_done
  $B38B Recover the attribute mirror address.
@ $B38C label=exit_graphic
  $B38C,1 Switch back to the first register set, which leaves the attribute mirror address in HL'.
@ $B38E label=colour_graphic
c $B38E Colour a graphic from a colour pattern
D $B38E Writes the attributes of a block of cells from one of the #R$B173(colour patterns).
R $B38E I:A' the graphic's own colour
R $B38E I:B height in cells
R $B38E I:C width in cells
R $B38E I:DE address of the colour pattern
R $B38E I:HL attribute address of the block's top-left cell
  $B38E Start a row of cells.
@ $B391 label=colour_cell
  $B391 Does the pattern leave this cell as it is?
  $B394 Jump if so
  $B396 Does it give the cell the graphic's own colour?
  $B398 Jump if so
  $B39A Write the pattern's attribute.
@ $B39D label=colour_own
  $B39D Write the graphic's own colour.
@ $B3A0 label=next_colour_cell
  $B3A0 Go on along the row.
  $B3A4 Step down to the next row of attributes.
  $B3AB Cross into the next third of the attributes.
@ $B3AC label=next_colour_row
  $B3AC,3 Colour the next row.
@ $B3B0 label=join_vertical
c $B3B0 Draw a graphic joined to the one before by a vertical bar
D $B3B0 Draws the bottom end of a vertical bar and the bar up to its top end, the layout's previous graphic. The bar casts a shadow on the hull beside it.
N $B3B0 The bar fills the rows between the two ends, in the second column of the top end. Its shadow runs down the column two to the right of the bar. It starts one row below the bar's top and ends on the bottom end's top row.
R $B3B0 I:A graphic number of the bottom end
R $B3B0 I:B character row of the bottom end's top-left cell
R $B3B0 I:C column of the bottom end's top-left cell
R $B3B0 I:D attribute of the bottom end
  $B3B0 Draw the bottom end, and keep its cell and attribute.
  $B3B7 Count the rows from two below the top end's top-left cell down to the bottom end, and start the bar one column in.
  $B3C2 Draw the bar down that column in the vertical bar cell and the bottom end's colour. Mark its cells as a bar in the attribute mirror.
  $B3CF Keep the bar's length for its shadow.
  $B3D1 Would the shadow's column lie off the right edge? Return if so: the bar casts no shadow.
  $B3D7 Find the shadow's top cell in the attribute mirror.
@ $B3DB ssub=ADD A,(attr_mirror-$5800)/256
@ $B3E2 label=shade_vbar_cell
  $B3E2,13 Shade the shadow's cells down the column, one for each cell of the bar.
@ $B3F0 label=join_horizontal
c $B3F0 Draw a graphic joined to the one before by a horizontal bar
D $B3F0 Draws the right end of a horizontal bar and the bar across from its left end, the layout's previous graphic. The bar casts a shadow on the hull below it.
N $B3F0 The bar fills the columns between the two ends, in the second row of the left end. Its shadow runs along the row two below the bar. It starts one column right of the bar's first cell and ends on the right end's first column.
R $B3F0 I:A graphic number of the right end
R $B3F0 I:B character row of the right end's top-left cell
R $B3F0 I:C column of the right end's top-left cell
R $B3F0 I:D attribute of the right end
  $B3F0 Draw the right end, and keep its cell and attribute.
  $B3F7 Count the columns from two right of the left end's top-left cell across to the right end, and start the bar one row down.
  $B402 Draw the bar along that row in the horizontal bar cell and the right end's colour. Mark its cells as a bar in the attribute mirror.
  $B40F Keep the bar's length for its shadow.
  $B411 Find the shadow's first cell in the attribute mirror.
@ $B415 ssub=ADD A,(attr_mirror-$5800)/256
@ $B41C label=shade_hbar_cell
  $B41C,10 Shade the shadow's cells along the row, one for each cell of the bar.
@ $B427 label=animation_template
b $B427 Animated graphic template
D $B427 The fields that start each entry of the #R$C909(animation list), up to the screen address of its graphic.
N $B427 #TABLE(default,,:w) { =h Byte | =h Content } { 0 | Calls of #R$D41A that each frame lasts } { 1 | Calls of #R$D41A since the current frame was drawn } { 2 | Number of frames } { 3 | Current frame, counted from 0 } { 4–5 | Address of the first frame's pixels } { 6 | Bytes from the start of one frame's pixels to the next } { 7–8 | Address of the current frame's pixels } { 9 | Width in cells } { 10 | Height in cells } TABLE#
B $B427,2 Frame length and its counter
B $B429,2 Frame count and current frame
W $B42B,2 First frame
B $B42D,1 Step from one frame to the next
W $B42E,2 Current frame
B $B430,2 Width and height
@ $B432 label=stamp_hatch_pattern
@ $B432 ssub=ADD A,hatch_patterns%$100
c $B432 Stamp a pattern into the hatch
D $B432 Copies a hatch pattern into a patch of #R$99A0(the hatch's bitmap).
N $B432 The hatch is the centre of a hatchway, 3×3 cells. Its bitmap holds each pixel row across all three cells as three bytes, rows from the top. A hatch pattern covers 16×8 pixels, two bytes per pixel row.
R $B432 I:A offset of the pattern in the hatch patterns, 16 bytes per pattern
R $B432 I:DE address in the hatch's bitmap of the patch's top-left byte
  $B432 Point at the pattern in the hatch patterns.
@ $B435 ssub=LD H,hatch_patterns/$100
  $B439 Cross into the next page.
@ $B43A label=stamp_pattern_rows
  $B43A Walk the pattern's pixel rows from the top.
@ $B43C label=stamp_pattern_row
  $B43C Start a pixel row.
@ $B43E label=stamp_pattern_byte
  $B43E Copy the pattern's two bytes for the row over the bitmap's first two.
  $B444,4 Skip the bitmap's third byte, and go on to the next pixel row.
@ $B449 label=draw_hatchway
c $B449 Draw a hatchway
D $B449 Draws a hatchway and its hatch, and records the hatchway's top-left cell as the #R$D2C7(hatchway cell). The screen number picks the two patterns on the hatch.
R $B449 I:A graphic number of the hatchway
R $B449 I:B character row of the hatchway's top-left cell
R $B449 I:C column of the hatchway's top-left cell
R $B449 I:D attribute of the hatchway
  $B449 Draw the hatchway, and keep its cell.
  $B44D Point at the hatch's upper patch, three pixel rows down from its top.
  $B450 Fetch the ROM byte at $0400 plus the screen number, a fixed but arbitrary value for each screen. Keep its two nibbles, each from 0 to 7.
  $B459 Stamp the pattern that the low nibble picks into the upper patch.
  $B463 Stamp the pattern that the high nibble picks into the lower patch, thirteen pixel rows down.
  $B46C Lay the hatch's bitmap out in the Skimmer's background store, in the cell order of a graphic.
@ $B474 label=hatch_cell_row
  $B474 Start a row of cells from its top pixel row.
@ $B477 label=hatch_pixel_row
  $B477 Start a pixel row across the row of cells.
@ $B479 label=hatch_pixel_byte
  $B479 Copy each byte of the pixel row to the same pixel row of the next cell along.
  $B482 Was that the last pixel row of the row of cells?
  $B483 Jump if so
  $B485 Step back to the next pixel row of the first cell.
@ $B48B label=next_hatch_row
  $B48B Move on to the first cell of the next row of cells, until the hatch is done.
  $B492 Record the hatchway's cell.
  $B498 Find the screen address of the hatch's top-left cell, one cell in from the hatchway's.
  $B49D,9 Draw the hatch over the hatchway's centre. The colour and mark passes start at the hatchway's own top-left cell, so they repaint cells that already hold its colour.
@ $B4A7 label=draw_animated
c $B4A7 Draw an animated graphic
D $B4A7 Draws the first frame of an animated graphic and adds the graphic to the #R$C909(animation list). Each frame lasts as many calls of #R$D41A as the layout record's flags plus 2.
R $B4A7 I:B character row of the graphic's top-left cell
R $B4A7 I:C column of the graphic's top-left cell
R $B4A7 I:D attribute of the graphic
  $B4A7 Draw the first frame, 3×3 cells with no mask and no colour pattern, in the graphic's attribute.
  $B4B3 Start a new entry at the end of the list with the template's fields. Nothing checks that the list has room.
  $B4C0 Add the screen address of the graphic's top-left cell.
  $B4CA Record the new end of the list, and close the list with its end byte.
  $B4D1,7 Set how many calls each frame lasts from the layout record's flags.
@ $B4D9 label=draw_screen
c $B4D9 Draw the current screen
D $B4D9 Draws a screen's layout, and shows the current sector's defence device on the control panel. Inside the hull, the WALL DONE screen draws no layout and ends the game.
R $B4D9 I:A number of the screen
  $B4D9 Keep the screen number.
  $B4DA Find the device's place on the control panel, half a cell below the top of its cell.
  $B4E4 Find the sector's design from the start of the designs at #R$9520, 48 bytes per sector.
  $B4F3 Never runs: no sector's design lies a page or more in.
@ $B4F4 label=panel_device_addr
  $B4F4 Point at the design.
  $B4FB Draw a single band, and patch the #R$B058(hull pattern's step) to do nothing.
@ $B501 ssub=LD ($B058),A
  $B504 Each pixel row of the design takes three bytes. Copy the first two of each onto the panel, and skip the third.
  $B50A Let the hull pattern repeat down the screen again.
  $B50E Is the Skimmer on the outer hull? Start from the outer hull's layouts.
  $B516 Jump if so
  $B518 Take the inner sections' layouts instead.
  $B51B Is it the WALL DONE screen?
  $B51E Jump if not
  $B520 End the game, and show the WALL DONE message.
  $B52A Count the pauses.
@ $B52C label=wall_done_pause
  $B52C,5 Hold the message for a little over 9 seconds at the 3.5 MHz clock, longer by the time the interrupt routine takes.
@ $B532 label=outer_layout
  $B532 Recover the screen number.
@ $B533 label=find_layout
  $B533 Fetch the address of the screen's layout from the map, one word per screen number.
  $B541 Start the launch cells afresh, and point at the first record.
@ $B548 label=read_layout_record
N $B548 Each record of a layout holds one graphic at one cell, in three bytes. A record that starts a run takes the cell of the record after it as the run's end.
  $B548 Fetch the graphic number. Is it the end of the layout?
  $B54C Return if so
  $B54D Keep the graphic number, and start from white ink on black.
  $B554 The low five bits of the second byte give the column.
  $B55A Do its top three bits give an ink?
  $B55D Jump if not: the graphic stays dull, so it marks no cell and casts no shadow
  $B55F Make the attribute bright, with that ink on black paper.
  $B568 Let the graphic cast its own shadow.
@ $B56D label=read_layout_row
  $B56D The top three bits of the third byte are the record's flags.
  $B577 Its low five bits give the row, counted down from the top row of the play area.
  $B580 Keep the address of the next record.
  $B582 Does the record start a run?
  $B587 Jump if so
@ $B589 label=draw_single
  $B589 Draw the graphic once.
@ $B591 label=layout_record_done
  $B591 Record the graphic and its cell for the next record, and move on to it.
@ $B59E label=start_layout_run
N $B59E A run repeats its graphic toward the end cell, one graphic width or height apart. It stops short of the end, where the next record draws its own graphic.
  $B59E Fetch the end column from the next record. While a column other than 0 sits in #R$BD34(the shadow switch), the graphics of the run cast no shadows of their own.
  $B5A9 Does the run end in its own column?
  $B5AA Jump if so: the run goes down
  $B5AC Find the run's length in cells.
  $B5AD If the end lies to the left, draw the graphic once
  $B5AF Keep the length twice, as the distance left and as the width of the shadow, and keep the start cell.
@ $B5B6 label=draw_run_across
  $B5B6 Draw the graphic, and recover its attribute, which the draw keeps at #R$BD15(the draw attribute).
  $B5C2 Take the graphic's width off the distance left. Is the end reached?
  $B5CC Jump if so
  $B5CE Jump if the run overshoots the end
  $B5D0 Step right by the graphic's width, and draw the next one.
@ $B5D5 label=run_across_done
  $B5D5 Recover the start cell. Is it the one graphic whose runs across cast no shadow?
  $B5DB Jump if so
  $B5DD Find the attribute address of the cell below the run's bottom-left cell. The shadow's block is the graphic's height tall and the run's length wide.
@ $B5EC label=shadow_layout_run
N $B5EC BUG: the jump back records the registers the shadow leaves as the previous graphic's cell, not the run's cell. They hold the last graphic's size. So a bar joined to the end of the run starts from the wrong cell.
  $B5EC Cast the run's shadow from the attribute mirror, then move on to the next record.
@ $B5ED ssub=ADD A,(attr_mirror-$5800)/256
@ $B5F6 label=start_run_down
N $B5F6 A run down keeps its own column in #R$BD34(the shadow switch). In column 0 that lets each of its graphics cast a shadow of its own as well as the run's.
  $B5F6 Fetch the end row from the next record, and find the run's length in rows.
  $B5FD If the end lies above, draw the graphic once
  $B5FF Keep the length twice, as the rows left and as the height of the shadow, and keep the start cell.
@ $B606 label=draw_run_down
  $B606 Draw the graphic, and recover its attribute, which the draw keeps at #R$BD15(the draw attribute).
  $B612 Take the graphic's height off the rows left. Is the end reached?
  $B61C Jump if so
  $B61E Jump if the run overshoots the end
  $B620 Step down by the graphic's height, and draw the next one.
@ $B625 label=run_down_done
  $B625 Recover the start cell. Is it the one graphic whose runs down cast no shadow?
  $B62B Jump if so
  $B62E Find the attribute address of the cell below the run's bottom-left cell. The shadow's block is the run's length tall and the graphic's width wide.
@ $B640 label=draw_layout_graphic
c $B640 Draw one graphic of a screen's layout
D $B640 Draws one graphic of a screen's layout at its cell. Some graphics do a task of their own as well as the draw, or in its place.
R $B640 I:A graphic number
R $B640 I:B character row of the graphic's top-left cell
R $B640 I:C column of the graphic's top-left cell
R $B640 I:D attribute of the graphic
  $B640 Is the Skimmer inside the hull?
  $B645 Jump if so
  $B648 Is it a hatchway?
  $B64A Jump if so
  $B64D Is it a graphic joined to the one before by a vertical bar?
  $B64F Jump if so
  $B652 Is it a graphic joined to the one before by a horizontal bar?
  $B654 Jump if so
  $B657 Is it the animated graphic?
  $B659 Jump if so
  $B65C Is it below the launch graphics?
  $B65E Jump if so
  $B660 Is it above them?
  $B662 Jump if so
  $B664 A launch graphic records a launch cell for hostile objects, one cell down and right of its top-left cell.
  $B66B Number the launch graphics from 0. Is it the one given the start direction left?
  $B66F Jump if so
  $B671 Is it the one given the start direction down?
  $B673 Jump if not
  $B675 Give it the start direction down.
@ $B67A label=launch_dir_add
  $B67A Give the first the start direction right, and the second up.
@ $B67C label=store_launch_cell
N $B67C BUG: the direction goes into the column byte one bit higher than #R$C0B4(the move of the hostile objects) reads it. So an object from a launch cell starts up or left.
  $B67C Put the start direction in the top two bits of the column byte.
  $B681 Store the launch cell and count it. The launch cells have room for four, and a fifth would land on the address of the next free cell.
@ $B68E label=test_shaded_graphic
  $B68E Is it the graphic that shades the cell one down and right of its top-left cell?
  $B690 Jump if not
  $B692 Draw it, then shade that cell as a lone shadow cell.
@ $B69D label=test_double_shadow
  $B69D Is it the graphic that casts a second shadow?
  $B69F Jump if not
  $B6A1 Draw it. In the other register set, fetch its size, and step one cell down and right from the cell below its bottom-left cell.
  $B6AF Cross into the next page of the attribute mirror.
@ $B6B0 label=cast_far_shadow
  $B6B0 Cast the second shadow there, one cell further from the graphic than its own shadow.
  $B6B4 Never runs: the cast returns straight to the caller of this routine.
@ $B6B5 label=test_shadow_cell
  $B6B5 Is it a lone shadow cell?
  $B6B7 Jump if not
  $B6B9,14 Shade the cell in full. It draws no graphic.
@ $B6C1 ssub=ADD A,(attr_mirror-$5800)/256
@ $B6C8 label=test_gate_graphic
  $B6C8 Is it the graphic of a coloured rectangle?
  $B6CA Jump if so, which never happens: that graphic number ends a layout first
  $B6CD Is it the graphic that stands while the sector's defence device stands?
  $B6CF If not, draw the graphic as it is
  $B6D2 Is the device destroyed?
  $B6D7 Return if so, and leave the graphic out
  $B6D8 Draw the graphic.
@ $B6DD label=draw_inner_graphic
N $B6DD The Skimmer is inside the hull.
  $B6DD Is it a hatchway?
  $B6DF Jump if so
  $B6E1 Is it the defence device?
  $B6E3 If not, draw the graphic as it is
  $B6E6 Is the device destroyed?
  $B6EC Return if so
  $B6ED Keep the cell, and point at the device's slot.
@ $B6F4 label=clear_device_slot
  $B6F4 Clear the slot.
  $B6F8,10 Set up the device at the cell. Copy its record into the slot, and draw it (#R$C204).
@ $B703 label=record_inner_hatchway
  $B703 Record the hatchway's cell, and draw it.
@ $B70B label=set_hostile_cell
c $B70B Set the current hostile object's cell
D $B70B Places the current hostile object at a cell, with the cell's screen address and attribute mirror address.
R $B70B I:B character row of the object's top-left cell, 0–23
R $B70B I:C column of the object's top-left cell, 0–31
  $B70B Record the cell, and find its screen address.
  $B715,8 Turn its attribute address into its attribute mirror address, and record that.
@ $B716 ssub=ADD A,(attr_mirror-$5800)/256
@ $B71E label=init_defence_device
c $B71E Set up the defence device
D $B71E Makes the current hostile object the current sector's defence device, at a cell. Its design comes from the sector's entry at #R$9520.
R $B71E I:B character row of the device's top-left cell
R $B71E I:C column of the device's top-left cell
  $B71E Place it at the cell. Its marks and its background store sit in the device's own slot.
  $B72D Mark it as the defence device, with the same value in its counter.
  $B735 Find the sector's design from the start of the designs, 48 bytes per sector.
  $B745 Never runs: no sector's design lies a page or more in.
@ $B746 label=device_design_addr
  $B746 The device draws its design as it is, with no shifted images.
  $B74D Start it at the left edge of its column, and make the step at #R$CC32 in the Skimmer's draw, which hostile objects share, do nothing.
@ $B751 ssub=LD ($CC32),A
  $B754,5 Choose the mark it toggles in the attribute mirror (#R$C80D).
@ $B756 ssub=LD ($C80D+1),A
@ $B75A label=find_device_flag
c $B75A Find the current sector's defence device flag
D $B75A Gives the address of the current sector's defence device flag.
R $B75A O:HL address of the flag
  $B75A Index the three flags by the sector.
  $B763 Return with the address.
  $B764,1 Never runs: the flags lie within one page.
u $B766 Unused bytes
@ $B769 label=unused_pattern_1
b $B769 Unused cell patterns
D $B769 Four 8×8 pixel patterns that nothing in the game draws.
N $B769 #UDGTABLE { #UDG$B769(unused_pattern_1) | #UDG$B771(unused_pattern_2) | #UDG$B779(unused_pattern_3) | #UDG$B781(unused_pattern_4) } TABLE#
B $B769,8
@ $B771 label=unused_pattern_2
B $B771,8
@ $B779 label=unused_pattern_3
B $B779,8
@ $B781 label=unused_pattern_4
B $B781,8
@ $B789 label=colour_rectangle
c $B789 Colour a rectangle of the screen
D $B789 Gives bright white paper and black ink to the rectangle of cells from the previous layout graphic's cell to this one. It never runs: the only jump to it needs the number that ends every layout.
R $B789 I:B character row of the rectangle's bottom-right cell
R $B789 I:C column of the rectangle's bottom-right cell
  $B789 Was the previous layout graphic the number that ends a layout too? Return if not.
  $B78F Find the attribute address of the previous graphic's cell, the rectangle's top-left corner.
  $B797 Measure the rectangle from that corner to this cell, both included.
  $B7A4 Colour each cell bright white paper and black ink, one row of attributes after another.
@ $B7AA label=colour_rect_row
  $B7AA Start a row of cells.
@ $B7AD label=colour_rect_cell
  $B7AD Colour the row's cells.
  $B7B1,5 Step down to the next row, until the rectangle is done.
@ $B7B7 label=shadow_cell
c $B7B7 Shade one cell
D $B7B7 Shades one cell of a shadow through one of the #R$B7DA(shadow masks). A cell below the screen's bottom row, or one whose marks in the attribute mirror keep shadows off, stays as it is.
R $B7B7 I:DE address of the shadow mask
R $B7B7 I:HL attribute mirror address of the cell, kept on return
  $B7B7 Does the cell carry a mark that keeps shadows off, such as a bright graphic's or a bar's? Return if so.
  $B7BB Is the cell below the screen's bottom row? Return if so.
@ $B7BC ssub=CP (attr_mirror+$300)/256
  $B7BF Find the cell's top pixel row.
@ $B7C5 label=shade_pixel_row
  $B7C5 Clear the pixels that each row of the mask leaves out, from the cell's top pixel row down.
  $B7CC,1 Recover the attribute mirror address.
@ $B7CE label=mirror_pixel_addr
c $B7CE Find a cell's pixel address from its attribute mirror address
D $B7CE Gives the screen address of the top pixel row of the cell at an attribute mirror address.
R $B7CE I:HL attribute mirror address of the cell
R $B7CE O:HL screen address of the cell's top pixel row
  $B7CE,11 The attribute page that matches the mirror's page gives the cell's screen third, which picks the high byte. The low byte stays as it is.
@ $B7CF ssub=SUB (attr_mirror-$5800)/256
@ $B7DA label=shadow_mask_full
b $B7DA Shadow masks
D $B7DA The pixel masks of the cells of a shadow, one byte per pixel row from the top. A set bit keeps its pixel, and a clear bit clears it.
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
D $B802 The cells that repeat along a #R$B3F0(horizontal bar) and down a #R$B3B0(vertical bar).
N $B802 #UDGTABLE { #UDG$B802,,4(bar_cell_h) | #UDG$B80A,,4(bar_cell_v) } { Horizontal bar | Vertical bar } TABLE#
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
@ $BC9E ssub=ADD A,(attr_mirror-$5800)/256
@ $BCB3 label=draw_pattern_column
c $BCB3 Draw a column of one pattern
D $BCB3 Draws one 8×8 pattern again and again down a column of character cells, coloured with #R$BD15.
@ $BCF4 ssub=ADD A,(attr_mirror-$5800)/256
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
B $BD18,1 Flags of the current layout record, 0–7, with 4–7 for a run to the next record's cell
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
@ $BEC2 ssub=SUB (attr_mirror-$5800)/256
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
@ $BF36 ssub=SUB (attr_mirror-$5800)/256
@ $BF6A label=find_hatch_graphic
c $BF6A Find the graphic for a step of the hatchway animation
D $BF6A Works out where the rows of the hatch's bitmap for one animation step start, and how many rows it shows?
@ $BF75 ssub=ADD A,hatch_bitmap%$100
@ $BF78 ssub=LD D,hatch_bitmap/$100
@ $BF80 ssub=ADD A,hatch_bitmap%$100
@ $BF83 ssub=LD H,hatch_bitmap/$100
@ $BF8B label=animate_hatchway
c $BF8B Step the hatchway animation
D $BF8B Every fourth call, draws the next step of the hatch as it opens or closes. It returns the step after that one, or zero once the animation is over?
@ $BFCF ssub=LD HL,skimmer_bg_store+$5E
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
@ $C1A6 ssub=ADD A,(attr_mirror-$5800)/256
@ $C204 label=add_hostile
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
@ $C4A0 ssub=SUB (attr_mirror-$5800)/256
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
@ $C9A6 ssub=LD DE,skimmer_bg_store+3
@ $C9AA ssub=LD HL,skimmer_cover_map+3
@ $C9B7 label=move_left_scroll
c $C9B7 Shift the Skimmer's background store one cell left
D $C9B7 Moves the Skimmer's screen position one cell left and saves the background of the column it enters.
@ $C9BA ssub=LD HL,skimmer_bg_store+$5E
@ $C9BD ssub=LD DE,skimmer_bg_store+$5F
@ $C9D2 label=store_left_px
@ $C9DA label=exit_screen_right
c $C9DA Flag an exit to the screen on the right
D $C9DA Flags that the Skimmer leaves the screen across its right edge.
@ $C9E0 label=move_skimmer_right
c $C9E0 Move the Skimmer right
D $C9E0 Moves the Skimmer right by its horizontal step. A blocked move turns it back, and the right edge of the screen flags an exit.
@ $C9FA ssub=LD DE,skimmer_bg_store+3
@ $CA07 label=move_right_px
@ $CA2B ssub=LD HL,skimmer_bg_store+1
@ $CA3D ssub=LD DE,skimmer_bg_store+3
@ $CA46 label=store_right_px
@ $CA4E label=exit_screen_top
c $CA4E Flag an exit to the screen above
D $CA4E Flags that the Skimmer leaves the screen across its top edge.
@ $CA54 label=move_skimmer_up
c $CA54 Move the Skimmer up
D $CA54 Moves the Skimmer up by its vertical step. A blocked move turns it back, and the top of the play area flags an exit.
@ $CA55 ssub=LD HL,skimmer_cover_map+$0C
@ $CA59 ssub=LD A,($D2B0+1)
@ $CA7D label=turn_skimmer_y
@ $CA86 label=move_up_row_clear
@ $CA87 ssub=LD HL,skimmer_cover_map+8
@ $CA8E label=move_up_px
@ $CAA4 label=move_up_line
@ $CAB1 label=move_up_source
@ $CAB1 ssub=LD HL,skimmer_bg_store+$58
@ $CABB ssub=LD HL,skimmer_bg_store+$50
@ $CABE label=move_up_draw
@ $CAC8 ssub=LD HL,skimmer_bg_store+$4F
@ $CAD0 label=move_up_small_step
@ $CAD0 ssub=LD HL,skimmer_bg_store+$57
@ $CAD6 label=move_up_scroll
@ $CAD6 ssub=LD DE,skimmer_bg_store+$5F
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
@ $CB40 ssub=LD HL,skimmer_bg_store+8
@ $CB45 label=move_down_big_step
@ $CB48 ssub=LD HL,skimmer_bg_store+$10
@ $CB4B label=move_down_scroll
@ $CB5D label=move_down_draw
@ $CB60 ssub=LD DE,skimmer_bg_store+$58
@ $CB67 ssub=LD DE,skimmer_bg_store+$50
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
D $CDE8 Fills the interrupt vectors so that every interrupt reaches the #R$CE26(flag routine), and switches to vectored interrupts.
  $CDE8 Hold off interrupts while the vectors change. Each vector takes the high byte of the interrupt jump, which is also its low byte.
@ $CDEC ssub=LD BC,int_jump/$100
@ $CDEF label=init_interrupts_fill
  $CDEF Fill the vectors, and the byte after them that a vector read at the last one also takes. Whatever byte the data bus holds, the vector leads to the interrupt jump.
  $CDF4 Make the interrupt jump lead to the flag routine.
@ $CDFA ssub=LD (HL),flag_interrupt%$100
@ $CDFD ssub=LD (HL),flag_interrupt/$100
@ $CDFF ssub=LD A,int_vectors/256
  $CDFF,7 Point the Z80 at the vectors, and switch to vectored interrupts.
@ $CE07 label=readouts_interrupt
c $CE07 Interrupt routine that updates the readouts
D $CE07 Runs the #R$D343(readout update) on each interrupt and keeps every register, and continues into the #R$CE26(flag routine).
  $CE07,14 Keep both register sets and the index registers.
  $CE18 Restore them.
@ $CE26 label=flag_interrupt
N $CE26 This entry point is the flag routine, which marks each interrupt at #R$D2AF(the interrupt flag).
  $CE26,7 Raise the flag.
@ $CE30 label=skimmer_cells_changed
c $CE30 Check whether the cells under the Skimmer changed
D $CE30 Compares the Skimmer's top-left cell in the attribute mirror with #R$D2BA(the saved cell). It also compares the rows and columns of cells under it with #R$D2BC(the saved span).
R $CE30 O:F zero set if the Skimmer covers the same cells
  $CE30 Does the low byte of the top-left cell's mirror address match the saved one?
  $CE37 Return if not
@ $CE38 ssub=LD A,($D2B8+1)
  $CE38 Does the high byte match too?
  $CE3D Return if not
  $CE3E Find the rows and columns of cells under the Skimmer. Does the number of columns match?
  $CE46 Return if not
  $CE47,3 Does the number of rows match? The zero flag gives the answer.
@ $CE4B label=colour_play_area_split
c $CE4B Colour the play area with a black left strip
D $CE4B Sets the play area to black on black in its left 11 columns and to white on black in the right 21.
R $CE4B I:HL attribute address of the play area's top-left cell
  $CE4B Colour each character row of the play area.
@ $CE4D label=split_colour_row
  $CE4D Start the row with black ink on black paper.
@ $CE51 label=split_colour_left
  $CE51 Colour the left strip.
  $CE55 Switch to white ink on black paper for the rest of the row.
@ $CE59 label=split_colour_right
  $CE59 Colour the rest of the row, which leaves the address at the next row's first cell.
  $CE5D,3 Move to the next row, until the play area is done.
@ $CE61 label=animate_flip
c $CE61 Step the Skimmer's flip animation
D $CE61 Every fourth call, advances the flip frame. After the third frame of the flip, it toggles the flipped state and switches to the Skimmer images for the new state.
R $CE61 I:A the flip's current frame, 1–3
R $CE61 I:HL address of #R$D2D1(the flip frame), with #R$D2D2(the flipped flag) after it
  $CE61 Keep the frame, and count the call. Is it a fourth one?
  $CE6B Return if not
  $CE6C Move to the next frame. Is the third frame over?
  $CE71 Jump if not
  $CE73 The flip is over. Clear the frame. Toggle the flipped state: does the Skimmer now fly the right way up?
  $CE7A Take its normal images, and keep them if so.
  $CE7F Take its flipped images.
@ $CE82 label=animate_flip_frames
  $CE82,3 Switch the Skimmer's draw to them.
@ $CE85 label=animate_flip_done
@ $CE86 label=row_first_screen
b $CE86 First screen number of each hull map row
D $CE86 One byte per row of the hull map: the number of the row's first screen. A screen's number is this byte plus its column.
B $CE86,11,1
@ $CE91 label=play_game
c $CE91 Play a game
D $CE91 Runs a game from a fresh score until the last shield goes or the Skimmer reaches the WALL DONE screen.
R $CE91 O:A $5E if the game ends on the WALL DONE screen, 1 if it ends with the last shield
  $CE91 Start with a full Damage Report Indicator, a score of zero and the Skimmer's normal images.
  $CE9A The Skimmer starts the right way up and at rest, square on its cell, with no controls in force, no push and no shot clicks.
  $CEB3 Set the horizontal step rates for a start at rest.
  $CEB9 Set the vertical ones too. The second clear of the vertical speed is redundant.
  $CEC3 Empty the four #R$F800(hostile object slots), and switch off the shot clicks of the Skimmer draw.
  $CED4 Put the Skimmer on its first cell.
@ $CEDB label=enter_screen
N $CEDB A move to the next screen starts the new screen here, and so does the trip into an inner section.
  $CEDB No hatchway animation runs on the new screen.
@ $CEDF label=enter_screen_hatchway
  $CEDF The trip out of an inner section starts its screen here, with the hatchway animation under way. Let each interrupt update the readouts while the screen draws.
@ $CEE0 ssub=LD HL,$CE07
@ $CEE3 ssub=LD (int_jump+1),HL
  $CEE7 Find the screen address of the Skimmer's top-left cell, and the cell's attribute mirror address.
@ $CEEF ssub=ADD A,(attr_mirror-$5800)/256
  $CEF9 Empty the #R$C909(animation list), and take away the pulse laser shot and the hostile objects' shot.
  $CF08 The new screen has no hatchway, launch cells or hits yet, and no shield loss is due or under way.
@ $CF0C ssub=LD ($D2C7+1),A
N $CF1B The sector follows from the screen's place on the hull map. Columns 0 and 1 make up sector 1. In the other columns, rows 5 to 10 make up sector 2 and rows 0 to 4 make up sector 3.
  $CF1B Start from the first sector.
  $CF1D Is the screen in the first sector? Jump if so.
  $CF24 Take the second sector. Is the screen in its rows? Jump if so.
  $CF2C Take the third sector.
@ $CF2D label=store_sector
  $CF2D Keep the sector and show it on the control panel. Then fill the play area with the sector's hull surface.
  $CF3A Make the play area's colour white ink on black paper.
@ $CF3C ssub=LD ($B87A+1),A
  $CF3F Keep the screen's column on the hull map. Is it the left column?
  $CF48 Jump if not
  $CF4A Colour the play area with a black strip on its left, and skip the plain colour.
@ $CF4F label=colour_whole_area
  $CF4F Colour the whole play area.
@ $CF52 label=clear_play_marks
  $CF52 Clear the attribute mirror's marks over the play area.
@ $CF53 ssub=LD ($B87A+1),A
@ $CF56 ssub=LD HL,attr_mirror+$C0
  $CF5C Look up the number of the screen at the left end of this hull map row.
@ $CF5F ssub=ADD A,row_first_screen%$100
@ $CF62 ssub=LD H,row_first_screen/$100
@ $CF67 label=add_screen_column
  $CF67 Add the screen's column to give its number, and draw the screen.
  $CF6F Let each interrupt set the interrupt flag and do nothing more.
@ $CF70 ssub=LD HL,$CE26
@ $CF73 ssub=LD (int_jump+1),HL
  $CF77 Did the screen end the game on WALL DONE?
  $CF7C Jump if not
  $CF7E,2 Report the end on the WALL DONE screen.
@ $CF81 label=place_skimmer
  $CF81 Put the Skimmer on the new screen. Save what lies behind it, map its cover and draw it, then mark its cells in the attribute mirror.
  $CF8D Start the hostile objects' hold count.
@ $CF92 label=play_loop
N $CF92 The play loop. Each pass waits for an interrupt, so the game runs at most one pass for each interrupt.
  $CF92 Turn the border black and the speaker off, and watch the interrupt flag.
@ $CF98 label=wait_interrupt
  $CF98 Wait for the next interrupt.
  $CF9C Clear the flag for the next one.
  $CF9E Handle the fire key. It ignores the value in #REGa.
  $CFA3 Let the Skimmer draw click the speaker while a pulse laser shot's clicks run.
@ $CFA6 ssub=LD ($CC0A+1),A
  $CFA9 Did the Damage Report Indicator run out, so that a shield loss is due? The first load has no effect.
  $CFB0 Jump if not
@ $CFB2 ssub=LD A,($D2B0+1)
  $CFB2 Does the Skimmer sit off the cell grid, by a pixel row or a horizontal offset?
  $CFBC Jump if so, to let it move on to a cell.
  $CFBE Run the shield loss. Did it take the last shield? Return if so.
@ $CFC7 label=check_hatchway
  $CFC7 Is the hatchway animation under way?
  $CFCC Jump if not
  $CFCE Is the Skimmer about to leave an inner section?
  $CFD0 Jump if not
  $CFD2 Make the hatch open over the Skimmer, and take the Skimmer out to the outer hull.
  $CFDF Empty the four #R$F800(hostile object slots), and enter the outer hull's screen with the animation under way.
@ $CFF0 label=test_rise_start
  $CFF0 Does the hatch start to open over the Skimmer?
  $CFF2 Jump if not
  $CFF4 Point at the Skimmer's background store.
@ $CFF9 label=clear_store_byte
  $CFF9 Blank the store, so that the Skimmer first draws over black.
@ $CFFE label=run_hatchway_step
  $CFFE Run the animation, which hands back the step to run next.
  $D001 Did the hatch close over the Skimmer on its trip in?
  $D003 Jump if not
  $D005 Pause, then enter the inner section's screen with the four #R$F800(hostile object slots) empty.
@ $D01E label=keep_hatchway_step
  $D01E Keep the next step. The Skimmer holds its place while the animation runs.
@ $D024 label=check_flip
  $D024 Does a flip run?
  $D02A Jump if not
  $D02C Run the flip animation, and redraw the Skimmer where it stands.
@ $D032 label=step_skimmer
N $D032 The Skimmer moves, one axis after the other. An axis whose mask is 1 flips its phase on each pass, and steps only on the passes that leave the phase at 0. An axis whose mask is 0 can step on every pass.
  $D032 Note the cells under the Skimmer before it moves.
  $D03F No step and no exit yet.
  $D046 Flip the vertical phase. Does it skip the vertical step now?
  $D050 Jump if so
  $D052 Is the vertical speed zero?
  $D057 Jump if so
  $D059 Move the Skimmer down for a negative vertical speed.
@ $D062 label=y_step_up
  $D062 Move it up for a positive one.
@ $D065 label=y_step_done
  $D065 Map the Skimmer's cover again if the step changed its cells.
  $D06B Flip the horizontal phase. Does it skip the horizontal step now?
  $D075 Jump if so
  $D077 Is the horizontal speed zero?
  $D07C Jump if so
  $D07E Move the Skimmer right for a negative horizontal speed.
@ $D087 label=x_step_left
  $D087 Move it left for a positive one.
@ $D08A label=check_screen_exit
N $D08A A step across an edge of the screen leads to the next screen on the hull map. At an edge of the hull map it leads nowhere, and the Skimmer stays at the edge of its screen.
  $D08A Did the Skimmer cross an edge of the screen?
  $D08F Jump if not
  $D092 Did it leave on the left?
  $D094 Jump if not
  $D096 Is the screen in the hull map's left column?
  $D09B Jump if so
  $D09D Enter the screen on the left, with the Skimmer at its right edge.
@ $D0A9 label=leave_right
  $D0A9 Did it leave on the right?
  $D0AB Jump if not
  $D0AD Is the screen in the hull map's right column?
  $D0B2 Jump if so
  $D0B4 Enter the screen on the right, with the Skimmer at its left edge.
@ $D0C0 label=leave_top
  $D0C0 Did it leave at the top?
  $D0C2 Jump if not
  $D0C4 Is the screen in the hull map's top row?
  $D0C9 Jump if so
  $D0CB Enter the screen above, with the Skimmer at the bottom of its play area.
@ $D0D7 label=leave_bottom
  $D0D7 Did it leave at the bottom?
  $D0D9 Jump if not
  $D0DB Is the screen in the hull map's bottom row?
  $D0E0 Jump if so
  $D0E2 Enter the screen below, with the Skimmer at the top of its play area.
@ $D0EE label=redraw_skimmer
  $D0EE Did the Skimmer take a step?
  $D0F3 Jump if not
  $D0F5 Keep the cover map if the Skimmer still lies over the same cells.
@ $D0FA label=remap_cover
  $D0FA Map the cells that hide the Skimmer afresh.
@ $D0FD label=show_skimmer
  $D0FD Draw the Skimmer. Then toggle its mark in the attribute mirror, over the cells it stood on and then over the cells it stands on. Over cells in both sets the two toggles cancel out, so the mark moves with the Skimmer.
@ $D10D label=play_loop_update
  $D10D Stop the Skimmer draw's clicks.
@ $D10F ssub=LD ($CC0A+1),A
N $D112 Every pass runs the rest, the passes of the hatchway animation too.
  $D112 Count down the clicks of a pulse laser shot. When they end, switch off their click row too.
@ $D120 label=run_tasks
  $D120 Clear the speaker byte. No routine of the pass reads #REGa, so each load into it before a call has no effect.
  $D138 Keep the controls in force.
  $D13B Start the Skimmer's movement flag from the direction controls held.
  $D141 Is the Skimmer square on a cell column?
  $D146 Jump if not
  $D148 Is a shield loss due?
  $D14D Jump if not
  $D150 Slow the Skimmer as if no control were held.
@ $D154 label=steer_x
  $D154 Is left held?
  $D15A Jump if not
  $D15C Is right held too? Then the two cancel out.
  $D15E Jump if so
  $D160 Gain a unit of speed to the left, to at most the top speed.
@ $D169 label=steer_x_right
  $D169 Is right held?
  $D16B Jump if not
  $D16D Gain a unit of speed to the right, to at most the top speed.
@ $D175 label=slow_x
  $D175 Is the Skimmer at rest on this axis already?
  $D178 Jump if so
  $D17A Take two off a positive speed.
@ $D17F label=slow_x_inc
  $D17F Add one. Either way the speed ends a unit nearer zero.
@ $D180 label=set_speed_x
  $D180 Set the horizontal speed and its rates.
  $D18A Halve the step: the rates give it in pixels, and the horizontal offset counts steps of 2 pixels.
@ $D191 label=check_y_aligned
@ $D191 ssub=LD A,($D2B0+1)
  $D191 Is the Skimmer square on a cell row?
  $D196 Jump if not
  $D198 Is a shield loss due?
  $D19D Jump if not
  $D1A0 Slow the Skimmer as if no control were held.
@ $D1A4 label=steer_y
  $D1A4 Is up held?
  $D1AA Jump if not
  $D1AC Is down held too? Then the two cancel out.
  $D1AE Jump if so
  $D1B0 Gain a unit of speed upward, to at most the top speed.
@ $D1B8 label=steer_y_down
  $D1B8 Is down held?
  $D1BA Jump if not
  $D1BC Gain a unit of speed downward, to at most the top speed.
@ $D1C4 label=slow_y
  $D1C4 Is the Skimmer at rest on this axis already?
  $D1C7 Jump if so
  $D1C9 Take two off a positive speed.
@ $D1CE label=slow_y_inc
  $D1CE Add one. Either way the speed ends a unit nearer zero.
@ $D1CF label=set_speed_y
  $D1CF Set the vertical speed and its rates. The store of the speed into the step has no effect, since the rates overwrite it at once.
@ $D1DA label=try_flip
  $D1DA Add the Skimmer's offsets in its cell to its movement flag. Is it moving, or off the cell grid?
@ $D1E2 ssub=LD A,($D2B0+1)
  $D1EB Jump if so
  $D1ED Is a flip under way already?
  $D1F3 Jump if so
  $D1F5 Is flip held?
  $D1F7 Jump if not
  $D1F9 Look through the cover map's top-left nine cells, three rows of three.
@ $D201 label=scan_cover_row
  $D201 Start a row.
@ $D203 label=scan_cover_cell
  $D203 Does the cell hide the Skimmer? Then the flip cannot start.
  $D206 Move along the row.
  $D209 Skip the fourth column, and move down to the next row.
  $D20D Start the flip from its first frame.
@ $D215 label=flip_blocked
  $D215 A cell hides the Skimmer. Drop the saved counts.
@ $D216 label=next_pass
  $D216 Start the next pass.
@ $D219 label=set_speed_rates
c $D219 Set the step rates of a Skimmer speed
D $D219 Sets one axis's step size and step mask from the Skimmer's speed on it, and counts a moving axis at #R$D2D3(the movement flag). While no push runs, a flipped Skimmer takes the rates of the next slower speed.
R $D219 I:A the Skimmer's speed on the axis, −3 to 3, with its sign for the direction
R $D219 I:HL address of the axis's step size, with its step mask and its step phase after it
  $D219 Is the speed zero or more?
  $D21B Jump if so
  $D21D Take its size.
@ $D21F label=rates_check_speed
  $D21F Is the Skimmer at rest on this axis?
  $D221 Jump if so
  $D223 Keep the step address, and count this axis as moving.
  $D228 Keep the speed. Is a push on the Skimmer under way?
  $D22F Jump if so
  $D231 A flipped Skimmer drops to the next slower speed. Speed 0's rates match speed 1's, so a flipped Skimmer at speed 1 keeps its pace.
@ $D235 label=rates_restore_addr
  $D235 Recover the step address.
@ $D236 label=rates_lookup
  $D236 Find the speed's record in the #R$D2A6(speed rates), 2 bytes per speed.
@ $D239 ssub=ADD A,speed_rates%$100
@ $D23C ssub=LD A,speed_rates/$100
  $D241,8 Store the step size, and the step mask twice: as the mask, and as the phase that starts it.
@ $D24A label=lose_shield
c $D24A Lose a shield
D $D24A Once the Damage Report Indicator runs out, advances a shield loss by one stage every fourth call, or every eighth with one shield left. Its eighth stage takes away a shield, fills the indicator again and ends the game when it takes the last shield.
  $D24A Count the call.
  $D24E The loss moves on every fourth call. Is this the last shield?
  $D255 Jump if not
  $D257 With one shield left, it moves on every eighth call.
@ $D259 label=loss_stage_due
  $D259 Is it time for the next stage?
  $D25B Return if not
  $D25C Move the loss on by one stage. Is it past its last stage?
  $D261 Return if not
  $D262 The loss is over. Clear its stage and #R$D48D(the shield loss flag), and refill the indicator and show it.
  $D26D Take away a shield. Was it the last one?
  $D271 Jump if not
  $D273,5 End the game, and show that no shields are left.
@ $D279 label=blink_shields
  $D279 Draw the Skimmer whole again, and blink the shield count.
@ $D27E label=blink_shields_loop
  $D27E Show the count, and wait. Hide it with black ink on black paper in its cell, and wait again.
  $D28E,3 Leave the count shown.
@ $D292 label=fill_damage_report
c $D292 Fill the Damage Report Indicator
D $D292 Sets the Damage Report Indicator to 999.
  $D292 Start at the indicator's first digit.
@ $D297 label=fill_damage_digit
  $D297,5 Set each digit to 9.
@ $D29D label=pause
c $D29D Pause
D $D29D Waits about 0.3 s at the 3.5 MHz clock in a busy loop.
  $D29D Count 256 rounds.
@ $D29F label=pause_count
  $D29F Count #REGl down to zero, from 256 in each round after the first.
  $D2A2,3 Start the next round, until the last one ends.
@ $D2A6 label=speed_rates
b $D2A6 Skimmer speed rates
D $D2A6 One record of two bytes for each Skimmer speed, from speed 0 to speed 3. The first byte is the size of one step in pixels, on either axis. The second is 1 for a step on every second pass of the play loop, or 0 for a step on every pass.
B $D2A6,8,2
u $D2AE Unused bytes
@ $D2AF label=interrupt_flag
g $D2AF Play loop variables
D $D2AF The Skimmer's place, speed and animations on the current screen, and the timers that the play loop keeps.
B $D2AF,1 $FF from an interrupt until the play loop takes it, 0 otherwise
@ $D2B0 label=skimmer_scr_addr
W $D2B0,2 Screen address of the Skimmer's top-left byte, in its top pixel row
@ $D2B2 label=skimmer_x_shift
B $D2B2,1 Horizontal offset of the Skimmer in its cell, 0–3, in steps of 2 pixels
@ $D2B3 label=skimmer_stepped
B $D2B3,1 Number of steps the Skimmer took on the latest pass of the play loop, 0–2
@ $D2B4 label=control_bits
N $D2B4 The controls in force take one bit each, set while the control is held. #TABLE(default) { =h Bit | =h Control } { 0 | Right } { 1 | Left } { 2 | Down } { 3 | Up } { 4 | Fire } { 5 | Flip } TABLE#
B $D2B4,1 Controls in force, one bit for each control
@ $D2B5 label=speaker_byte
B $D2B5,1 Byte that the speaker clicks send to the border and speaker port, with its speaker bit flipped at each click
@ $D2B6 label=skimmer_column
B $D2B6,1 Column of the Skimmer's top-left cell, 0–29
@ $D2B7 label=skimmer_row
B $D2B7,1 Character row of the Skimmer's top-left cell, 6–21
@ $D2B8 label=skimmer_mirror_addr
W $D2B8,2 Attribute mirror address of the Skimmer's top-left cell
@ $D2BA label=old_mirror_addr
W $D2BA,2 Attribute mirror address of the Skimmer's top-left cell before its latest step
@ $D2BC label=old_skimmer_span
B $D2BC,2 Columns, then rows, of the cells under the Skimmer before its latest step, 3 or 4 each
@ $D2BE label=screen_exit
B $D2BE,1 Edge that the Skimmer crossed: 0 for none, 1 for the left, 2 for the right, 3 for the top, 4 for the bottom
@ $D2BF label=speed_x
B $D2BF,1 Horizontal speed of the Skimmer, from 3 for the fastest to the left through 0 at rest to −3 for the fastest to the right
@ $D2C0 label=speed_x_step
B $D2C0,1 Size of one horizontal step, 1 or 2 steps of 2 pixels
@ $D2C1 label=speed_x_mask
B $D2C1,1 1 when the Skimmer steps horizontally on every second pass, 0 when it steps on every pass
@ $D2C2 label=speed_x_phase
B $D2C2,1 Phase of the horizontal step, 0 on a pass that steps and 1 on a pass that skips the step
@ $D2C3 label=speed_y
B $D2C3,1 Vertical speed of the Skimmer, from 3 for the fastest upward through 0 at rest to −3 for the fastest downward
@ $D2C4 label=speed_y_step
B $D2C4,1 Size of one vertical step, 2 or 4 pixel rows
@ $D2C5 label=speed_y_mask
B $D2C5,1 1 when the Skimmer steps vertically on every second pass, 0 when it steps on every pass
@ $D2C6 label=speed_y_phase
B $D2C6,1 Phase of the vertical step, 0 on a pass that steps and 1 on a pass that skips the step
@ $D2C7 label=hatchway_cell
W $D2C7,2 Column, then row, of the top-left cell of the hatchway on the current screen, both 0 for none
@ $D2C9 label=hatchway_step
N $D2C9 A step of the hatchway animation runs from 1 to 13 in its low four bits, and its high four bits name the phase. #TABLE(default) { =h Step | =h Phase } { 0 | None } { $01–$0D | The hatch opens under the Skimmer } { $11–$1D | The hatch closes under the Skimmer } { $21–$2D | The hatch opens over the Skimmer } { $31–$3D | The hatch closes over the Skimmer } { $EE | The Skimmer starts to leave an inner section } TABLE#
B $D2C9,1 Step of the hatchway animation, 0 when none runs
@ $D2CA label=anim_divider
B $D2CA,1 Pass count of the hatchway or flip animation, of which only the low two bits matter
@ $D2CB label=push_time
B $D2CB,1 Passes of the play loop left in a push on the Skimmer, 0 when no push runs
@ $D2CC label=hostile_hold_time
B $D2CC,1 Hold count of the hostile objects, $FE or $FF during a hold and 0 with none
@ $D2CD label=shot_click_row
B $D2CD,1 First pixel row of a cell at which the Skimmer draw clicks the speaker, 0 for every row and $FE or $FF for none
@ $D2CE label=shot_click_time
B $D2CE,1 Passes of the play loop left in the clicks of a pulse laser shot, 0 when none run
@ $D2CF label=skimmer_image_set
W $D2CF,2 Address of the entries of #R$CD9C(the Skimmer images) in use, normal or flipped
@ $D2D1 label=flip_step
B $D2D1,1 Frame of the flip animation, 1–3, or 0 when no flip runs
@ $D2D2 label=flipped
B $D2D2,1 1 while the Skimmer flies flipped, 0 while it flies the right way up
@ $D2D3 label=skimmer_moving
B $D2D3,1 0 while the Skimmer rests square on a cell with no speed and no direction held, any other value otherwise
@ $D2D4 label=shield_loss_step
B $D2D4,1 Stage of a shield loss, 0–7, with 0 when no shield loss runs
@ $D2D5 label=shield_loss_ticks
B $D2D5,1 Pass count of the shield losses, 0–255
@ $D2D6 label=print_readout
c $D2D6 Print a control panel number
D $D2D6 Prints a run of digits in inverse video at a character cell of the control panel.
R $D2D6 I:B character row of the first digit
R $D2D6 I:C column of the first digit
R $D2D6 I:D number of digits
R $D2D6 I:HL address of the first digit, in the form #R$D2E6(the digit printer) takes
  $D2D6 Find the screen address of the first digit's cell, and keep it in the other register set for the digit printer.
  $D2DC Fetch the number of digits and the address of the first.
@ $D2DE label=readout_digit
  $D2DE,7 Print each digit, from left to right.
@ $D2E6 label=print_inverse_digit
c $D2E6 Print one control panel digit
D $D2E6 Prints one digit in inverse video, rolled partway on toward the next digit by its eighths, and moves to the next cell on the right.
R $D2E6 I:A the digit, as 8 times its value plus its eighths toward the next digit
R $D2E6 I:HL' screen address of the digit's cell
R $D2E6 O:HL' screen address of the next cell on the right
  $D2E6 Switch to the screen address.
N $D2E7 The font holds the digits 0 to 9 and a second 0 after the 9, 8 bytes per glyph. A digit's byte is the offset of its glyph, plus its eighths. The eighths start the draw lower in the glyph and finish it in the top rows of the next glyph. So a digit rolls up its cell as its eighths grow, and a 9 rolls on into a 0.
  $D2E7 Point at the digit's pixel rows in the font.
  $D2EF Keep the cell's screen address, and walk its pixel rows from the top.
@ $D2F2 label=inverse_pixel_row
  $D2F2 Copy each pixel row onto the screen, inverted.
  $D2F9,3 Move one cell right, and switch the register sets back.
@ $D2FD label=add_score_digits
c $D2FD Add to the score digits
D $D2FD Adds a number held as decimal digits to the score, digit by digit.
N $D2FD Each digit counts in eighths, as #R$D2E6(the digit printer) draws them. While a digit rolls on from 9 to 0, the digit on its left rolls on with it by as many eighths. #REGc carries this into the next digit. It holds the eighths of the digit that rolls, or a whole unit when a digit reaches 10 and starts again from 0.
R $D2FD I:B number of digits
R $D2FD I:DE address of the score's last digit
R $D2FD I:HL address of the last digit of the number to add
  $D2FD The last digit keeps its own eighths.
@ $D301 label=add_digit
  $D301 Add the digit of the number and the carry to the whole digit.
  $D306 Does the digit reach 10?
  $D30A Jump if not
  $D30C Start it again from 0, and carry a whole unit.
@ $D310 label=add_store_digit
  $D310 Store the digit. Is it past 9, on its way to 0?
  $D313 Jump if not
  $D315 Let the next digit roll with it.
@ $D319 label=add_next_digit
  $D319,4 Move to the next digit on the left.
@ $D31E label=subtract_damage_digits
c $D31E Subtract from the Damage Report Indicator
D $D31E Takes a number held as decimal digits away from the Damage Report Indicator, digit by digit.
N $D31E Each digit counts in eighths, as #R$D2E6(the digit printer) draws them. While a digit rolls back from 0 to 9, the digit on its left rolls back with it by as many eighths. #REGc is the borrow. It holds 7 less the eighths that the digit which rolls has still to fall, or 8 at the moment a digit drops under 0.
N $D31E A digit that drops under 0 always lands one eighth short of 10, however far under 0 it goes. So a drain of more than one eighth takes less than its full step whenever the last digit rolls back.
R $D31E I:B number of digits
R $D31E I:DE address of the indicator's last digit
R $D31E I:HL address of the last digit of the number to take away
R $D31E O:C 8 if the indicator drops under zero
  $D31E Set the borrow so that the last digit keeps its own eighths.
@ $D324 label=drain_digit
  $D324 Take the digit of the number and the borrow away from the digit.
  $D329 Jump unless it drops under 0
  $D32C Roll it back to one eighth short of 10.
@ $D32E label=drain_store_digit
  $D32E Store the digit, and start with no borrow. Is the digit under 9?
  $D333 Jump if so
  $D335 The digit rolls back from 0: hand its eighths on to the next digit. Is it just one eighth short of 10?
  $D33A Jump if not
  $D33C Start the next digit on its roll back by a whole unit.
@ $D33E label=drain_next_digit
  $D33E,4 Move to the next digit on the left.
@ $D343 label=update_readouts
c $D343 Update the Damage Report Indicator and the score
D $D343 Runs the Damage Report Indicator down, faster while a push on the Skimmer runs, and starts a shield loss when it drops under zero. It also prints the indicator and counts the points still due into the score, one step per call.
  $D343 Take the slow drain for the indicator. Is a push on the Skimmer under way?
  $D34E Jump if not
  $D350 Take the fast drain instead.
@ $D353 label=drain_indicator
  $D353 Run the indicator down. Does it drop under zero?
  $D35B Jump if not
  $D35D Hold the indicator at zero, from its first digit.
@ $D363 label=zero_indicator_digit
  $D363 Clear each digit.
  $D367 Is a shield loss under way already?
  $D36C Jump if so
  $D36E Start one.
@ $D372 label=show_readouts
N $D372 This entry point prints the indicator and counts the score on, with no drain.
  $D372 Print the indicator.
N $D37D The points still due wait at #R$D48A(the points due), in eighths of a point. Each call moves them into #R$D488(the step count), and adds one step to the score. A step starts at one eighth. While 256 steps or more are left and their count is even, a call doubles the step and halves the count. So a big award counts in faster, at up to four points a step.
  $D37D Is any step left?
  $D382 Jump if so
  $D384 None is left. Go back to a step of one eighth, and add nothing this call.
@ $D38F label=score_steps_left
  $D38F Are 256 steps or more left?
  $D392 Jump if not
  $D394 Is the count even?
  $D396 Jump if not
  $D398 Is the step under four points?
  $D39E Jump if not
  $D3A0 Halve the count, double the step, and count the times the step doubled.
@ $D3AD label=score_one_step
  $D3AD Spend one step, and add it to the score.
  $D3BC Print the score.
@ $D3C7 label=take_points_due
  $D3C7 Fetch the points due and the times the step doubled. Is the step still one eighth?
  $D3D0 Jump if so
  $D3D2 Halve once for each time the step doubled.
@ $D3D3 label=divide_points_due
  $D3D3 Divide the points due by the step.
@ $D3D9 label=add_whole_steps
  $D3D9 Add the whole steps to the count. Is the step one eighth?
  $D3E4 Jump if so
  $D3E6 Double once for each time the step doubled.
@ $D3E7 label=steps_to_eighths
  $D3E7 Turn the whole steps back into eighths.
@ $D3ED label=keep_points_left
  $D3ED,9 Take them off the points due, which keeps what is left over.
@ $D3F7 label=add_points
c $D3F7 Add points to the score
D $D3F7 Adds an award to #R$D48A(the points due), which the readout update counts into the score a step at a time.
R $D3F7 I:DE award, in eighths of a point
R $D3F7 O:HL unchanged
  $D3F7,9 Add the award to the points due.
@ $D401 label=reset_score
c $D401 Reset the score
D $D401 Fills the Damage Report Indicator, sets the score to zero with no points due, and prints the score.
  $D404 Start at the score's first digit.
@ $D409 label=clear_score_byte
  $D409 Clear the score's digits, and the points due and the step count after them.
  $D40E,11 Print the score.
@ $D41A label=step_animations
c $D41A Step the animated graphics
D $D41A Advances the timers of the animated graphics in the #R$C909(animation list). It draws the next frame of the first graphic whose timer reaches its frame length.
  $D41A Start at the first animated graphic.
@ $D41D label=anim_entry
  $D41D Is it the end of the list?
  $D420 Jump if so
  $D422 Count the call on the graphic's timer. Is the current frame's time up?
  $D427 Jump if not
  $D429 Move to the next frame. Is it past the last one?
  $D431 Jump if not
  $D433 Go back to the first frame, and fetch its address.
@ $D43D label=anim_step_frame
  $D43D Step on from the current frame's address to the next frame's.
@ $D447 label=anim_store_frame
  $D447 Store the new frame's address.
  $D44F Fetch the graphic's size and its screen address.
  $D45A Draw the frame with no mask, and leave the colours and marks of its cells as they are.
  $D462,3 Restart the timer. The graphics after this one in the list wait for the next call.
@ $D466 label=anim_wait
  $D466 Store the timer, and move to the next graphic, 13 bytes per entry.
  $D46E,4 Cross into the next page.
@ $D472 label=anim_done
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
@ $F800 label=hostile_slots
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
