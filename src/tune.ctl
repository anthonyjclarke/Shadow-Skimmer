; The title tune player as the game runs it: the bytes from $F009 to $F309 once
; crypt_title_tune ($F45F) has decrypted them. tools/tune_player.py writes them
; to build/tune_player.bin, and the Makefile disassembles that file with this
; control file into build/tune.skool, the "tune" code of the site (src/tune.ref).
; Addresses are the game's own, so they match the main listing.
@ $F009 rom
@ $F009 label=perform_title_tune
c $F009 Title tune player
D $F009 Plays the title tune: its introduction once, then its two parts over and over until the player presses a key. It encrypts itself again before it returns.
N $F009 #TABLE(default) { =h Stage | =h Played by | =h Data } { Introduction | #R$F0A2, #R$F06C | #R$F043 to #R$F05C } { First part | #R$F104 | #R$F1BF } { Bridge | #R$F06C | #R$F065 } { Second part | #R$F104 | #R$F30A@main(the title tune notes) } { Noise run | #R$F0E2 | ROM bytes } TABLE#
N $F009 After the noise run the tune starts again at its first part. A key stops it at the end of any note of the two parts.
  $F009 Play the introduction: a three-tone slide, a two-tone slide, then two more three-tone slides.
@ $F021 label=tune_repeat
  $F021 Play the first part. Did the player press a key?
  $F028 If so, stop.
  $F02A Play the bridge, a two-tone slide.
  $F030 Play the second part, whose notes follow the first part's in #R$F30A@main(the title tune notes). Did the player press a key?
  $F037 If so, stop.
  $F039 Play the noise run, then the tune again from its first part.
@ $F040 label=tune_done
  $F040 Encrypt the player again. The crypt routine returns to the player's caller.
@ $F043 label=intro_slides_1
b $F043 Title tune slides
D $F043 The slides of the title tune's introduction and of its bridge. A byte of 0 ends each list of slides.
N $F043 A slide plays its tones over a number of steps of equal length. At each step every tone's period changes by its own amount.
N $F043 A three-tone slide is a record of 8 bytes, which #R$F0A2 plays.
N $F043 #TABLE(default) { =h Byte | =h Holds } { 0 | Length of each step, in units of 256 passes of #R$F154 (0 ends the list) } { 1 | Period of the first tone } { 2 | Amount added to the first tone's period before each step } { 3–4 | Period and amount of the second tone } { 5–6 | Period and amount of the third tone } { 7 | Number of steps } TABLE#
N $F043 A two-tone slide is a record of 6 bytes, which #R$F06C plays.
N $F043 #TABLE(default) { =h Byte | =h Holds } { 0 | Length of each step, in units of 256 passes of #R$F11E (0 ends the list) } { 1 | Period of the first tone } { 2 | Amount added to the first tone's period after each step } { 3–4 | Period and amount of the second tone } { 5 | Number of steps } TABLE#
B $F043,8 Introduction, three-tone slide
B $F04B,1 End of the list
@ $F04C label=intro_slides_2
B $F04C,6 Introduction, two-tone slide
B $F052,1 End of the list
@ $F053 label=intro_slides_3
B $F053,8 Introduction, three-tone slide
B $F05B,1 End of the list
@ $F05C label=intro_slides_4
B $F05C,8 Introduction, three-tone slide
B $F064,1 End of the list
@ $F065 label=bridge_slides
B $F065,6 Bridge, two-tone slide
B $F06B,1 End of the list
@ $F06C label=play_two_tone_slides
c $F06C Play a list of two-tone slides
D $F06C Plays each two-tone slide of a list in turn.
R $F06C I:HL address of the list's first slide, laid out as #R$F043 shows
  $F06C Read the length of each step. Is it 0?
  $F06F If so, the list is over.
  $F070 Take the start periods, the amounts and the number of steps. Keep the address of the next slide.
@ $F080 label=two_tone_step
  $F080 Play one step at the current periods.
  $F089 Add each tone's amount to its period, ready for the next step.
  $F093 Next step.
  $F097 Next slide.
@ $F09A label=slide_copy
g $F09A Three-tone slide in play
D $F09A The three-tone slide in play. #R$F0A2 copies each slide here before it plays it. The record layout is at #R$F043.
B $F09A,1 Length of each step
@ $F09B label=slide_periods
B $F09B,6,2 Periods of the first, second and third tones, each followed by its amount
@ $F0A1 label=slide_steps_left
B $F0A1,1 Steps left to play
@ $F0A2 label=play_three_tone_slides
c $F0A2 Play a list of three-tone slides
D $F0A2 Plays each three-tone slide of a list in turn.
R $F0A2 I:HL address of the list's first slide, laid out as #R$F043 shows
  $F0A2 Copy the next slide into the slide in play, so its steps leave the tune's data as it is. Point to the slide after it.
  $F0AA Is the length of each step 0?
  $F0AE If so, the list is over.
  $F0AF Keep #REGix and #REGiy, which the three-tone loop takes over, and the address of the next slide.
@ $F0B4 label=three_tone_step
  $F0B4 Add each tone's amount to its period, and take the three new periods.
  $F0C3 Play one step at those periods.
  $F0CA Next step.
  $F0D3 Next slide.
@ $F0DA label=step_slide_period
c $F0DA Step a period of the slide in play
D $F0DA Adds a tone's amount to its period in #R$F09A(the slide in play).
R $F0DA I:HL address of the period (its amount follows it)
R $F0DA O:A the new period
R $F0DA O:HL address of the next tone's period
  $F0DA,7 Store the period plus its amount, wrapped to a byte.
@ $F0E2 label=play_noise_run
c $F0E2 Play the noise run
D $F0E2 Plays the noise run that closes each round of the title tune.
N $F0E2 Each pulse takes the next byte of the ROM. Times run from one OUT to the next. Pulse n holds the speaker high for 40 × n + 24 × m + 16 T-states, where m is its ROM byte (0 counts as 256). It then holds the speaker low for 40 × n + 43 T-states.
R $F0E2 I:D number of pulses
  $F0E2 Start with the shortest pulse and its ROM byte.
@ $F0E7 label=noise_pulse
  $F0E7 Raise the speaker.
  $F0EB Hold it high, one tick for each pulse so far, this one included.
@ $F0EC label=noise_high_wait
  $F0EC One tick: a call to the bare RET and the jump back.
  $F0F1 Hold it longer by the ROM byte.
@ $F0F2 label=noise_rom_wait
  $F0F2 The ROM ignores the write, so this only burns time.
  $F0F5 Lower the speaker.
  $F0F8 Hold it low, one tick for each pulse so far.
@ $F0F9 label=noise_low_wait
  $F0F9 One tick.
  $F0FE,5 Move on to the next ROM byte, make the next pulse longer, and play it if any are left.
@ $F103 label=noise_tick
@ $F104 label=play_tune_part
c $F104 Play a part of the title tune
D $F104 Plays the notes of a part of the title tune to its end, or until the player presses a key. The note format is at #R$F30A@main(the title tune notes).
R $F104 I:HL address of the part's first note
R $F104 O:C 0 at the end of the part, or 255 when the player presses a key
  $F104 Read the note. Is its length 0?
  $F10B If so, the part is over.
  $F10C Play the note's two tones for its length. Keep the address of the next note.
  $F114 Read the keyboard with the ROM's KEY-SCAN: #REGe holds 255 while no key is down, shift keys included.
  $F117 Set the result for a key press.
  $F11A Return if any key is down.
  $F11C Next note.
@ $F11E label=play_two_tones
c $F11E Play two tones
D $F11E Plays two tones on the speaker at once for a given length.
N $F11E Each tone keeps its own level and its own counter of passes. Each pass sends both levels to the speaker in turn, the first tone's then the second's. A tone's level flips once its counter runs out.
N $F11E Every pass takes 96 T-states, except the last of each unit of length, which takes 97. The two levels go out 48 T-states apart, so each tone has the speaker for half the time. A tone of period P sounds at 3.5 MHz ÷ (192 × P), with no ULA wait states. A unit of length is 24,577 T-states, about 7 ms.
R $F11E I:IXh period of the first tone: the passes between flips of its level (0 for 256)
R $F11E I:L period of the second tone
R $F11E I:C length in units of 256 passes
  $F11E Start the first tone's level low, and both counters at 1 so that each level flips after the first pass. #REGh holds the speaker bit.
  $F125 Start the second tone's level low, and count 256 passes for each unit of length.
@ $F127 label=two_tones_loop
  $F127 Pad the pass to 96 T-states.
@ $F129 label=two_tones_pass
  $F129 Send the first tone's level. Does its counter run out?
  $F12F Yes: restart the first tone's count and flip its level. Does the second tone's counter run out?
@ $F137 label=two_tones_flip2
  $F137 Send the second tone's level, then restart its count and flip it.
  $F13B Next pass.
  $F13D,4 Next unit of length.
@ $F142 label=two_tones_keep1
  $F142 Never jumps, since the zero flag is clear here. It makes this path as long as a flip of the first tone.
  $F144 Does the second tone's counter run out?
@ $F149 label=two_tones_keep2
  $F149 Send the second tone's level, padded to the length of a flip.
  $F14D Next pass.
  $F14F,4 Next unit of length.
@ $F154 label=play_three_tones
c $F154 Play three tones
D $F154 Plays three tones on the speaker at once for a given length.
N $F154 Each pass gives each of three levels a slot. In its slot a level goes to the speaker, unless its counter runs out. Then the level flips and nothing goes out, so the speaker holds the level of the slot before.
N $F154 Every pass takes 118 T-states, except the last of each unit of length, which takes 119. The three slots last 31, 31 and 56 T-states, so the third level has the speaker for longest. A level whose counter restarts from period P sounds at 3.5 MHz ÷ (236 × P), with no ULA wait states. A unit of length is 30,209 T-states, about 8.6 ms.
N $F154 Each counter starts from its own period, then restarts from another's.
N $F154 #TABLE(default) { =h Level | =h First count | =h Then every } { First | first period | third period } { Second | second period | first period } { Third | third period | second period } TABLE#
R $F154 I:D first period (0 for 256)
R $F154 I:E second period
R $F154 I:C third period
R $F154 I:L length in units of 256 passes
  $F154 Keep the speaker bit and the third period in #REGix, and the first and second periods in #REGiy, for the counters' restarts.
  $F15C Start every level low, and count 256 passes for each unit of length. #REGa holds the first two levels, and #REGa' holds the third.
  $F160,3 A roundabout jump into the loop.
@ $F164 label=three_tones_loop
  $F164 Pad the pass to 118 T-states.
@ $F166 label=three_tones_pass
  $F166 Does the first counter run out?
  $F169 Yes: flip the first level and restart the counter. Rotate the second level into the speaker bit for its slot.
  $F16E Does the second counter run out?
  $F171 Yes: flip the second level, restart the counter, and take up the third level.
  $F176 Does the third counter run out?
  $F179 Yes: flip the third level and restart the counter. Take up the first two levels, rotated back.
  $F17F Next pass.
  $F181,4 Next unit of length.
@ $F186 label=three_tones_keep1
  $F186 Send the first level, with the second on the MIC bit. Rotate the second level into the speaker bit for its slot.
  $F189 Does the second counter run out?
  $F18C Yes: flip the second level, restart the counter, and take up the third level.
  $F191 Does the third counter run out?
  $F194 Yes: flip the third level and restart the counter. Take up the first two levels, rotated back.
  $F19A Next pass.
  $F19C,4 Next unit of length.
@ $F1A1 label=three_tones_keep2
  $F1A1 Send the second level, and take up the third.
  $F1A4 Does the third counter run out?
  $F1A7 Yes: flip the third level and restart the counter. Take up the first two levels, rotated back.
  $F1AD Next pass.
  $F1AF,4 Next unit of length.
@ $F1B4 label=three_tones_keep3
  $F1B4 Send the third level. Take up the first two levels, rotated back.
  $F1B8 Next pass.
  $F1BA,4 Next unit of length.
@ $F1BF label=tune_part_1
b $F1BF Title tune notes, start of the first part
D $F1BF The first notes of the title tune's first part. The part runs on into #R$F30A@main(the title tune notes), where the note format is.
N $F1BF #HTML(#AUDIO1,$F021,$F027(title-tune-part-1-start.wav))
B $F1BF,330,3 Notes
B $F309,1 Period of the first tone of the note that ends in #R$F30A@main(the title tune notes)
