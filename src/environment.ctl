; Shadow Skimmer (The Edge, 1987) - everything in the snapshot that is not the
; game's code block: the loading screen, the ROM's system areas, the BASIC
; loader and the top of RAM. Built into build/environment.skool and laid
; together with the game (src/shadskim.ctl, $61A8-$F9FF) to rebuild
; SHADSKIM.Z80 byte for byte.
@ $4000 start
@ $4000 org
b $4000 Loading screen: pixels
D $4000 #SCR(loading)
b $5800 Loading screen: attributes
s $5B00 Printer buffer
b $5C00 System variables
b $5CB6 Channel information
b $5CCB BASIC loader
D $5CCB 10 BORDER 0: PAPER 0: CLS / 20 LOAD "SHADOWSKIM"CODE 25000 / 30 PAUSE 0 / 80 RANDOMIZE USR 25085. The snapshot was taken while line 30 waited for a key.
b $5D20 BASIC variables, edit line and workspace
D $5D20 The workspace still holds the tape header of the code block: type 3, name "SHADOWSKIM", length 39000, start 25000.
s $5DF1 Unused, below the code block
i $61A8
s $FA00 Unused, above the code block
b $FF0C Machine stack
D $FF0C RAMTOP is $FF57; the stack holds the ROM's return addresses from the PAUSE in line 30.
b $FF58 User-defined graphics
D $FF58 The ROM's default UDGs, copies of the capital letters A to U.
