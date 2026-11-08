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
c $B000
c $B003
c $B02A
@ $B032 ssub=LD ($B058),A
@ $B058 label=*
c $B080
c $B096
b $B0BE
c $B20A
c $B38E
c $B3B0
c $B3F0
b $B427
c $B432
c $B449
c $B4A7
c $B4D9
@ $B501 ssub=LD ($B058),A
c $B640
c $B70B
c $B71E
@ $B751 ssub=LD ($CC32),A
@ $B756 ssub=LD ($C80D+1),A
c $B75A
b $B766
c $B789
c $B7B7
c $B7CE
b $B7DA
@ $B7E2 label=*
@ $B7EA label=*
@ $B7F2 label=*
@ $B7FA label=*
@ $B802 label=*
@ $B80A label=*
c $B812
c $B84B
c $B850
@ $B859 label=*
c $B874
@ $B87A label=*
c $B889
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
c $BA3C
b $BAA7
c $BAAE
c $BAC6
@ $BACE ssub=LD ($B859+1),A
c $BB4A
c $BB6D
c $BBA2
c $BC04
b $BC1F
@ $BC21 label=*
B $BC21
c $BC37
c $BC57
b $BC68
c $BC70
c $BCB3
s $BD0F
@ $BD11 label=*
S $BD11
@ $BD13 label=*
S $BD13
@ $BD14 label=*
S $BD14
@ $BD15 label=*
S $BD15
@ $BD16 label=*
S $BD16
@ $BD17 label=*
S $BD17
@ $BD18 label=*
S $BD18
@ $BD19 label=*
S $BD19
@ $BD1A label=*
S $BD1A
@ $BD1B label=*
S $BD1B
@ $BD1C label=*
S $BD1C
@ $BD1D label=*
S $BD1D
@ $BD1F label=*
S $BD1F
@ $BD20 label=*
S $BD20
@ $BD21 label=*
S $BD21
@ $BD22 label=*
S $BD22
@ $BD23 label=*
S $BD23
@ $BD24 label=*
S $BD24
@ $BD25 label=*
S $BD25
@ $BD26 label=*
S $BD26
@ $BD27 label=*
S $BD27
@ $BD28 label=*
S $BD28
@ $BD30 label=*
S $BD30
@ $BD32 label=*
S $BD32
@ $BD33 label=*
S $BD33
@ $BD34 label=*
S $BD34
@ $BD35 label=*
S $BD35
@ $BD3C label=*
S $BD3C
@ $BD3D label=*
S $BD3D
@ $BD3E label=*
S $BD3E
@ $BD3F label=*
S $BD3F
@ $BD40 label=*
S $BD40
@ $BD41 label=*
S $BD41
@ $BD42 label=*
S $BD42
@ $BD43 label=*
S $BD43
c $BD44
c $BE11
c $BE44
c $BE94
c $BEB9
c $BEE0
c $BEEF
c $BF04
c $BF16
c $BF19
c $BF6A
c $BF8B
c $C09B
b $C0AC
c $C0B4
@ $C0B5 ssub=LD ($CC32),A
@ $C0D6 ssub=LD ($C80D+1),A
@ $C12B ssub=LD ($C80D+1),A
c $C227
c $C25E
c $C28D
c $C2C7
b $C2DA
c $C2DB
c $C3B7
c $C3F5
c $C43E
@ $C445 ssub=LD ($C80D+1),A
c $C44B
@ $C45E ssub=LD ($C80D+1),A
@ $C47D ssub=LD ($CC0A+1),A
@ $C48A ssub=LD ($CC0A+1),A
c $C494
b $C4CB
c $C4DB
c $C4F2
c $C526
c $C56D
c $C5E2
c $C5F3
c $C658
c $C6E1
c $C766
c $C76A
c $C79A
c $C802
@ $C80D label=*
c $C819
c $C845
c $C866
c $C880
b $C909
@ $C924 label=*
B $C924
@ $C927 label=*
B $C927
@ $C928 label=*
B $C928
@ $C936 label=*
B $C936
@ $C944 label=*
B $C944
@ $C946 label=*
B $C946
@ $C947 label=*
B $C947
@ $C948 label=*
B $C948
B $C949
@ $C949 label=*
@ $C94A label=*
B $C94A
@ $C94B label=*
B $C94B
@ $C94C label=*
B $C94C
@ $C94E label=*
B $C94E
@ $C94F label=*
B $C94F
B $C951
@ $C951 label=*
@ $C953 label=*
B $C953
@ $C955 label=*
B $C955
@ $C956 label=*
B $C956
@ $C957 label=*
B $C957
@ $C958 label=*
B $C958
@ $C95B label=*
B $C95B
@ $C95C label=*
B $C95C
@ $C95D label=*
B $C95D
@ $C95F label=*
B $C95F
@ $C960 label=*
B $C960
B $C961
@ $C961 label=*
@ $C962 label=*
B $C962
c $C963
c $C97B
c $C985
c $C99E
c $C9B7
c $C9DA
c $C9E0
c $CA4E
c $CA54
c $CAEA
c $CAF0
b $CB8E
c $CBA8
@ $CBAA ssub=LD ($CC32),A
@ $CC0A label=*
@ $CC32 label=*
c $CC42
c $CC73
c $CC9B
c $CCB0
c $CCD3
c $CD18
c $CD36
c $CD3A
c $CD6E
c $CD86
b $CD9C
@ $CDAC label=*
@ $CDBC label=*
@ $CDC8 label=*
B $CDC8
c $CDE8
c $CE07
@ $CE26 label=*
c $CE30
c $CE4B
c $CE61
b $CE86
c $CE91
@ $CEE0 ssub=LD HL,$CE07
@ $CF3C ssub=LD ($B87A+1),A
@ $CF53 ssub=LD ($B87A+1),A
@ $CF70 ssub=LD HL,$CE26
@ $CFA6 ssub=LD ($CC0A+1),A
@ $D10F ssub=LD ($CC0A+1),A
c $D219
c $D24A
c $D292
c $D29D
b $D2A6
@ $D2AF label=*
B $D2AF
@ $D2B0 label=*
B $D2B0
@ $D2B1 label=*
B $D2B1
@ $D2B2 label=*
B $D2B2
@ $D2B3 label=*
B $D2B3
@ $D2B4 label=*
B $D2B4
@ $D2B5 label=*
B $D2B5
B $D2B6
@ $D2B6 label=*
@ $D2B7 label=*
B $D2B7
@ $D2B8 label=*
B $D2B8
@ $D2B9 label=*
B $D2B9
@ $D2BA label=*
B $D2BA
@ $D2BC label=*
B $D2BC
B $D2BE
@ $D2BE label=*
@ $D2BF label=*
B $D2BF
@ $D2C0 label=*
B $D2C0
@ $D2C1 label=*
B $D2C1
@ $D2C2 label=*
B $D2C2
@ $D2C3 label=*
B $D2C3
@ $D2C4 label=*
B $D2C4
@ $D2C5 label=*
B $D2C5
B $D2C6
@ $D2C6 label=*
@ $D2C7 label=*
B $D2C7
@ $D2C8 label=*
B $D2C8
@ $D2C9 label=*
B $D2C9
@ $D2CA label=*
B $D2CA
@ $D2CB label=*
B $D2CB
@ $D2CC label=*
B $D2CC
@ $D2CD label=*
B $D2CD
B $D2CE
@ $D2CE label=*
@ $D2CF label=*
B $D2CF
@ $D2D1 label=*
B $D2D1
@ $D2D2 label=*
B $D2D2
@ $D2D3 label=*
B $D2D3
@ $D2D4 label=*
B $D2D4
@ $D2D5 label=*
B $D2D5
c $D2D6
c $D2E6
c $D2FD
c $D31E
c $D343
c $D3F7
c $D401
c $D41A
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
c $F000
c $F006
b $F009 Encrypted routine
D $F009 These bytes are code XOR-encrypted in place: #R$F45F decrypts them (key $41 for the first byte, one more for each byte after it) and the routine at #R$F006 runs straight into the result.
b $F30A
c $F45F Decrypt or re-encrypt the routine at #R$F009
D $F45F XORs the 769 bytes from #R$F009 with $41, $42, $43... (the key wraps at $FF). XOR is its own inverse, so a second call restores the ciphertext.
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
