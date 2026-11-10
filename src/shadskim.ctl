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
b $61A8 Unused relocation code
D $61A8 Bytes that decode to code the game never runs. They hold a routine that adds a base address to the words a list of offsets names. Seven jumps follow, six of them into the outer hull's graphic directory.
@ $61FD label=game_entry
c $61FD Game entry point
D $61FD Everything starts here once the game loads.
@ $6200 label=outer_graphic_dir
b $6200 Outer hull graphic directory
D $6200 The record of each of the 151 graphics of the outer hull, by graphic number from 0, 4 bytes per graphic. A graphic's record therefore starts 4 × its number bytes into the directory.
N $6200 #TABLE(default,,,:w) { =h Byte | =h Bits | =h Content } { 0–1 | All | Address of the graphic's #R$645C(pixels) } { 2 | 0–2 | Width in cells } { 2 | 3–7 | Number of the graphic's colour pattern in #R$B12F(the colour pattern addresses), from 1, or 0 for a graphic in one colour } { 3 | 0–2 | Height in cells } { 3 | 3–7 | Number of the graphic's cell mask in #R$B0BE(the cell mask addresses), from 1, or 0 for a graphic that draws every cell } TABLE#
N $6200 #TABLE(default,,:w) { =h Graphic | =h What its record holds } { 38 | A record the game never reads, since #R$B640(a layout graphic's draw) shades the cell of a lone shadow cell and draws nothing } { 43 | A record the game never reads, since the animated graphic draws from #R$95D0(its own frames). It points at the pixels of graphic 44, three cells to a row } { 117 | Pixels that run into those of graphic 118 from the middle of the fourth cell } { 119 | An address in the ROM, with a width and a height of 0 } { 120 | Pixels that run into those of graphic 121 from the middle of the seventh cell } TABLE#
W $6200,2 Pixels
B $6202,2 Width and height in cells
W $6204,2 Pixels
B $6206,2 Width and height in cells
W $6208,2 Pixels
B $620A,2 Width and height in cells
W $620C,2 Pixels
B $620E,2 Width and height in cells
W $6210,2 Pixels
B $6212,2 Width and height in cells
W $6214,2 Pixels
B $6216,2 Width and height in cells
W $6218,2 Pixels
B $621A,2 Width and height in cells
W $621C,2 Pixels
B $621E,2 Width and height in cells
W $6220,2 Pixels
B $6222,2 Width and height in cells
W $6224,2 Pixels
B $6226,2 Width and height in cells
W $6228,2 Pixels
B $622A,2 Width and height in cells
W $622C,2 Pixels
B $622E,2 Width and height in cells
W $6230,2 Pixels
B $6232,2 Width and height in cells
W $6234,2 Pixels
B $6236,2 Width and height in cells
W $6238,2 Pixels
B $623A,2 Width and height in cells
W $623C,2 Pixels
B $623E,2 Width and height in cells
W $6240,2 Pixels
B $6242,2 Width and height in cells
W $6244,2 Pixels
B $6246,2 Width and height in cells
W $6248,2 Pixels
B $624A,2 Width and height in cells
W $624C,2 Pixels
B $624E,2 Width and height in cells
W $6250,2 Pixels
B $6252,2 Width and height in cells
W $6254,2 Pixels
B $6256,2 Width and height in cells
W $6258,2 Pixels
B $625A,2 Width and height in cells
W $625C,2 Pixels
B $625E,2 Width and height in cells
W $6260,2 Pixels
B $6262,2 Width in cells, height and cell mask
W $6264,2 Pixels
B $6266,2 Width and height in cells
W $6268,2 Pixels
B $626A,2 Width in cells, height and cell mask
W $626C,2 Pixels
B $626E,2 Width and colour pattern, height and cell mask
W $6270,2 Pixels
B $6272,2 Width and colour pattern, height and cell mask
W $6274,2 Pixels
B $6276,2 Width and colour pattern, height and cell mask
W $6278,2 Pixels
B $627A,2 Width and colour pattern, height and cell mask
W $627C,2 Pixels
B $627E,2 Width in cells, height and cell mask
W $6280,2 Pixels
B $6282,2 Width in cells, height and cell mask
W $6284,2 Pixels
B $6286,2 Width in cells, height and cell mask
W $6288,2 Pixels
B $628A,2 Width in cells, height and cell mask
W $628C,2 Pixels
B $628E,2 Width and height in cells
W $6290,2 Pixels
B $6292,2 Width and height in cells
W $6294,2 Pixels
B $6296,2 Width and height in cells
W $6298,2 Pixels
B $629A,2 Width and height in cells
W $629C,2 Pixels
B $629E,2 Width and height in cells
W $62A0,2 Pixels
B $62A2,2 Width and height in cells
W $62A4,2 Pixels
B $62A6,2 Width and height in cells
W $62A8,2 Pixels
B $62AA,2 Width and height in cells
W $62AC,2 Pixels: the first cells of graphic 44
B $62AE,2 Width and height in cells
W $62B0,2 Pixels
B $62B2,2 Width in cells, height and cell mask
W $62B4,2 Pixels
B $62B6,2 Width and height in cells
W $62B8,2 Pixels
B $62BA,2 Width and height in cells
W $62BC,2 Pixels
B $62BE,2 Width in cells, height and cell mask
W $62C0,2 Pixels
B $62C2,2 Width and height in cells
W $62C4,2 Pixels
B $62C6,2 Width and height in cells
W $62C8,2 Pixels
B $62CA,2 Width and height in cells
W $62CC,2 Pixels
B $62CE,2 Width and height in cells
W $62D0,2 Pixels
B $62D2,2 Width and height in cells
W $62D4,2 Pixels
B $62D6,2 Width and height in cells
W $62D8,2 Pixels
B $62DA,2 Width and colour pattern, height and cell mask
W $62DC,2 Pixels
B $62DE,2 Width and colour pattern, height and cell mask
W $62E0,2 Pixels
B $62E2,2 Width and height in cells
W $62E4,2 Pixels
B $62E6,2 Width and height in cells
W $62E8,2 Pixels
B $62EA,2 Width and height in cells
W $62EC,2 Pixels
B $62EE,2 Width and height in cells
W $62F0,2 Pixels
B $62F2,2 Width and height in cells
W $62F4,2 Pixels
B $62F6,2 Width and height in cells
W $62F8,2 Pixels
B $62FA,2 Width and height in cells
W $62FC,2 Pixels
B $62FE,2 Width and height in cells
W $6300,2 Pixels
B $6302,2 Width and height in cells
W $6304,2 Pixels
B $6306,2 Width and height in cells
W $6308,2 Pixels
B $630A,2 Width and height in cells
W $630C,2 Pixels
B $630E,2 Width and height in cells
W $6310,2 Pixels
B $6312,2 Width and height in cells
W $6314,2 Pixels
B $6316,2 Width and height in cells
W $6318,2 Pixels
B $631A,2 Width and height in cells
W $631C,2 Pixels
B $631E,2 Width and colour pattern, height and cell mask
W $6320,2 Pixels
B $6322,2 Width and colour pattern, height and cell mask
W $6324,2 Pixels
B $6326,2 Width and colour pattern, height and cell mask
W $6328,2 Pixels
B $632A,2 Width and colour pattern, height and cell mask
W $632C,2 Pixels: the top row of graphic 19
B $632E,2 Width and height in cells
W $6330,2 Pixels
B $6332,2 Width and height in cells
W $6334,2 Pixels
B $6336,2 Width and height in cells
W $6338,2 Pixels
B $633A,2 Width and height in cells
W $633C,2 Pixels
B $633E,2 Width and height in cells
W $6340,2 Pixels
B $6342,2 Width and height in cells
W $6344,2 Pixels
B $6346,2 Width and height in cells
W $6348,2 Pixels
B $634A,2 Width and height in cells
W $634C,2 Pixels
B $634E,2 Width and height in cells
W $6350,2 Pixels
B $6352,2 Width and height in cells
W $6354,2 Pixels
B $6356,2 Width and height in cells
W $6358,2 Pixels
B $635A,2 Width and height in cells
W $635C,2 Pixels
B $635E,2 Width and height in cells
W $6360,2 Pixels
B $6362,2 Width and height in cells
W $6364,2 Pixels
B $6366,2 Width and height in cells
W $6368,2 Pixels
B $636A,2 Width and height in cells
W $636C,2 Pixels
B $636E,2 Width and height in cells
W $6370,2 Pixels
B $6372,2 Width and height in cells
W $6374,2 Pixels
B $6376,2 Width and height in cells
W $6378,2 Pixels
B $637A,2 Width and height in cells
W $637C,2 Pixels
B $637E,2 Width and height in cells
W $6380,2 Pixels
B $6382,2 Width and height in cells
W $6384,2 Pixels
B $6386,2 Width and height in cells
W $6388,2 Pixels
B $638A,2 Width and height in cells
W $638C,2 Pixels
B $638E,2 Width and height in cells
W $6390,2 Pixels
B $6392,2 Width and height in cells
W $6394,2 Pixels
B $6396,2 Width and height in cells
W $6398,2 Pixels
B $639A,2 Width and height in cells
W $639C,2 Pixels
B $639E,2 Width and height in cells
W $63A0,2 Pixels
B $63A2,2 Width and colour pattern, height in cells
W $63A4,2 Pixels
B $63A6,2 Width and colour pattern, height in cells
W $63A8,2 Pixels
B $63AA,2 Width and colour pattern, height in cells
W $63AC,2 Pixels
B $63AE,2 Width and colour pattern, height in cells
W $63B0,2 Pixels
B $63B2,2 Width and colour pattern, height in cells
W $63B4,2 Pixels
B $63B6,2 Width and colour pattern, height in cells
W $63B8,2 Pixels
B $63BA,2 Width and height in cells
W $63BC,2 Pixels
B $63BE,2 Width and height in cells
W $63C0,2 Pixels
B $63C2,2 Width and height in cells
W $63C4,2 Pixels
B $63C6,2 Width and height in cells
W $63C8,2 Pixels
B $63CA,2 Width and height in cells
W $63CC,2 Pixels
B $63CE,2 Width and height in cells
W $63D0,2 Pixels
B $63D2,2 Width and height in cells
W $63D4,2 Pixels
B $63D6,2 Width and height in cells
W $63D8,2 Pixels
B $63DA,2 Width and height in cells
W $63DC,2 Pixels, in the ROM
B $63DE,2 Width and height in cells
W $63E0,2 Pixels
B $63E2,2 Width and height in cells
W $63E4,2 Pixels
B $63E6,2 Width and height in cells
W $63E8,2 Pixels
B $63EA,2 Width and height in cells
W $63EC,2 Pixels
B $63EE,2 Width and height in cells
W $63F0,2 Pixels
B $63F2,2 Width and height in cells
W $63F4,2 Pixels
B $63F6,2 Width and height in cells
W $63F8,2 Pixels
B $63FA,2 Width and height in cells
W $63FC,2 Pixels
B $63FE,2 Width and height in cells
W $6400,2 Pixels
B $6402,2 Width and height in cells
W $6404,2 Pixels
B $6406,2 Width and height in cells
W $6408,2 Pixels
B $640A,2 Width and height in cells
W $640C,2 Pixels
B $640E,2 Width and height in cells
W $6410,2 Pixels
B $6412,2 Width and height in cells
W $6414,2 Pixels
B $6416,2 Width and height in cells
W $6418,2 Pixels
B $641A,2 Width and height in cells
W $641C,2 Pixels
B $641E,2 Width and height in cells
W $6420,2 Pixels
B $6422,2 Width and height in cells
W $6424,2 Pixels
B $6426,2 Width and height in cells
W $6428,2 Pixels
B $642A,2 Width and height in cells
W $642C,2 Pixels
B $642E,2 Width and height in cells
W $6430,2 Pixels
B $6432,2 Width and height in cells
W $6434,2 Pixels
B $6436,2 Width and height in cells
W $6438,2 Pixels
B $643A,2 Width and height in cells
W $643C,2 Pixels
B $643E,2 Width and height in cells
W $6440,2 Pixels
B $6442,2 Width and colour pattern, height in cells
W $6444,2 Pixels
B $6446,2 Width and colour pattern, height in cells
W $6448,2 Pixels
B $644A,2 Width and colour pattern, height in cells
W $644C,2 Pixels
B $644E,2 Width and colour pattern, height in cells
W $6450,2 Pixels
B $6452,2 Width and colour pattern, height in cells
W $6454,2 Pixels
B $6456,2 Width and colour pattern, height in cells
W $6458,2 Pixels
B $645A,2 Width and colour pattern, height in cells
@ $645C label=outer_graphic_0
b $645C Outer hull graphics
D $645C Every graphic that #R$6200(the outer hull's graphic directory) lists, at the address and the size that its record gives. A graphic holds 8 bytes per cell, cell by cell along each row of cells from the top. Some graphics share bytes, so one graphic can start inside another.
N $645C The renders show the pixels of each graphic at the size its record gives, under its graphic number. The colours come from the screen layout and the graphic's colour pattern, so the renders use black ink on white paper. Graphic 119 has no render, since #R$6200(its record) gives it no pixels.
N $645C Cell mask 1 leaves out the bottom middle cell of graphic 24, so the draw keeps that cell's pixels and colour.
N $645C #UDGTABLE { #PUSHS #DRAWSCREEN(4,6,0)#SCR2,19,12,3,2(outer_graphic_24_screen_64)#POPS } { Graphic 24 on screen 64 } TABLE#
N $645C Graphics 104–109 colour each cell as their #R$B12F(colour patterns) give it.
N $645C #UDGTABLE { =h,c3 On screen 0 } { #PUSHS #DRAWSCREEN(0,0,0)#SCR2,11,20,5,4(outer_graphic_104_screen_0)#POPS | #PUSHS #DRAWSCREEN(0,0,0)#SCR2,16,20,4,4(outer_graphic_105_screen_0)#POPS | #PUSHS #DRAWSCREEN(0,0,0)#SCR2,5,20,6,4(outer_graphic_108_screen_0)#POPS } { 104 | 105 | 108 } { =h,c3 On screen 10 } { #PUSHS #DRAWSCREEN(0,1,0)#SCR2,11,6,5,4(outer_graphic_106_screen_10)#POPS | #PUSHS #DRAWSCREEN(0,1,0)#SCR2,16,6,4,4(outer_graphic_107_screen_10)#POPS | #PUSHS #DRAWSCREEN(0,1,0)#SCR2,5,6,6,4(outer_graphic_109_screen_10)#POPS } { 106 | 107 | 109 } TABLE#
N $645C #UDGTABLE { #UDGARRAY5,,2($645C-$64F4-8)(outer_graphic_0) | #UDGARRAY3,,2($64FC-$653C-8)(outer_graphic_1) | #UDGARRAY2,,2($6544-$656C-8)(outer_graphic_2) | #UDGARRAY2,,2($6574-$659C-8)(outer_graphic_3) | #UDGARRAY2,,2($65A4-$65DC-8)(outer_graphic_4) | #UDGARRAY3,,2($65E4-$660C-8)(outer_graphic_5) | #UDGARRAY3,,2($6614-$663C-8)(outer_graphic_6) } { 0 | 1 | 2 | 3 | 4 | 5 | 6 } { #UDGARRAY2,,2($6644-$665C-8)(outer_graphic_7) | #UDGARRAY2,,2($6664-$667C-8)(outer_graphic_8) | #UDGARRAY3,,2($6684-$66AC-8)(outer_graphic_9) | #UDGARRAY1,,2($66B4-$66BC-8)(outer_graphic_10) | #UDGARRAY1,,2($66C4-$66CC-8)(outer_graphic_11) | #UDGARRAY3,,2($66D4-$66E4-8)(outer_graphic_12) | #UDGARRAY3,,2($66EC-$66FC-8)(outer_graphic_13) } { 7 | 8 | 9 | 10 | 11 | 12 | 13 } { #UDGARRAY5,,2($6704-$679C-8)(outer_graphic_14) | #UDGARRAY3,,2($67A4-$67FC-8)(outer_graphic_15) | #UDGARRAY5,,2($6804-$689C-8)(outer_graphic_16) | #UDGARRAY3,,2($68A4-$68FC-8)(outer_graphic_17) | #UDGARRAY2,,2($6904-$692C-8)(outer_graphic_18) | #UDGARRAY3,,2($6934-$695C-8)(outer_graphic_19) | #UDGARRAY3,,2($6964-$69D4-8)(outer_graphic_20) } { 14 | 15 | 16 | 17 | 18 | 19 | 20 } { #UDGARRAY3,,2($69DC-$6A4C-8)(outer_graphic_21) | #UDGARRAY5,,2($6A54-$6AC4-8)(outer_graphic_22) | #UDGARRAY5,,2($6ACC-$6B3C-8)(outer_graphic_23) | #UDGARRAY3,,2($6B44-$6B6C-8)(outer_graphic_24) | #UDGARRAY3,,2($6B74-$6B9C-8)(outer_graphic_25) | #UDGARRAY3,,2($6BA4-$6BE4-8)(outer_graphic_26) | #UDGARRAY2,,2($6BEC-$6C04-8)(outer_graphic_27) } { 21 | 22 | 23 | 24 | 25 | 26 | 27 } { #UDGARRAY2,,2($6C0C-$6C24-8)(outer_graphic_28) | #UDGARRAY2,,2($6C2C-$6C44-8)(outer_graphic_29) | #UDGARRAY2,,2($6C4C-$6C64-8)(outer_graphic_30) | #UDGARRAY4,,2($6C6C-$6CE4-8)(outer_graphic_31) | #UDGARRAY4,,2($6CEC-$6D64-8)(outer_graphic_32) | #UDGARRAY4,,2($6D6C-$6DE4-8)(outer_graphic_33) | #UDGARRAY4,,2($6DEC-$6E64-8)(outer_graphic_34) } { 28 | 29 | 30 | 31 | 32 | 33 | 34 } { #UDGARRAY5,,2($6E6C-$6F2C-8)(outer_graphic_35) | #UDGARRAY2,,2($6F34-$6F4C-8)(outer_graphic_36) | #UDGARRAY3,,2($6F54-$6F94-8)(outer_graphic_37) | #UDGARRAY1,,2($6F9C-$6F9C-8)(outer_graphic_38) | #UDGARRAY2,,2($6FA4-$6FAC-8)(outer_graphic_39) | #UDGARRAY2,,2($6FB4-$6FBC-8)(outer_graphic_40) | #UDGARRAY1,,2($6FC4-$6FCC-8)(outer_graphic_41) } { 35 | 36 | 37 | 38 | 39 | 40 | 41 } { #UDGARRAY1,,2($6FD4-$6FDC-8)(outer_graphic_42) | #UDGARRAY3,,2($6FE4-$7024-8)(outer_graphic_43) | #UDGARRAY4,,2($6FE4-$707C-8)(outer_graphic_44) | #UDGARRAY2,,2($7084-$708C-8)(outer_graphic_45) | #UDGARRAY2,,2($7094-$709C-8)(outer_graphic_46) | #UDGARRAY5,,2($70A4-$713C-8)(outer_graphic_47) | #UDGARRAY1,,2($7144-$714C-8)(outer_graphic_48) } { 42 | 43 | 44 | 45 | 46 | 47 | 48 } { #UDGARRAY1,,2($7154-$715C-8)(outer_graphic_49) | #UDGARRAY5,,2($7164-$71FC-8)(outer_graphic_50) | #UDGARRAY5,,2($7204-$729C-8)(outer_graphic_51) | #UDGARRAY4,,2($72A4-$733C-8)(outer_graphic_52) | #UDGARRAY4,,2($7344-$73DC-8)(outer_graphic_53) | #UDGARRAY1,,2($73E4-$73EC-8)(outer_graphic_54) | #UDGARRAY2,,2($73F4-$73FC-8)(outer_graphic_55) } { 49 | 50 | 51 | 52 | 53 | 54 | 55 } { #UDGARRAY3,,2($7404-$7444-8)(outer_graphic_56) | #UDGARRAY3,,2($744C-$748C-8)(outer_graphic_57) | #UDGARRAY3,,2($7494-$74D4-8)(outer_graphic_58) | #UDGARRAY3,,2($74DC-$751C-8)(outer_graphic_59) | #UDGARRAY2,,2($7524-$755C-8)(outer_graphic_60) | #UDGARRAY2,,2($7564-$75BC-8)(outer_graphic_61) | #UDGARRAY2,,2($75C4-$761C-8)(outer_graphic_62) } { 56 | 57 | 58 | 59 | 60 | 61 | 62 } { #UDGARRAY1,,2($7624-$762C-8)(outer_graphic_63) | #UDGARRAY1,,2($7634-$763C-8)(outer_graphic_64) | #UDGARRAY2,,2($7644-$766C-8)(outer_graphic_65) | #UDGARRAY2,,2($7674-$769C-8)(outer_graphic_66) | #UDGARRAY2,,2($76A4-$76AC-8)(outer_graphic_67) | #UDGARRAY2,,2($76B4-$76BC-8)(outer_graphic_68) | #UDGARRAY3,,2($76C4-$76D4-8)(outer_graphic_69) } { 63 | 64 | 65 | 66 | 67 | 68 | 69 } { #UDGARRAY3,,2($76F4-$7704-8)(outer_graphic_70) | #UDGARRAY2,,2($7724-$773C-8)(outer_graphic_71) | #UDGARRAY2,,2($7744-$775C-8)(outer_graphic_72) | #UDGARRAY2,,2($7764-$777C-8)(outer_graphic_73) | #UDGARRAY2,,2($7784-$779C-8)(outer_graphic_74) | #UDGARRAY3,,2($6934-$6944-8)(outer_graphic_75) | #UDGARRAY1,,2($77A4-$77B4-8)(outer_graphic_76) } { 70 | 71 | 72 | 73 | 74 | 75 | 76 } { #UDGARRAY1,,2($6E9C-$6E9C-8)(outer_graphic_77) | #UDGARRAY1,,2($6EA4-$6EA4-8)(outer_graphic_78) | #UDGARRAY1,,2($6EAC-$6EAC-8)(outer_graphic_79) | #UDGARRAY3,,2($76DC-$76EC-8)(outer_graphic_80) | #UDGARRAY3,,2($770C-$771C-8)(outer_graphic_81) | #UDGARRAY1,,2($77BC-$77CC-8)(outer_graphic_82) | #UDGARRAY1,,2($77D4-$77E4-8)(outer_graphic_83) } { 77 | 78 | 79 | 80 | 81 | 82 | 83 } { #UDGARRAY1,,2($77EC-$77FC-8)(outer_graphic_84) | #UDGARRAY1,,2($7804-$7814-8)(outer_graphic_85) | #UDGARRAY1,,2($6EC4-$6EC4-8)(outer_graphic_86) | #UDGARRAY1,,2($6ECC-$6ECC-8)(outer_graphic_87) | #UDGARRAY3,,2($694C-$695C-8)(outer_graphic_88) | #UDGARRAY2,,2($781C-$7824-8)(outer_graphic_89) | #UDGARRAY2,,2($782C-$7834-8)(outer_graphic_90) } { 84 | 85 | 86 | 87 | 88 | 89 | 90 } { #UDGARRAY2,,2($783C-$7844-8)(outer_graphic_91) | #UDGARRAY2,,2($784C-$7854-8)(outer_graphic_92) | #UDGARRAY1,,2($785C-$7864-8)(outer_graphic_93) | #UDGARRAY1,,2($786C-$7874-8)(outer_graphic_94) | #UDGARRAY1,,2($787C-$7884-8)(outer_graphic_95) | #UDGARRAY1,,2($788C-$7894-8)(outer_graphic_96) | #UDGARRAY1,,2($76AC-$76AC-8)(outer_graphic_97) } { 91 | 92 | 93 | 94 | 95 | 96 | 97 } { #UDGARRAY1,,2($76BC-$76BC-8)(outer_graphic_98) | #UDGARRAY1,,2($789C-$78AC-8)(outer_graphic_99) | #UDGARRAY2,,2($78B4-$78CC-8)(outer_graphic_100) | #UDGARRAY2,,2($78D4-$78EC-8)(outer_graphic_101) | #UDGARRAY2,,2($78F4-$790C-8)(outer_graphic_102) | #UDGARRAY2,,2($7914-$792C-8)(outer_graphic_103) | #UDGARRAY5,,2($7934-$79CC-8)(outer_graphic_104) } { 98 | 99 | 100 | 101 | 102 | 103 | 104 } { #UDGARRAY4,,2($79D4-$7A4C-8)(outer_graphic_105) | #UDGARRAY5,,2($7A54-$7AEC-8)(outer_graphic_106) | #UDGARRAY4,,2($7AF4-$7B6C-8)(outer_graphic_107) | #UDGARRAY6,,2($7B74-$7C2C-8)(outer_graphic_108) | #UDGARRAY6,,2($7C34-$7CEC-8)(outer_graphic_109) | #UDGARRAY4,,2($7CF4-$7D4C-8)(outer_graphic_110) | #UDGARRAY3,,2($7D54-$7DAC-8)(outer_graphic_111) } { 105 | 106 | 107 | 108 | 109 | 110 | 111 } { #UDGARRAY4,,2($7DB4-$7E0C-8)(outer_graphic_112) | #UDGARRAY3,,2($7E14-$7E6C-8)(outer_graphic_113) | #UDGARRAY4,,2($7E74-$7ECC-8)(outer_graphic_114) | #UDGARRAY3,,2($7ED4-$7F2C-8)(outer_graphic_115) | #UDGARRAY4,,2($7F34-$7F8C-8)(outer_graphic_116) | #UDGARRAY3,,2($7F94-$7FEC-8)(outer_graphic_117) | #UDGARRAY5,,2($7FB0-$8020-8)(outer_graphic_118) } { 112 | 113 | 114 | 115 | 116 | 117 | 118 } { #UDGARRAY5,,2($7FF4-$8064-8)(outer_graphic_120) | #UDGARRAY3,,2($8028-$8098-8)(outer_graphic_121) | #UDGARRAY5,,2($80A0-$8110-8)(outer_graphic_122) | #UDGARRAY3,,2($8118-$8188-8)(outer_graphic_123) | #UDGARRAY6,,2($8190-$8218-8)(outer_graphic_124) | #UDGARRAY3,,2($8220-$82A8-8)(outer_graphic_125) | #UDGARRAY6,,2($82B0-$8338-8)(outer_graphic_126) } { 120 | 121 | 122 | 123 | 124 | 125 | 126 } { #UDGARRAY3,,2($8340-$83C8-8)(outer_graphic_127) | #UDGARRAY5,,2($83D0-$83F0-8)(outer_graphic_128) | #UDGARRAY1,,2($83F8-$8418-8)(outer_graphic_129) | #UDGARRAY5,,2($8420-$8440-8)(outer_graphic_130) | #UDGARRAY1,,2($8448-$8468-8)(outer_graphic_131) | #UDGARRAY3,,2($8470-$8480-8)(outer_graphic_132) | #UDGARRAY1,,2($8488-$8498-8)(outer_graphic_133) } { 127 | 128 | 129 | 130 | 131 | 132 | 133 } { #UDGARRAY3,,2($84A0-$84B0-8)(outer_graphic_134) | #UDGARRAY1,,2($84B8-$84C8-8)(outer_graphic_135) | #UDGARRAY1,,2($84D0-$84E0-8)(outer_graphic_136) | #UDGARRAY1,,2($84E8-$84F0-8)(outer_graphic_137) | #UDGARRAY1,,2($84F8-$8510-8)(outer_graphic_138) | #UDGARRAY3,,2($8518-$8540-8)(outer_graphic_139) | #UDGARRAY1,,2($8548-$8560-8)(outer_graphic_140) } { 134 | 135 | 136 | 137 | 138 | 139 | 140 } { #UDGARRAY1,,2($8568-$8570-8)(outer_graphic_141) | #UDGARRAY6,,2($8578-$8600-8)(outer_graphic_142) | #UDGARRAY4,,2($8608-$8660-8)(outer_graphic_143) | #UDGARRAY2,,2($8668-$8690-8)(outer_graphic_144) | #UDGARRAY3,,2($8698-$86C0-8)(outer_graphic_145) | #UDGARRAY3,,2($86C8-$8708-8)(outer_graphic_146) | #UDGARRAY2,,2($8710-$8738-8)(outer_graphic_147) } { 141 | 142 | 143 | 144 | 145 | 146 | 147 } { #UDGARRAY3,,2($8740-$8768-8)(outer_graphic_148) | #UDGARRAY3,,2($8770-$87B0-8)(outer_graphic_149) | #UDGARRAY3,,2($87B8-$87F8-8)(outer_graphic_150) } { 148 | 149 | 150 } TABLE#
B $645C,160,8
@ $64FC label=outer_graphic_1
B $64FC,72,8
@ $6544 label=outer_graphic_2
B $6544,48,8
@ $6574 label=outer_graphic_3
B $6574,48,8
@ $65A4 label=outer_graphic_4
B $65A4,64,8
@ $65E4 label=outer_graphic_5
B $65E4,48,8
@ $6614 label=outer_graphic_6
B $6614,48,8
@ $6644 label=outer_graphic_7
B $6644,32,8
@ $6664 label=outer_graphic_8
B $6664,32,8
@ $6684 label=outer_graphic_9
B $6684,48,8
@ $66B4 label=outer_graphic_10
B $66B4,16,8
@ $66C4 label=outer_graphic_11
B $66C4,16,8
@ $66D4 label=outer_graphic_12
B $66D4,24,8
@ $66EC label=outer_graphic_13
B $66EC,24,8
@ $6704 label=outer_graphic_14
B $6704,160,8
@ $67A4 label=outer_graphic_15
B $67A4,96,8
@ $6804 label=outer_graphic_16
B $6804,160,8
@ $68A4 label=outer_graphic_17
B $68A4,96,8
@ $6904 label=outer_graphic_18
B $6904,48,8
@ $6934 label=outer_graphic_19
B $6934,24,8 Top row, which is also graphic 75
@ $694C label=outer_graphic_88
B $694C,24,8 Bottom row of graphic 19
@ $6964 label=outer_graphic_20
B $6964,120,8
@ $69DC label=outer_graphic_21
B $69DC,120,8
@ $6A54 label=outer_graphic_22
B $6A54,120,8
@ $6ACC label=outer_graphic_23
B $6ACC,120,8
@ $6B44 label=outer_graphic_24
B $6B44,48,8
@ $6B74 label=outer_graphic_25
B $6B74,48,8
@ $6BA4 label=outer_graphic_26
B $6BA4,72,8
@ $6BEC label=outer_graphic_27
B $6BEC,32,8
@ $6C0C label=outer_graphic_28
B $6C0C,32,8
@ $6C2C label=outer_graphic_29
B $6C2C,32,8
@ $6C4C label=outer_graphic_30
B $6C4C,32,8
@ $6C6C label=outer_graphic_31
B $6C6C,128,8
@ $6CEC label=outer_graphic_32
B $6CEC,128,8
@ $6D6C label=outer_graphic_33
B $6D6C,128,8
@ $6DEC label=outer_graphic_34
B $6DEC,128,8
@ $6E6C label=outer_graphic_35
B $6E6C,48,8 First row and the first cell of row 2
@ $6E9C label=outer_graphic_77
B $6E9C,8 Graphic 35's cell in row 2, column 2
@ $6EA4 label=outer_graphic_78
B $6EA4,8 Graphic 35's cell in row 2, column 3
@ $6EAC label=outer_graphic_79
B $6EAC,8 Graphic 35's cell in row 2, column 4
B $6EB4,16,8 Graphic 35's cells in row 2, column 5 and row 3, column 1
@ $6EC4 label=outer_graphic_86
B $6EC4,8 Graphic 35's cell in row 3, column 2
@ $6ECC label=outer_graphic_87
B $6ECC,8 Graphic 35's cell in row 3, column 3
B $6ED4,96,8 Graphic 35's cells from row 3, column 4 to its end
@ $6F34 label=outer_graphic_36
B $6F34,32,8
@ $6F54 label=outer_graphic_37
B $6F54,72,8
@ $6F9C label=outer_graphic_38
B $6F9C,8
@ $6FA4 label=outer_graphic_39
B $6FA4,16,8
@ $6FB4 label=outer_graphic_40
B $6FB4,16,8
@ $6FC4 label=outer_graphic_41
B $6FC4,16,8
@ $6FD4 label=outer_graphic_42
B $6FD4,16,8
@ $6FE4 label=outer_graphic_44
B $6FE4,160,8 Also the pixels of the record of graphic 43
@ $7084 label=outer_graphic_45
B $7084,16,8
@ $7094 label=outer_graphic_46
B $7094,16,8
@ $70A4 label=outer_graphic_47
B $70A4,160,8
@ $7144 label=outer_graphic_48
B $7144,16,8
@ $7154 label=outer_graphic_49
B $7154,16,8
@ $7164 label=outer_graphic_50
B $7164,160,8
@ $7204 label=outer_graphic_51
B $7204,160,8
@ $72A4 label=outer_graphic_52
B $72A4,160,8
@ $7344 label=outer_graphic_53
B $7344,160,8
@ $73E4 label=outer_graphic_54
B $73E4,16,8
@ $73F4 label=outer_graphic_55
B $73F4,16,8
@ $7404 label=outer_graphic_56
B $7404,72,8
@ $744C label=outer_graphic_57
B $744C,72,8
@ $7494 label=outer_graphic_58
B $7494,72,8
@ $74DC label=outer_graphic_59
B $74DC,72,8
@ $7524 label=outer_graphic_60
B $7524,64,8
@ $7564 label=outer_graphic_61
B $7564,96,8
@ $75C4 label=outer_graphic_62
B $75C4,96,8
@ $7624 label=outer_graphic_63
B $7624,16,8
@ $7634 label=outer_graphic_64
B $7634,16,8
@ $7644 label=outer_graphic_65
B $7644,48,8
@ $7674 label=outer_graphic_66
B $7674,48,8
@ $76A4 label=outer_graphic_67
B $76A4,8 Left cell
@ $76AC label=outer_graphic_97
B $76AC,8 Right cell of graphic 67
@ $76B4 label=outer_graphic_68
B $76B4,8 Left cell
@ $76BC label=outer_graphic_98
B $76BC,8 Right cell of graphic 68
@ $76C4 label=outer_graphic_69
B $76C4,24,8
@ $76DC label=outer_graphic_80
B $76DC,24,8
@ $76F4 label=outer_graphic_70
B $76F4,24,8
@ $770C label=outer_graphic_81
B $770C,24,8
@ $7724 label=outer_graphic_71
B $7724,32,8
@ $7744 label=outer_graphic_72
B $7744,32,8
@ $7764 label=outer_graphic_73
B $7764,32,8
@ $7784 label=outer_graphic_74
B $7784,32,8
@ $77A4 label=outer_graphic_76
B $77A4,24,8
@ $77BC label=outer_graphic_82
B $77BC,24,8
@ $77D4 label=outer_graphic_83
B $77D4,24,8
@ $77EC label=outer_graphic_84
B $77EC,24,8
@ $7804 label=outer_graphic_85
B $7804,24,8
@ $781C label=outer_graphic_89
B $781C,16,8
@ $782C label=outer_graphic_90
B $782C,16,8
@ $783C label=outer_graphic_91
B $783C,16,8
@ $784C label=outer_graphic_92
B $784C,16,8
@ $785C label=outer_graphic_93
B $785C,16,8
@ $786C label=outer_graphic_94
B $786C,16,8
@ $787C label=outer_graphic_95
B $787C,16,8
@ $788C label=outer_graphic_96
B $788C,16,8
@ $789C label=outer_graphic_99
B $789C,24,8
@ $78B4 label=outer_graphic_100
B $78B4,32,8
@ $78D4 label=outer_graphic_101
B $78D4,32,8
@ $78F4 label=outer_graphic_102
B $78F4,32,8
@ $7914 label=outer_graphic_103
B $7914,32,8
@ $7934 label=outer_graphic_104
B $7934,160,8
@ $79D4 label=outer_graphic_105
B $79D4,128,8
@ $7A54 label=outer_graphic_106
B $7A54,160,8
@ $7AF4 label=outer_graphic_107
B $7AF4,128,8
@ $7B74 label=outer_graphic_108
B $7B74,192,8
@ $7C34 label=outer_graphic_109
B $7C34,192,8
@ $7CF4 label=outer_graphic_110
B $7CF4,96,8
@ $7D54 label=outer_graphic_111
B $7D54,96,8
@ $7DB4 label=outer_graphic_112
B $7DB4,96,8
@ $7E14 label=outer_graphic_113
B $7E14,96,8
@ $7E74 label=outer_graphic_114
B $7E74,96,8
@ $7ED4 label=outer_graphic_115
B $7ED4,96,8
@ $7F34 label=outer_graphic_116
B $7F34,96,8
@ $7F94 label=outer_graphic_117
B $7F94,28,8*3,4
@ $7FB0 label=outer_graphic_118
B $7FB0,68,8*8,4
@ $7FF4 label=outer_graphic_120
B $7FF4,52,8*6,4
@ $8028 label=outer_graphic_121
B $8028,120,8
@ $80A0 label=outer_graphic_122
B $80A0,120,8
@ $8118 label=outer_graphic_123
B $8118,120,8
@ $8190 label=outer_graphic_124
B $8190,144,8
@ $8220 label=outer_graphic_125
B $8220,144,8
@ $82B0 label=outer_graphic_126
B $82B0,144,8
@ $8340 label=outer_graphic_127
B $8340,144,8
@ $83D0 label=outer_graphic_128
B $83D0,40,8
@ $83F8 label=outer_graphic_129
B $83F8,40,8
@ $8420 label=outer_graphic_130
B $8420,40,8
@ $8448 label=outer_graphic_131
B $8448,40,8
@ $8470 label=outer_graphic_132
B $8470,24,8
@ $8488 label=outer_graphic_133
B $8488,24,8
@ $84A0 label=outer_graphic_134
B $84A0,24,8
@ $84B8 label=outer_graphic_135
B $84B8,24,8
@ $84D0 label=outer_graphic_136
B $84D0,24,8
@ $84E8 label=outer_graphic_137
B $84E8,16,8
@ $84F8 label=outer_graphic_138
B $84F8,32,8
@ $8518 label=outer_graphic_139
B $8518,48,8
@ $8548 label=outer_graphic_140
B $8548,32,8
@ $8568 label=outer_graphic_141
B $8568,16,8
@ $8578 label=outer_graphic_142
B $8578,144,8
@ $8608 label=outer_graphic_143
B $8608,96,8
@ $8668 label=outer_graphic_144
B $8668,48,8
@ $8698 label=outer_graphic_145
B $8698,48,8
@ $86C8 label=outer_graphic_146
B $86C8,72,8
@ $8710 label=outer_graphic_147
B $8710,48,8
@ $8740 label=outer_graphic_148
B $8740,48,8
@ $8770 label=outer_graphic_149
B $8770,72,8
@ $87B8 label=outer_graphic_150
B $87B8,72,8
@ $8800 label=skimmer_image_1
b $8800 Skimmer images
D $8800 The Skimmer the right way up, one image for each horizontal offset from its cell's left edge in steps of 2 pixels. A mask for each image follows. An image or a mask holds 24 pixel rows of 4 bytes, rows from the top.
N $8800 #R$CBA8(The Skimmer's draw) writes the background through the mask, with the image over it. So a mask bit of 1 lets the background show. The draw sets no colour, and the Skimmer takes the colours of the cells it crosses. The renders use the play area's white ink on black paper.
N $8800 #UDGTABLE { #UDGARRAY4,7,3,4,,,,2($8800-$8843-1-32:$8980-$89C3-1-32)(skimmer_image_1) | #UDGARRAY4,7,3,4,,,,2($8860-$88A3-1-32:$89E0-$8A23-1-32)(skimmer_image_2) | #UDGARRAY4,7,3,4,,,,2($88C0-$8903-1-32:$8A40-$8A83-1-32)(skimmer_image_3) | #UDGARRAY4,7,3,4,,,,2($8920-$8963-1-32:$8AA0-$8AE3-1-32)(skimmer_image_4) } { At the cell edge | 2 pixels right | 4 pixels right | 6 pixels right } TABLE#
B $8800,96,8
@ $8860 label=skimmer_image_2
B $8860,96,8
@ $88C0 label=skimmer_image_3
B $88C0,96,8
@ $8920 label=skimmer_image_4
B $8920,96,8
@ $8980 label=skimmer_mask_1
B $8980,96,8
@ $89E0 label=skimmer_mask_2
B $89E0,96,8
@ $8A40 label=skimmer_mask_3
B $8A40,96,8
@ $8AA0 label=skimmer_mask_4
B $8AA0,96,8
@ $8B00 label=hull_surface_1
b $8B00 Sector 1 hull surface
D $8B00 The pattern of the hull surface in sector 1, which #R$B02A(the hull surface draw) tiles over the play area. It covers 16×16 pixels: 16 pixel rows of 2 bytes, rows from the top.
N $8B00 The renders use the play area's white ink on black paper, and show the pattern alone and tiled 4×4.
N $8B00 #UDGTABLE { #UDGARRAY2,7,4,2($8B00-$8B11-1-16)(hull_surface_1) | #UDGARRAY8,7,2,2($8B00;$8B01;$8B00;$8B01;$8B00;$8B01;$8B00;$8B01;$8B10;$8B11;$8B10;$8B11;$8B10;$8B11;$8B10;$8B11;$8B00;$8B01;$8B00;$8B01;$8B00;$8B01;$8B00;$8B01;$8B10;$8B11;$8B10;$8B11;$8B10;$8B11;$8B10;$8B11;$8B00;$8B01;$8B00;$8B01;$8B00;$8B01;$8B00;$8B01;$8B10;$8B11;$8B10;$8B11;$8B10;$8B11;$8B10;$8B11;$8B00;$8B01;$8B00;$8B01;$8B00;$8B01;$8B00;$8B01;$8B10;$8B11;$8B10;$8B11;$8B10;$8B11;$8B10;$8B11)(hull_surface_1_tiled) } { Pattern | Tiled } TABLE#
B $8B00,32,8
@ $8B20 label=skimmer_flip_1
b $8B20 Skimmer flip frames
D $8B20 The three frames of the Skimmer's flip, then a mask for each frame, each laid out as one of #R$8800(the Skimmer images).
N $8B20 #UDGTABLE { #UDGARRAY4,7,3,4,,,,2($8B20-$8B63-1-32:$8C40-$8C83-1-32)(skimmer_flip_1) | #UDGARRAY4,7,3,4,,,,2($8B80-$8BC3-1-32:$8CA0-$8CE3-1-32)(skimmer_flip_2) | #UDGARRAY4,7,3,4,,,,2($8BE0-$8C23-1-32:$8D00-$8D43-1-32)(skimmer_flip_3) } { Frame 1 | Frame 2 | Frame 3 } TABLE#
B $8B20,96,8
@ $8B80 label=skimmer_flip_2
B $8B80,96,8
@ $8BE0 label=skimmer_flip_3
B $8BE0,96,8
@ $8C40 label=skimmer_flip_mask_1
B $8C40,96,8
@ $8CA0 label=skimmer_flip_mask_2
B $8CA0,96,8
@ $8D00 label=skimmer_flip_mask_3
B $8D00,96,8
@ $8D60 label=skimmer_flipped_1
b $8D60 Flipped Skimmer images
D $8D60 The flipped Skimmer, one image for each horizontal offset from its cell's left edge in steps of 2 pixels. Each is laid out as one of #R$8800(the Skimmer images), and takes the mask of the image the right way up.
N $8D60 #UDGTABLE { #UDGARRAY4,7,3,4,,,,2($8D60-$8DA3-1-32:$8980-$89C3-1-32)(skimmer_flipped_1) | #UDGARRAY4,7,3,4,,,,2($8DC0-$8E03-1-32:$89E0-$8A23-1-32)(skimmer_flipped_2) | #UDGARRAY4,7,3,4,,,,2($8E20-$8E63-1-32:$8A40-$8A83-1-32)(skimmer_flipped_3) | #UDGARRAY4,7,3,4,,,,2($8E80-$8EC3-1-32:$8AA0-$8AE3-1-32)(skimmer_flipped_4) } { At the cell edge | 2 pixels right | 4 pixels right | 6 pixels right } TABLE#
B $8D60,96,8
@ $8DC0 label=skimmer_flipped_2
B $8DC0,96,8
@ $8E20 label=skimmer_flipped_3
B $8E20,96,8
@ $8E80 label=skimmer_flipped_4
B $8E80,96,8
@ $8EE0 label=shield_loss_1
b $8EE0 The Skimmer's shield loss frames
D $8EE0 The eight frames of a shield loss. Each frame's image comes before its mask, and each is laid out as one of #R$8800(the Skimmer images).
N $8EE0 #UDGTABLE { #UDGARRAY4,7,3,4,,,,2($8EE0-$8F23-1-32:$8F40-$8F83-1-32)(shield_loss_1) | #UDGARRAY4,7,3,4,,,,2($8FA0-$8FE3-1-32:$9000-$9043-1-32)(shield_loss_2) | #UDGARRAY4,7,3,4,,,,2($9060-$90A3-1-32:$90C0-$9103-1-32)(shield_loss_3) | #UDGARRAY4,7,3,4,,,,2($9120-$9163-1-32:$9180-$91C3-1-32)(shield_loss_4) } { Frame 1 | Frame 2 | Frame 3 | Frame 4 } { #UDGARRAY4,7,3,4,,,,2($91E0-$9223-1-32:$9240-$9283-1-32)(shield_loss_5) | #UDGARRAY4,7,3,4,,,,2($92A0-$92E3-1-32:$9300-$9343-1-32)(shield_loss_6) | #UDGARRAY4,7,3,4,,,,2($9360-$93A3-1-32:$93C0-$9403-1-32)(shield_loss_7) | #UDGARRAY4,7,3,4,,,,2($9420-$9463-1-32:$9480-$94C3-1-32)(shield_loss_8) } { Frame 5 | Frame 6 | Frame 7 | Frame 8 } TABLE#
B $8EE0,96,8
@ $8F40 label=shield_loss_mask_1
B $8F40,96,8
@ $8FA0 label=shield_loss_2
B $8FA0,96,8
@ $9000 label=shield_loss_mask_2
B $9000,96,8
@ $9060 label=shield_loss_3
B $9060,96,8
@ $90C0 label=shield_loss_mask_3
B $90C0,96,8
@ $9120 label=shield_loss_4
B $9120,96,8
@ $9180 label=shield_loss_mask_4
B $9180,96,8
@ $91E0 label=shield_loss_5
B $91E0,96,8
@ $9240 label=shield_loss_mask_5
B $9240,96,8
@ $92A0 label=shield_loss_6
B $92A0,96,8
@ $9300 label=shield_loss_mask_6
B $9300,96,8
@ $9360 label=shield_loss_7
B $9360,96,8
@ $93C0 label=shield_loss_mask_7
B $93C0,96,8
@ $9420 label=shield_loss_8
B $9420,96,8
@ $9480 label=shield_loss_mask_8
B $9480,96,8
@ $94E0 label=hull_surface_2
b $94E0 Sector 2 hull surface
D $94E0 The pattern of the hull surface in sector 2, laid out as #R$8B00(the pattern of sector 1).
N $94E0 #UDGTABLE { #UDGARRAY2,7,4,2($94E0-$94F1-1-16)(hull_surface_2) | #UDGARRAY8,7,2,2($94E0;$94E1;$94E0;$94E1;$94E0;$94E1;$94E0;$94E1;$94F0;$94F1;$94F0;$94F1;$94F0;$94F1;$94F0;$94F1;$94E0;$94E1;$94E0;$94E1;$94E0;$94E1;$94E0;$94E1;$94F0;$94F1;$94F0;$94F1;$94F0;$94F1;$94F0;$94F1;$94E0;$94E1;$94E0;$94E1;$94E0;$94E1;$94E0;$94E1;$94F0;$94F1;$94F0;$94F1;$94F0;$94F1;$94F0;$94F1;$94E0;$94E1;$94E0;$94E1;$94E0;$94E1;$94E0;$94E1;$94F0;$94F1;$94F0;$94F1;$94F0;$94F1;$94F0;$94F1)(hull_surface_2_tiled) } { Pattern | Tiled } TABLE#
B $94E0,32,8
@ $9500 label=hull_surface_3
b $9500 Sector 3 hull surface
D $9500 The pattern of the hull surface in sector 3, laid out as #R$8B00(the pattern of sector 1).
N $9500 #UDGTABLE { #UDGARRAY2,7,4,2($9500-$9511-1-16)(hull_surface_3) | #UDGARRAY8,7,2,2($9500;$9501;$9500;$9501;$9500;$9501;$9500;$9501;$9510;$9511;$9510;$9511;$9510;$9511;$9510;$9511;$9500;$9501;$9500;$9501;$9500;$9501;$9500;$9501;$9510;$9511;$9510;$9511;$9510;$9511;$9510;$9511;$9500;$9501;$9500;$9501;$9500;$9501;$9500;$9501;$9510;$9511;$9510;$9511;$9510;$9511;$9510;$9511;$9500;$9501;$9500;$9501;$9500;$9501;$9500;$9501;$9510;$9511;$9510;$9511;$9510;$9511;$9510;$9511)(hull_surface_3_tiled) } { Pattern | Tiled } TABLE#
B $9500,32,8
@ $9520 label=device_designs
b $9520 Defence device designs
D $9520 The design of each sector's defence device, 48 bytes per sector in sector order: 16 pixel rows of 3 bytes, rows from the top. The third byte of every row is 0, so a design covers 16×16 pixels.
N $9520 #UDGTABLE { #UDGARRAY2,,6,3($9520;$9521;$9538;$9539)(device_design_1) | #UDGARRAY2,,6,3($9550;$9551;$9568;$9569)(device_design_2) | #UDGARRAY2,,6,3($9580;$9581;$9598;$9599)(device_design_3) } { Sector 1 | Sector 2 | Sector 3 } TABLE#
B $9520,48,8 Sector 1
B $9550,48,8 Sector 2
B $9580,48,8 Sector 3
u $95B0 Unused bytes
S $95B0,32
@ $95D0 label=animated_frames
b $95D0 Animated graphic frames
D $95D0 The eight frames of the animated graphic, in the order the game shows them. Each frame holds 3×3 cells in the cell order of a graphic.
N $95D0 #R$B4A7(The animated graphic draw) draws a frame in the attribute of the graphic's layout record, so the renders use black ink on white paper.
N $95D0 #UDGTABLE { #UDGARRAY3,,3($95D0-$9610-8)(animated_frame_1) | #UDGARRAY3,,3($9618-$9658-8)(animated_frame_2) | #UDGARRAY3,,3($9660-$96A0-8)(animated_frame_3) | #UDGARRAY3,,3($96A8-$96E8-8)(animated_frame_4) | #UDGARRAY3,,3($96F0-$9730-8)(animated_frame_5) | #UDGARRAY3,,3($9738-$9778-8)(animated_frame_6) | #UDGARRAY3,,3($9780-$97C0-8)(animated_frame_7) | #UDGARRAY3,,3($97C8-$9808-8)(animated_frame_8) } { Frame 1 | Frame 2 | Frame 3 | Frame 4 | Frame 5 | Frame 6 | Frame 7 | Frame 8 } TABLE#
B $95D0,72,8
B $9618,72,8
B $9660,72,8
B $96A8,72,8
B $96F0,72,8
B $9738,72,8
B $9780,72,8
B $97C8,72,8
@ $9810 label=unused_graphic_1
b $9810 Unused graphics
D $9810 Nothing in the game draws these graphics. The renders take them in a graphic's cell order, as three graphics of 3×2 cells and then eight of 2×2 cells.
N $9810 #UDGTABLE { #UDGARRAY3,,3($9810-$9838-8)(unused_graphic_1) | #UDGARRAY3,,3($9840-$9868-8)(unused_graphic_2) | #UDGARRAY3,,3($9870-$9898-8)(unused_graphic_3) | #UDGARRAY2,,3($98A0-$98B8-8)(unused_graphic_4) | #UDGARRAY2,,3($98C0-$98D8-8)(unused_graphic_5) | #UDGARRAY2,,3($98E0-$98F8-8)(unused_graphic_6) | #UDGARRAY2,,3($9900-$9918-8)(unused_graphic_7) | #UDGARRAY2,,3($9920-$9938-8)(unused_graphic_8) | #UDGARRAY2,,3($9940-$9958-8)(unused_graphic_9) | #UDGARRAY2,,3($9960-$9978-8)(unused_graphic_10) | #UDGARRAY2,,3($9980-$9998-8)(unused_graphic_11) } TABLE#
B $9810,48,8
@ $9840 label=unused_graphic_2
B $9840,48,8
@ $9870 label=unused_graphic_3
B $9870,48,8
@ $98A0 label=unused_graphic_4
B $98A0,32,8
@ $98C0 label=unused_graphic_5
B $98C0,32,8
@ $98E0 label=unused_graphic_6
B $98E0,32,8
@ $9900 label=unused_graphic_7
B $9900,32,8
@ $9920 label=unused_graphic_8
B $9920,32,8
@ $9940 label=unused_graphic_9
B $9940,32,8
@ $9960 label=unused_graphic_10
B $9960,32,8
@ $9980 label=unused_graphic_11
B $9980,32,8
@ $99A0 label=hatch_bitmap
g $99A0 Hatch bitmap
D $99A0 The bitmap of the hatch at the centre of a hatchway, 3×3 cells: 24 pixel rows of 3 bytes, rows from the top. #R$B449(The hatchway draw) stamps two #R$99E8(hatch patterns) into it for each screen. The upper patch takes the first 2 bytes of pixel rows 3–10, and the lower patch those of rows 13–20.
N $99A0 The render shows the bitmap as screen 91 stamps it, in black ink on white paper. Screen 91 lies in sector 1, at row 9 and column 1 of the hull map. ROM byte $045B holds $CD there, which picks pattern 6 for the upper patch and pattern 5 for the lower. A hatchway draws its hatch in the hatchway's own attribute.
N $99A0 #UDGTABLE { #PUSHShatch91 #POKES($99A9,#PEEK($9A38))#POKES($99AA,#PEEK($9A39))#POKES($99AC,#PEEK($9A3A))#POKES($99AD,#PEEK($9A3B))#POKES($99AF,#PEEK($9A3C))#POKES($99B0,#PEEK($9A3D))#POKES($99B2,#PEEK($9A3E))#POKES($99B3,#PEEK($9A3F))#POKES($99B5,#PEEK($9A40))#POKES($99B6,#PEEK($9A41))#POKES($99B8,#PEEK($9A42))#POKES($99B9,#PEEK($9A43))#POKES($99BB,#PEEK($9A44))#POKES($99BC,#PEEK($9A45))#POKES($99BE,#PEEK($9A46))#POKES($99BF,#PEEK($9A47))#POKES($99C7,#PEEK($9A28))#POKES($99C8,#PEEK($9A29))#POKES($99CA,#PEEK($9A2A))#POKES($99CB,#PEEK($9A2B))#POKES($99CD,#PEEK($9A2C))#POKES($99CE,#PEEK($9A2D))#POKES($99D0,#PEEK($9A2E))#POKES($99D1,#PEEK($9A2F))#POKES($99D3,#PEEK($9A30))#POKES($99D4,#PEEK($9A31))#POKES($99D6,#PEEK($9A32))#POKES($99D7,#PEEK($9A33))#POKES($99D9,#PEEK($9A34))#POKES($99DA,#PEEK($9A35))#POKES($99DC,#PEEK($9A36))#POKES($99DD,#PEEK($9A37))#UDGARRAY3,,4,3($99A0-$99D2-1-24)(hatch_screen_91)#POPS } { On screen 91 } TABLE#
N $99A0 #LINK(Graphics#hatch)(The Graphics page) shows the hatch at each step as it opens.
B $99A0,9,3
@ $99A9 label=hatch_upper_patch
B $99A9,30,3
@ $99C7 label=hatch_lower_patch
B $99C7,33,3
@ $99E8 label=hatch_patterns
b $99E8 Hatch patterns
D $99E8 The eight patterns that #R$B449(the hatchway draw) stamps into #R$99A0(the hatch bitmap), 16 bytes each: 8 pixel rows of 2 bytes, rows from the top. Each covers 16×8 pixels.
N $99E8 #UDGTABLE { #UDGARRAY2,,4,2($99E8-$99E9-1-16)(hatch_pattern_1) | #UDGARRAY2,,4,2($99F8-$99F9-1-16)(hatch_pattern_2) | #UDGARRAY2,,4,2($9A08-$9A09-1-16)(hatch_pattern_3) | #UDGARRAY2,,4,2($9A18-$9A19-1-16)(hatch_pattern_4) | #UDGARRAY2,,4,2($9A28-$9A29-1-16)(hatch_pattern_5) | #UDGARRAY2,,4,2($9A38-$9A39-1-16)(hatch_pattern_6) | #UDGARRAY2,,4,2($9A48-$9A49-1-16)(hatch_pattern_7) | #UDGARRAY2,,4,2($9A58-$9A59-1-16)(hatch_pattern_8) } { Pattern 1 | Pattern 2 | Pattern 3 | Pattern 4 | Pattern 5 | Pattern 6 | Pattern 7 | Pattern 8 } TABLE#
B $99E8,16,8
B $99F8,16,8
B $9A08,16,8
B $9A18,16,8
B $9A28,16,8
B $9A38,16,8
B $9A48,16,8
B $9A58,16,8
@ $9A68 label=unused_hatch_pattern_1
b $9A68 Unused hatch patterns
D $9A68 Two patterns in the format of #R$99E8(the hatch patterns) that nothing in the game draws.
N $9A68 #UDGTABLE { #UDGARRAY2,,4,2($9A68-$9A69-1-16)(unused_hatch_pattern_1) | #UDGARRAY2,,4,2($9A78-$9A79-1-16)(unused_hatch_pattern_2) } TABLE#
B $9A68,16,8
@ $9A78 label=unused_hatch_pattern_2
B $9A78,16,8
@ $9A88 label=hostile_designs
b $9A88 Hostile object designs
D $9A88 Thirteen designs of 64 bytes, one of which a new hostile object takes at random from #R$C09B(the refresh register). A design holds 16 pixel rows of 2 bytes for its image, then 16 rows of 2 bytes for its mask, rows from the top.
N $9A88 #R$C227(The image build) makes the shifted images of a design. A mask bit of 1 lets the background show. A hostile object takes the colours of the cells it crosses, so the renders use the play area's white ink on black paper.
N $9A88 #UDGTABLE { #UDGARRAY2,7,4,2,,,,2($9A88-$9A99-1-16:$9AA8-$9AB9-1-16)(hostile_design_1) | #UDGARRAY2,7,4,2,,,,2($9AC8-$9AD9-1-16:$9AE8-$9AF9-1-16)(hostile_design_2) | #UDGARRAY2,7,4,2,,,,2($9B08-$9B19-1-16:$9B28-$9B39-1-16)(hostile_design_3) | #UDGARRAY2,7,4,2,,,,2($9B48-$9B59-1-16:$9B68-$9B79-1-16)(hostile_design_4) | #UDGARRAY2,7,4,2,,,,2($9B88-$9B99-1-16:$9BA8-$9BB9-1-16)(hostile_design_5) | #UDGARRAY2,7,4,2,,,,2($9BC8-$9BD9-1-16:$9BE8-$9BF9-1-16)(hostile_design_6) | #UDGARRAY2,7,4,2,,,,2($9C08-$9C19-1-16:$9C28-$9C39-1-16)(hostile_design_7) } { #UDGARRAY2,7,4,2,,,,2($9C48-$9C59-1-16:$9C68-$9C79-1-16)(hostile_design_8) | #UDGARRAY2,7,4,2,,,,2($9C88-$9C99-1-16:$9CA8-$9CB9-1-16)(hostile_design_9) | #UDGARRAY2,7,4,2,,,,2($9CC8-$9CD9-1-16:$9CE8-$9CF9-1-16)(hostile_design_10) | #UDGARRAY2,7,4,2,,,,2($9D08-$9D19-1-16:$9D28-$9D39-1-16)(hostile_design_11) | #UDGARRAY2,7,4,2,,,,2($9D48-$9D59-1-16:$9D68-$9D79-1-16)(hostile_design_12) | #UDGARRAY2,7,4,2,,,,2($9D88-$9D99-1-16:$9DA8-$9DB9-1-16)(hostile_design_13) } TABLE#
B $9A88,64,8
B $9AC8,64,8
B $9B08,64,8
B $9B48,64,8
B $9B88,64,8
B $9BC8,64,8
B $9C08,64,8
B $9C48,64,8
B $9C88,64,8
B $9CC8,64,8
B $9D08,64,8
B $9D48,64,8
B $9D88,64,8
@ $9DC8 label=shot_graphics
b $9DC8 Shot graphics
D $9DC8 The graphic of each shot for each direction, 8 bytes each, one per pixel row from the top. The four of the pulse laser shot come first, then the four of the hostile objects' shot. Each set of four runs in the order left, right, up, down.
N $9DC8 The renders use the colours that #R$BF19(the shot draw) gives each shot. The pulse laser shot takes bright red ink on black paper, and the hostile objects' shot bright yellow ink.
N $9DC8 #UDGTABLE { =h,c4 Pulse laser shot | =h,c4 Hostile objects' shot } { #UDG$9DC8,66,4(shot_graphic_1) | #UDG$9DD0,66,4(shot_graphic_2) | #UDG$9DD8,66,4(shot_graphic_3) | #UDG$9DE0,66,4(shot_graphic_4) | #UDG$9DE8,70,4(shot_graphic_5) | #UDG$9DF0,70,4(shot_graphic_6) | #UDG$9DF8,70,4(shot_graphic_7) | #UDG$9E00,70,4(shot_graphic_8) } { Left | Right | Up | Down | Left | Right | Up | Down } TABLE#
B $9DC8,64,8
@ $9E08 label=explosion_frames
g $9E08 Explosion frames
D $9E08 The seven frames of a hostile object's explosion, 48 bytes each: 16 pixel rows of 3 bytes, rows from the top. A frame sits at the horizontal offset that #R$A018(the frame offsets) record for it, and #R$C526(the frame shift) rewrites it in place for another offset.
N $9E08 The renders show the frames as the game loads them, at the cell edge, through #R$9F58(the first explosion mask). They use the bright yellow ink on black paper that #R$C44B(the explosion step) paints over an explosion.
N $9E08 #UDGTABLE { #UDGARRAY3,70,4,3,,,,2($9E08-$9E22-1-24:$9F58-$9F72-1-24)(explosion_frame_1) | #UDGARRAY3,70,4,3,,,,2($9E38-$9E52-1-24:$9F58-$9F72-1-24)(explosion_frame_2) | #UDGARRAY3,70,4,3,,,,2($9E68-$9E82-1-24:$9F58-$9F72-1-24)(explosion_frame_3) | #UDGARRAY3,70,4,3,,,,2($9E98-$9EB2-1-24:$9F58-$9F72-1-24)(explosion_frame_4) | #UDGARRAY3,70,4,3,,,,2($9EC8-$9EE2-1-24:$9F58-$9F72-1-24)(explosion_frame_5) | #UDGARRAY3,70,4,3,,,,2($9EF8-$9F12-1-24:$9F58-$9F72-1-24)(explosion_frame_6) | #UDGARRAY3,70,4,3,,,,2($9F28-$9F42-1-24:$9F58-$9F72-1-24)(explosion_frame_7) } { Frame 1 | Frame 2 | Frame 3 | Frame 4 | Frame 5 | Frame 6 | Frame 7 } TABLE#
B $9E08,48,8
B $9E38,48,8
B $9E68,48,8
B $9E98,48,8
B $9EC8,48,8
B $9EF8,48,8
B $9F28,48,8
@ $9F58 label=explosion_masks
b $9F58 Explosion masks
D $9F58 The mask of an explosion frame for each horizontal offset from the cell's left edge, in steps of 2 pixels. Each is laid out as one of #R$9E08(the explosion frames), and a mask bit of 1 lets the background show. The #R$C2A9(defence device) draws through the first of them too.
N $9F58 The renders draw each mask bit of 1 in black ink on white paper.
N $9F58 #UDGTABLE { #UDGARRAY3,,4,3($9F58-$9F72-1-24)(explosion_mask_1) | #UDGARRAY3,,4,3($9F88-$9FA2-1-24)(explosion_mask_2) | #UDGARRAY3,,4,3($9FB8-$9FD2-1-24)(explosion_mask_3) | #UDGARRAY3,,4,3($9FE8-$A002-1-24)(explosion_mask_4) } { At the cell edge | 2 pixels right | 4 pixels right | 6 pixels right } TABLE#
B $9F58,48,8
B $9F88,48,8
B $9FB8,48,8
B $9FE8,48,8
@ $A018 label=explosion_offsets
g $A018 Explosion frame offsets
D $A018 The horizontal offset of each #R$9E08(explosion frame), one byte per frame in frame order. It runs from 0 at the cell edge to 3 for 6 pixels right.
B $A018,7,1
B $A01F,1 Unused
@ $A020 label=font
b $A020 Font
D $A020 The game's font, 39 glyphs of 8 bytes, one byte per pixel row from the top. The table gives the character that each glyph prints, in glyph order.
N $A020 #UDGTABLE { #FONT$A020,39,56,2(font) } TABLE#
N $A020 #UDGTABLE { =h Glyphs | =h Characters } { #UDGARRAY10,,2($A020-$A068-8)(font_digits) | 0–9 } { #UDG$A070,,2(font_second_zero) | A second 0, which a #R$D2E6(control panel digit) rolls into after 9 } { #UDG$A078,,2(font_space) | Space } { #UDGARRAY13,,2($A080-$A0E0-8)(font_letters_1) | A–M } { #UDGARRAY13,,2($A0E8-$A148-8)(font_letters_2) | N–Z } { #UDG$A150,,2(font_slash) | [, which the font draws as a slash } TABLE#
B $A020,312,8
@ $A158 label=control_panel
b $A158 Control panel
D $A158 The graphic of the control panel. Its left half and then its right half hold 16×6 cells each, in the cell order of a graphic. The colour pattern of each half follows, one attribute per cell, row by row from the top.
N $A158 #R$B812(The panel draw) draws the panel. The render takes each cell's colour from its half's pattern, as the game does. It leaves out the readouts that the game prints over the panel.
N $A158 #UDGTABLE { #UDGARRAY32,,2($A158-$A1D0-8;$A458-$A4D0-8;$A1D8-$A250-8;$A4D8-$A550-8;$A258-$A2D0-8;$A558-$A5D0-8;$A2D8-$A350-8;$A5D8-$A650-8;$A358-$A3D0-8;$A658-$A6D0-8;$A3D8-$A450-8;$A6D8-$A750-8)[$A758-$A767;$A7B8-$A7C7;$A768-$A777;$A7C8-$A7D7;$A778-$A787;$A7D8-$A7E7;$A788-$A797;$A7E8-$A7F7;$A798-$A7A7;$A7F8-$A807;$A7A8-$A7B7;$A808-$A817](control_panel) } TABLE#
B $A158,768,8 Left half
@ $A458 label=control_panel_right
B $A458,768,8 Right half
@ $A758 label=colour_pat_33
B $A758,96,16 Colour pattern of the left half
@ $A7B8 label=colour_pat_34
B $A7B8,96,16 Colour pattern of the right half
@ $A818 label=inner_graphic_dir
b $A818 Inner section graphic directory
D $A818 The record of each of the 18 graphics of the inner sections, by graphic number from 0, 4 bytes per graphic. Each record is laid out as one of #R$6200(the outer hull's graphic directory).
W $A818,2 Pixels
B $A81A,2 Width and height in cells
W $A81C,2 Pixels
B $A81E,2 Width and height in cells
W $A820,2 Pixels
B $A822,2 Width and height in cells
W $A824,2 Pixels
B $A826,2 Width and height in cells
W $A828,2 Pixels
B $A82A,2 Width and height in cells
W $A82C,2 Pixels
B $A82E,2 Width and height in cells
W $A830,2 Pixels
B $A832,2 Width and height in cells
W $A834,2 Pixels
B $A836,2 Width and height in cells
W $A838,2 Pixels
B $A83A,2 Width and height in cells
W $A83C,2 Pixels
B $A83E,2 Width and height in cells
W $A840,2 Pixels
B $A842,2 Width and height in cells
W $A844,2 Pixels
B $A846,2 Width and height in cells
W $A848,2 Pixels
B $A84A,2 Width and height in cells
W $A84C,2 Pixels
B $A84E,2 Width and height in cells
W $A850,2 Pixels
B $A852,2 Width and height in cells
W $A854,2 Pixels
B $A856,2 Width and height in cells
W $A858,2 Pixels
B $A85A,2 Width and height in cells
W $A85C,2 Pixels
B $A85E,2 Width and height in cells
@ $A860 label=inner_graphic_0
b $A860 Inner section graphics
D $A860 The 18 graphics that #R$A818(the inner section graphic directory) lists, each 8 bytes per cell in the cell order of a graphic.
N $A860 The renders show each graphic under its graphic number. The colours come from the screen layout, so the renders use black ink on white paper.
N $A860 #UDGTABLE { #UDGARRAY1,,2($A860-$A860-8)(inner_graphic_0) | #UDGARRAY1,,2($A868-$A868-8)(inner_graphic_1) | #UDGARRAY1,,2($A870-$A870-8)(inner_graphic_2) | #UDGARRAY1,,2($A878-$A878-8)(inner_graphic_3) | #UDGARRAY6,,2($A880-$A908-8)(inner_graphic_4) | #UDGARRAY6,,2($A910-$A998-8)(inner_graphic_5) } { 0 | 1 | 2 | 3 | 4 | 5 } { #UDGARRAY5,,2($A9A0-$AA10-8)(inner_graphic_6) | #UDGARRAY4,,2($AA18-$AA70-8)(inner_graphic_7) | #UDGARRAY4,,2($AA78-$AAD0-8)(inner_graphic_8) | #UDGARRAY4,,2($AAD8-$AB30-8)(inner_graphic_9) | #UDGARRAY3,,2($AB38-$ABC0-8)(inner_graphic_10) | #UDGARRAY3,,2($ABC8-$AC38-8)(inner_graphic_11) } { 6 | 7 | 8 | 9 | 10 | 11 } { #UDGARRAY3,,2($AC40-$ACB0-8)(inner_graphic_12) | #UDGARRAY3,,2($ACB8-$AD10-8)(inner_graphic_13) | #UDGARRAY3,,2($AD18-$AD70-8)(inner_graphic_14) | #UDGARRAY3,,2($AD78-$ADD0-8)(inner_graphic_15) | #UDGARRAY5,,2($ADD8-$AE98-8)(inner_graphic_16) | #UDGARRAY2,,2($AEA0-$AEB8-8)(inner_graphic_17) } { 12 | 13 | 14 | 15 | 16 | 17 } TABLE#
B $A860,8,8
@ $A868 label=inner_graphic_1
B $A868,8,8
@ $A870 label=inner_graphic_2
B $A870,8,8
@ $A878 label=inner_graphic_3
B $A878,8,8
@ $A880 label=inner_graphic_4
B $A880,144,8
@ $A910 label=inner_graphic_5
B $A910,144,8
@ $A9A0 label=inner_graphic_6
B $A9A0,120,8
@ $AA18 label=inner_graphic_7
B $AA18,96,8
@ $AA78 label=inner_graphic_8
B $AA78,96,8
@ $AAD8 label=inner_graphic_9
B $AAD8,96,8
@ $AB38 label=inner_graphic_10
B $AB38,144,8
@ $ABC8 label=inner_graphic_11
B $ABC8,120,8
@ $AC40 label=inner_graphic_12
B $AC40,120,8
@ $ACB8 label=inner_graphic_13
B $ACB8,96,8
@ $AD18 label=inner_graphic_14
B $AD18,96,8
@ $AD78 label=inner_graphic_15
B $AD78,96,8
@ $ADD8 label=inner_graphic_16
B $ADD8,200,8
@ $AEA0 label=inner_graphic_17
B $AEA0,32,8
u $AEC0 Unused bytes
S $AEC0,320
@ $B000 label=boot
c $B000 Jump to the main loop
@ $B003 label=clear_screen
c $B003 Clear the screen
D $B003 Blanks the screen to white ink on black paper, and resets the attribute mirror.
  $B003 Clear the pixels. Each fill seeds the first byte and lets LDIR copy every byte onto the next.
  $B010 Colour every cell white ink on black paper.
  $B01D,12 Give every cell of the attribute mirror the bright graphic mark that stops the Skimmer, hostile objects and shots, and no other.
@ $B02A label=draw_hull_surface
c $B02A Draw the hull surface
D $B02A Tiles the play area with the hull pattern of the current sector, in bands of 16 pixel rows from the top. Inside the hull it clears the play area instead.
  $B02A Start at the play area's top pixel row.
@ $B02D label=hull_band
  $B02D Set up a band of 16 pixel rows, with 16 copies of the pattern's row across each. Make the pattern step rewind after each copy.
@ $B032 ssub=LD ($B058),A
  $B035 Is the Skimmer inside the hull?
  $B03A If so, clear the play area instead
  $B03D Start from the hull pattern of sector 1, 2 bytes per pixel row like the other two.
  $B043 Is the Skimmer in sector 1? Jump if so
  $B046 Take the pattern of sector 2. Is the Skimmer in it? Jump if so
  $B04C Take the pattern of sector 3.
@ $B04F label=draw_hull_rows
c $B04F Draw rows of a hull pattern
D $B04F Draws pixel rows of a hull pattern down the screen, with each row of the pattern repeated across its pixel row. Unless #R$BD43(the one-band flag) holds 1, it goes on in bands to the bottom of the screen.
R $B04F I:B copies of the pattern's two-byte row across each pixel row
R $B04F I:C pixel rows in a band
R $B04F I:DE address of the pattern
R $B04F I:HL screen address of the first pixel row
  $B04F Keep the band's counts and the row's screen address.
@ $B051 label=hull_row_copy
  $B051 Copy the pattern row's two bytes to the screen.
@ $B058 label=hull_pattern_step
  $B058 Step back to the pattern row's first byte, so that the next copy repeats the row. A patch to do nothing makes each copy skip the pattern row's third byte.
  $B059 Copy the row across the pixel row.
  $B05B Move on to the pattern's next row.
  $B05D Move down a pixel row. Is it in the same cell row? Jump if so
  $B064 Move down a cell row. Is it in the next third of the screen? Jump if so
  $B06A Stay in this third.
@ $B06E label=hull_next_row
  $B06E Count the band's pixel rows, and draw the next one.
  $B073 Is a single band wanted?
  $B078 Return if so
  $B079 Does the band reach the bottom of the screen?
  $B07C Return if so
  $B07D Draw the next band from the pattern's first row.
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
  $B22F Recover the cell and the attribute, and go on into #R$B231 to draw the graphic.
@ $B231 label=plot_graphic
c $B231 Draw a graphic from outside the directories
D $B231 Draws a graphic from its pixels and its two size bytes, and colours it, as #R$B20A(the graphic draw) does for a graphic of the directories.
R $B231 I:A attribute of the graphic, or $80 to draw its pixels alone
R $B231 I:B height byte, with the height in cells and the mask number
R $B231 I:C width byte, with the width in cells and the colour pattern
R $B231 I:DE address of the graphic's pixels
R $B231 I:H character row of the graphic's top-left cell
R $B231 I:L column of the graphic's top-left cell
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
c $B27D Draw a graphic with no mask
D $B27D Draws a graphic with no mask, at a size that can run past 7 cells each way. The caller first sets the attribute, the mirror mark, the colour pattern and the top-left cell's attribute address (#R$BD11).
R $B27D I:B height in cells
R $B27D I:C width in cells
R $B27D I:DE address of the graphic's pixels
R $B27D I:HL screen address of the top pixel row of the graphic's top-left cell
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
c $B33B Cast the shadow of a block of cells
D $B33B Casts the shadow of a block of cells, unless the block is unmarked or the Skimmer is inside the hull.
R $B33B I:B height of the block in cells
R $B33B I:C width of the block in cells
R $B33B I:HL attribute mirror address of the cell below the block's bottom-left cell
R $B33B O:HL' attribute mirror address of the cell below the block's bottom-left cell, after an exchange of the register sets
  $B33B Is the block unmarked?
  $B341 Jump if so: it casts no shadow
  $B343 Is the Skimmer inside the hull?
  $B348 Jump if so: nothing casts a shadow there
@ $B34A label=draw_shadow
c $B34A Cast the shadow of a block, marked or not
D $B34A Casts the shadow of a block of cells, marked or not. It leaves through a pop that takes its own return address, so a CALL to it returns to its caller's caller.
N $B34A A shadow covers the cells the block sweeps over as it slides one cell down and one cell right. It forms a band under the block and up its right side, with a half cell cut at 45° at each end. It shades only cells that the attribute mirror leaves clear (#R$B7B7).
R $B34A I:B height of the block in cells
R $B34A I:C width of the block in cells
R $B34A I:HL attribute mirror address of the cell below the block's bottom-left cell
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
N $B363 The tests of the right edge and the top cell read the layout graphic's column and row. They differ from the block's own only for the graphics of a run down column 0, below the first, and for graphic 79's second shadow.
  $B363 Step past the block's right side. Does that column, counted from the current layout graphic, lie off the screen?
  $B36B Jump if so: no right edge
  $B36D The right edge rises one cell per row of the block.
@ $B36E label=shade_right_cell
  $B36E Shade the right edge in full, from the bottom row up.
  $B37B Is the layout graphic on the top row of the play area? If so, its top cell is in full. If its block carries on into the screen above, the full cell lets its shadow run on across the join with no notch.
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
@ $B4C5 ssub=LD A,(graphic_pixel_addr+1)
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
N $B548 #R$D8DC(The outer hull layouts) give the format of a layout's records.
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
@ $B5BD ssub=LD DE,(draw_attr-1)
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
@ $B60D ssub=LD DE,(draw_attr-1)
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
  $B6F8,10 Set up the device at the cell, and copy its record into the slot.
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
  $B72D Mark it as the defence device. Its steer count takes the same value, which no code reads for the device.
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
  $B7B7 Does the cell carry a mark that keeps shadows off, a bright graphic's or a bar's? Return if so. The test takes bit 7 too, which no cell of the play area holds.
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
D $B812 Draws the control panel over the top six rows of the screen, as two halves with their own colour patterns.
N $B812 While #R$BD34(the shadow switch) holds 0, #R$B27D(the unmasked graphic draw) also casts a shadow from each half. No shadow shows, because every cell it reaches holds the bright graphic mark from #R$B003(the screen clear).
  $B812 Draw in bright white ink. The colour patterns give every cell of the panel an attribute of their own, so no cell takes this one.
  $B817 Colour the left half from its own colour pattern.
  $B81C Mark the panel's cells as a bright graphic in the attribute mirror.
  $B821 Draw the left half from #R$A158(its graphic), in the top-left corner of the screen.
  $B833 Colour the right half from its own colour pattern.
  $B838,18 Draw the right half from #R$A458(its graphic), beside the left half.
@ $B84B label=clear_play_area
@ $B84B keep
c $B84B Clear the play area
D $B84B Blanks every pixel of the play area, across the whole width of the screen.
R $B84B I:HL screen address of the top pixel row of the play area's first cell
  $B84B Blank each pixel row of the play area in turn, the full width of the screen.
@ $B850 label=clear_screen_top
c $B850 Clear the top of the screen
D $B850 Blanks the pixels of rows 1–4 of the screen, all but their first and last columns.
  $B850 Start at the top pixel row of row 1, one column in.
@ $B856 label=clear_pixel_rows
N $B856 This loop blanks a block of pixel rows from #REGhl down the screen. #REGb counts the pixel rows, and #REGc holds the number of bytes along each row.
  $B856 Start a pixel row, with its width as the count.
@ $B859 label=clear_fill
  $B859 Take the fill byte, which #R$BAC6(the main loop) makes a blank one.
@ $B85B label=clear_row_byte
  $B85B Fill each byte along the row.
  $B85F Step down one pixel row. Is it still in the same character row?
  $B864 Jump if so
  $B866 Move on to the next character row. Did that cross into the next screen third?
  $B86A Jump if so: the pixel row step already points into it.
  $B86C Stay in this third, at the top pixel row of the next character row.
@ $B870 label=clear_next_row
  $B870,3 Blank the next pixel row, until the block is done.
@ $B874 label=colour_play_area
c $B874 Colour the play area
D $B874 Gives every cell of the play area one value, either an attribute or a set of marks in the attribute mirror.
R $B874 I:HL address of the cell at the start of row 6, in the attributes or in the attribute mirror
  $B874 Cover every row of the play area, the full width of the screen, one row of cells apart.
@ $B87A label=play_area_colour
  $B87A Take the value, which the caller patches into this instruction first.
@ $B87C label=fill_area_row
  $B87C Start a row of cells.
@ $B87F label=fill_area_cell
  $B87F Give each cell along the row the value.
  $B883,5 Step down to the next row of cells, until the play area is done.
@ $B889 label=print_shields
c $B889 Print the number of shields
D $B889 Prints the number of shields left in bright white, in the left half of the control panel.
R $B889 O:DE attribute address of the cell after the count's cell
  $B889 Point at the count's cell, and fetch the number of shields.
@ $B88F label=print_digit
N $B88F This entry point prints the digit in #REGa at the row in #REGb and the column in #REGc, in bright white.
  $B88F Find the cell's screen addresses.
  $B893 Print in bright white ink on black paper.
  $B898,6 Turn the digit into its character, and print it.
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
t $BA06 WALL DONE message
D $BA06 Three lines printed by #R$B4D9 on the WALL DONE screen, which ends the game, in the message format of #R$B89F.
T $BA06,54,n3:9:n1,n3:13:n1,n3:20:n1 Bright white
@ $BA3C label=redefine_keys
c $BA3C Redefine-keys screen
D $BA3C Asks for a key for each of the six controls of #R$B9BD(the control names), and shows the name of each key it takes. The keys become the keyboard's controls, and the new flip key also serves every joystick.
  $BA3C Clear the screen, and print the title and the prompt.
  $BA45 Set the draw attribute to white. This has no effect: each control's name sets it again before any character prints.
  $BA4A Ask for the six controls in turn, from up to flip. Their key codes go to #R$BC21(the redefinable keys) in that order.
@ $BA52 label=ask_control_key
  $BA52 Find the cells after the prompt's last word, where the key's name shows.
@ $BA5F label=hide_key_name
  $BA5F Hide the last key's name with black ink on black paper.
  $BA63 Print the control's name in the gap of the prompt.
  $BA67 Wait for a new key press.
  $BA6B Point at the next control's name.
  $BA6F Is the key code past the last key? #R$BC37(The keyboard scan) never gives one.
  $BA71 Jump if so
  $BA73 Store the key code for the control.
N $BA75 The key's name is the one after as many names as its key code, in #R$B987(the key names). Each name starts on a byte with bit 7 set.
  $BA75 Switch register sets to keep the count of controls, and start at the first name. Is it the first key?
  $BA7C Jump if so
@ $BA7E label=find_key_name
  $BA7E Step to the start of the next name, once for each key before this one.
@ $BA87 label=show_key_name
  $BA87 Find the cell after the prompt, and point at the name.
@ $BA8F label=print_key_char
  $BA8F Print each letter of the name without its bit 7, up to the next name's first byte. The name takes the bright white of the control's name.
  $BA9E Hold the name on the screen for about 0.3 s, then switch register sets back and ask for the next control.
  $BAA4 Copy the new fire and flip keys into the control key sets at #R$F480(the key copy), which returns from this routine.
@ $BAA7 label=unused_flip_copy
b $BAA7 Unused copy of the flip key
D $BAA7 Three instructions that no routine calls. They store a key code as the flip key of the Sinclair and the cursor joystick, as #R$F480(the key copy) does.
B $BAA7,7
@ $BAAE label=toggle_method_bar
c $BAAE Highlight bar on the selected control method
D $BAAE Toggles the highlight bar over the title-screen line of #R$BD24(the selected control method). A second call removes the highlight.
  $BAAE Find the first cell of the method's line in the menu. The keyboard's line is on the screen's fifth row, and each other method's line is three rows below the one before.
  $BABC Count the cells of the line.
@ $BABE label=swap_bar_colours
  $BABE,7 Exchange yellow and black between the ink and the paper of each cell. Bright yellow on black turns to black on bright yellow, and back.
@ $BAC6 label=main_loop
c $BAC6 Main loop
D $BAC6 Runs the title screen and its menu, and plays a game when the player starts one. A game that ends on the WALL DONE screen goes straight back to the title screen, and any other shows GAME OVER first.
  $BAC6 Set up the stack and the interrupts, once as the game starts.
@ $BACE ssub=LD ($B859+1),A
  $BACD Make #R$B856(the pixel row clear) blank its rows, and turn the border black and the speaker off.
@ $BAD3 label=new_game
N $BAD3 A new game starts here.
  $BAD3 Refill the Skimmer's shields, clear the end of the game, and start on the outer hull.
@ $BADF label=show_title
  $BADF Clear the screen and print the title screen.
@ $BAE8 label=show_method_bar
  $BAE8 Highlight the line of the selected control method.
@ $BAEB label=menu_tune
  $BAEB Play the title tune until a key is pressed, and take the key's code.
  $BAF1 Look the key up among #R$B9F3(the menu keys), and count the options that do not match.
@ $BAF8 label=match_menu_key
  $BAF8 Is it this option's key?
  $BAF9 Jump if so
  $BAFB Try the next option, until none is left.
  $BAFF It is no menu key: play the tune again.
@ $BB01 label=menu_key_found
  $BB01 Is it the redefine-keys option?
  $BB04 Jump if not
  $BB06 Redefine the keys, then show the title screen again.
@ $BB0B label=test_start_key
  $BB0B Jump if it is the start-game option, the one after the redefine-keys option.
  $BB0D Take the highlight off the old control method, and select the new one.
  $BB15 Highlight it, and wait for the next key.
@ $BB17 label=start_game
N $BB17 The player starts a game.
  $BB17 Clear the top of the screen, and draw the control panel there with the shield count. The panel overwrites every pixel that the clear blanks.
  $BB20 Start on the second screen of the hull map's top row, with no defence device destroyed.
  $BB32 Play the game until it ends. Did it end on the WALL DONE screen?
  $BB37 Jump if so, to start a new game
  $BB3A Print GAME OVER.
  $BB40 Count the pauses.
@ $BB42 label=hold_game_over
  $BB42 Hold the message for about 6 seconds at the 3.5 MHz clock, longer by the time the interrupt routine takes.
  $BB47 Start a new game.
@ $BB4A label=print_message
c $BB4A Print a message
D $BB4A Prints a message in the format of #R$B89F(the title screen text), one line at a time.
R $BB4A I:HL address of the message
R $BB4A O:BC address of the message's end byte
  $BB4A Fetch the line's column and row, and keep its attribute for every character on the line.
  $BB53 Find the screen addresses of the line's first cell, and keep the address of its first character.
@ $BB57 label=message_byte
  $BB57 Fetch the next byte. Is it the end of the message?
  $BB5B Return if so
  $BB5C Jump if the byte is a character
  $BB5F The byte ends the line. Print the next line, from the byte after it.
@ $BB65 label=message_char
  $BB65 Keep the address of the next byte, print the character, and go on.
@ $BB6D label=print_char
c $BB6D Print a character
D $BB6D Draws one character of #R$A020(the game's font) in a cell, and colours the cell with #R$BD15(the draw attribute).
N $BB6D The font holds 8 bytes per glyph, one for each pixel row from the top. A space takes glyph 11. A code below the colon takes its value less the code of 0, and any other code its value less $35. So the digits take glyphs 0–9, the capitals take glyphs 12–37, and [ takes glyph 38. #R$A020(The font) shows the character that each glyph prints.
R $BB6D I:A character code: a space, a digit, a capital or [
R $BB6D I:DE attribute address of the cell
R $BB6D I:HL screen address of the cell's top pixel row
R $BB6D O:DE attribute address of the next cell to the right
R $BB6D O:HL screen address of the next cell's top pixel row
  $BB6D Is it a space?
  $BB6F Jump if not
  $BB71 Take the blank glyph.
@ $BB76 label=char_digit_test
  $BB76 Is it a digit?
  $BB78 Jump if not
  $BB7A Take the digit's glyph.
@ $BB7F label=char_letter
  $BB7F Take the capital's glyph, or the slash for [.
@ $BB81 label=glyph_addr
  $BB81 Point at the glyph in the font, 8 bytes per glyph. Each path leaves the carry clear, so the three rotations multiply the glyph number by 8.
@ $BB89 ssub=ADD A,font%$100
@ $BB8C ssub=LD A,font/$100
  $BB90 Walk the glyph's pixel rows from the top.
@ $BB93 label=glyph_row
  $BB93 Copy each pixel row of the glyph down the cell.
  $BB99,8 Step to the next cell, and colour this one.
@ $BBA2 label=read_controls
c $BBA2 Read the controls
D $BBA2 Gives the controls held, from the keys or the joystick of #R$BD24(the control method). During a push on the Skimmer it holds the directions the Skimmer moves in, and gives no controls over the push's last four passes.
R $BBA2 O:A controls held, one bit for each control as in #R$D2B4(the controls in force)
  $BBA2 Does a push on the Skimmer run?
  $BBA7 Jump if not
  $BBA9 Count the push down. Is it near its end?
  $BBAF Jump if not
  $BBB1,1 Give no controls.
@ $BBB3 label=hold_push_dirs
  $BBB3 Start with no controls. Does the Skimmer move across the screen?
  $BBBA Jump if not
  $BBBD Jump if it moves right
  $BBC0 Hold left.
@ $BBC5 label=hold_right
  $BBC5 Hold right.
@ $BBC7 label=hold_vertical
  $BBC7 Does the Skimmer move up or down?
  $BBCD Return if not, with the direction across alone
  $BBCE Jump if it moves down
  $BBD1,2 Hold up.
@ $BBD4 label=hold_down
  $BBD4,2 Hold down.
@ $BBD7 label=scan_control_keys
  $BBD7 Is it the keyboard?
  $BBDC Jump if so
  $BBDE Number the joysticks' sets from the Kempston joystick's, which shares the keyboard's set.
@ $BBDF label=control_set_addr
  $BBDF Point at the method's set of keys, 8 bytes per set.
@ $BBE2 ssub=ADC A,control_keys%$100
@ $BBE5 ssub=LD H,control_keys/$100
  $BBE9 Never runs: no set of keys lies past the page.
@ $BBEA label=collect_controls
  $BBEA Collect one bit for each key. The first key's bit ends up highest, and a marker bit leaves the top after the sixth key.
@ $BBEC label=test_control_key
  $BBEC Test the next key, and shift a 1 into the bits if it is held. Go on until the marker bit drops out.
  $BBF6 Is it the Kempston joystick?
  $BBFC Return if not, with the keys' bits
  $BBFD,6 Keep the flip key's bit, and read the other five controls from the joystick's port.
@ $BC04 label=test_key
c $BC04 Test one key
D $BC04 Tests whether one key is held, by its key code.
N $BC04 A key code is eight times the key's place in its half-row, plus the half-row's number. Place 0 is the key nearest the middle of the keyboard, and place 4 the key at the row's end.
N $BC04 #TABLE(default) { =h Half-row | =h Keys, from place 0 to place 4 } { 0 | B, N, M, SYMBOL SHIFT, SPACE } { 1 | H, J, K, L, ENTER } { 2 | Y, U, I, O, P } { 3 | 6 to 0 } { 4 | 5 to 1 } { 5 | T, R, E, W, Q } { 6 | G, F, D, S, A } { 7 | V, C, X, Z, CAPS SHIFT } TABLE#
R $BC04 I:A key code, 0–39
R $BC04 O:F carry clear if the key is held
  $BC04 The half-row's number, plus one, counts the rotations of the port byte.
  $BC09 The place picks the key's bit, and so the number of shifts that bring that bit into the carry.
  $BC13 Start from a port byte with only bit 0 reset.
@ $BC15 label=half_row_select
  $BC15 Rotate it right once for each count, which selects the half-row.
  $BC18 Read the half-row.
@ $BC1A label=key_bit_shift
  $BC1A,4 Shift the key's bit into the carry, which is clear for a key held.
@ $BC1F label=control_keys
g $BC1F Control keys
D $BC1F The key code of each control in three sets, eight bytes per set: the keyboard's, the Sinclair joystick's and the cursor joystick's. Key codes follow #R$BC04(the key test).
N $BC1F #TABLE(default) { =h Byte | =h Control | =h Keyboard | =h Sinclair joystick | =h Cursor joystick } { 0 | Flip | CAPS SHIFT | CAPS SHIFT | CAPS SHIFT } { 1 | Fire | 0 | 5 | 0 } { 2 | Up | O | 4 | 7 } { 3 | Down | K | 3 | 6 } { 4 | Left | Z | 1 | 5 } { 5 | Right | X | 2 | 8 } { 6 | Fire | From the redefine-keys screen | Unused | Unused } { 7 | Flip | From the redefine-keys screen | Unused | Unused } TABLE#
N $BC1F The table names the pre-defined keys, which the redefine-keys screen can replace in the keyboard's set and in the flip of every set.
B $BC1F,2 Keyboard's flip and fire
@ $BC21 label=redefinable_keys
B $BC21,6 Keyboard's up, down, left and right, then the fire and flip from the redefine-keys screen
B $BC27,8 Sinclair joystick's set
B $BC2F,8 Cursor joystick's set
@ $BC37 label=scan_keyboard
c $BC37 Scan the keyboard
D $BC37 Finds the one key held, if any, and gives its #R$BC04(key code).
R $BC37 O:D key code of the key held, or $FF for none
R $BC37 O:F zero flag clear if two or more keys are held
  $BC37 Start at the half-row of CAPS SHIFT to V, with no key found. Keep the half-row's number plus 40 for the key code.
@ $BC3D label=scan_half_row
  $BC3D Read the half-row. Is any of its keys held?
  $BC42 Jump if not
  $BC44 Return if a key of an earlier half-row is held too
  $BC46 Start from the half-row's number plus 40.
@ $BC48 label=find_key_place
  $BC48 Step the code back one place for each bit, from bit 0 up to the held key's bit.
  $BC4E Return if another key of the half-row is held too
  $BC4F Keep the key code.
@ $BC50 label=next_half_row
  $BC50 Move on to the next half-row, until all eight are read.
  $BC55,1 Set the zero flag: at most one key is held.
@ $BC57 label=wait_new_key
c $BC57 Wait for a new key press
D $BC57 Waits until no key is held, then until one key alone is held, and gives its key code.
R $BC57 O:A key code of the key, 0–39
  $BC57 Wait until no key is held.
@ $BC5D label=wait_key
N $BC5D This entry point waits for one key alone. It does not first wait until no key is held.
  $BC5D Wait while two or more keys are held.
  $BC62 Wait while no key is held.
  $BC65,2 Give the key code.
@ $BC68 label=unused_draw_steps
b $BC68 Unused pattern draw steps
D $BC68 Steps of code that nothing in the game copies or runs. Each loads a pattern byte and puts it in a screen byte.
B $BC68,8,4
  $BC68 Store the pattern byte over the screen byte
  $BC6C Store the pattern byte ANDed with the screen byte
@ $BC70 label=draw_pattern_row
c $BC70 Draw a row of one pattern
D $BC70 Draws one 8×8 pattern in every cell along a row of cells, in #R$BD15(the draw attribute) and with #R$BD23(the mirror mark). It keeps the first cell's attribute address at #R$BD11 and its attribute mirror address at #R$BD13.
R $BC70 I:B character row of the first cell
R $BC70 I:C column of the first cell
R $BC70 I:E number of cells (0 for 256)
R $BC70 I:HL address of the pattern, one byte for each pixel row from the top
  $BC70 Keep the attribute, the count and the pattern.
  $BC76 Find the first cell's screen addresses, and keep its attribute address.
  $BC7D Take back the pattern's address and the count.
  $BC7F Walk the pattern's pixel rows from the top.
@ $BC81 label=pat_row_line
  $BC81 Start the pixel row at the first cell.
@ $BC84 label=pat_row_byte
  $BC84 Copy the pattern's byte into the pixel row of each cell, over what was there.
  $BC8B Move on to the pattern's next byte and the next pixel row.
  $BC91 Start at the first cell's attribute, with the draw attribute.
@ $BC96 label=pat_row_attr
  $BC96 Colour each cell along the row.
  $BC9A Find the first cell in the attribute mirror, and keep its address.
@ $BC9E ssub=ADD A,(attr_mirror-$5800)/256
  $BCA4 Does the pattern mark its cells?
  $BCAA Return if not
  $BCAB Take the mark.
@ $BCAC label=pat_row_mark
  $BCAC,6 Set the mark's bits in the marks of each cell along the row.
@ $BCB3 label=draw_pattern_column
c $BCB3 Draw a column of one pattern
D $BCB3 Draws one 8×8 pattern in every cell down a column of cells, as #R$BC70(the row draw) does along a row.
R $BCB3 I:B character row of the first cell
R $BCB3 I:C column of the first cell
R $BCB3 I:E number of cells (0 for 256)
R $BCB3 I:HL address of the pattern, one byte for each pixel row from the top
  $BCB3 Keep the attribute, the count and the pattern.
  $BCB9 Find the first cell's screen addresses, and keep its attribute address.
  $BCC0 Take back the pattern's address and the count.
  $BCC2 Count the cells down the column.
@ $BCC3 label=pat_col_cell
  $BCC3 Start the cell from the pattern's top byte.
@ $BCC8 label=pat_col_line
  $BCC8 Copy the pattern down the cell's pixel rows, over what was there.
  $BCD0 Step down to the next cell.
  $BCD7 Cross into the next screen third.
@ $BCDB label=pat_col_next
  $BCDB Draw the next cell.
  $BCDF Start at the first cell's attribute, with the draw attribute.
@ $BCE4 label=pat_col_attr
  $BCE4 Colour the cell, and step down to the next one.
  $BCEC Cross into the next third of the attributes.
@ $BCED label=pat_col_attr_next
  $BCED Colour the next cell.
  $BCF0 Find the first cell in the attribute mirror, and keep its address.
@ $BCF4 ssub=ADD A,(attr_mirror-$5800)/256
  $BCFA Does the pattern mark its cells?
  $BCFF Return if not
  $BD00 Take the count and the mark.
@ $BD02 label=pat_col_mark
  $BD02 Set the mark's bits in the cell's marks, and step down to the next cell.
  $BD0B Cross into the next page of the attribute mirror.
@ $BD0C label=pat_col_mark_next
  $BD0C,2 Mark the next cell.
u $BD0F Unused bytes
@ $BD11 label=graphic_attr_addr
g $BD11 Game variables
D $BD11 The graphic, pattern, character or layout record that the game draws, the control method, and the current screen with its launch cells.
W $BD11,2 Attribute address of the top-left cell of the latest graphic or pattern
@ $BD13 label=pattern_mirror_addr
W $BD13,2 Attribute mirror address of the first cell of the latest pattern row or column
@ $BD15 label=draw_attr
B $BD15,1 Attribute of the current graphic, pattern, character or hostile object, or $80 for a graphic that keeps the colours of its cells
@ $BD16 label=plot_width
B $BD16,1 Width in cells of the current graphic
@ $BD17 label=layout_column
B $BD17,1 Column of the current layout graphic, 0–31
@ $BD18 label=layout_flags
B $BD18,1 Flags of the current layout record, 0–7, with 4–7 for a run to the next record's cell
@ $BD19 label=layout_row
B $BD19,1 Character row of the current layout graphic, 6–23
@ $BD1A label=graphic_width
B $BD1A,1 Width in cells of the latest graphic drawn
@ $BD1B label=graphic_height
B $BD1B,1 Height in cells of the latest graphic drawn
@ $BD1C label=run_cells_left
B $BD1C,1 Distance in cells from the current layout graphic to the end of its run
@ $BD1D label=prev_layout_cell
B $BD1D,2 Column, then row, of the layout graphic before the current one
@ $BD1F label=prev_layout_graphic
B $BD1F,1 Number of the layout graphic before the current one
@ $BD20 label=layout_graphic
B $BD20,1 Number of the current layout graphic
@ $BD21 label=graphic_pixel_addr
W $BD21,2 Screen address of the top pixel row of the latest graphic's top-left cell
@ $BD23 label=mirror_mark
B $BD23,1 Attribute mirror mark of the current graphic or pattern: 0 for none, 1 for a bright graphic's cell masks, 2 for a bar
@ $BD24 label=control_method
B $BD24,1 Control method: 0 for the keyboard, 1 for a Kempston joystick, 2 for a Sinclair joystick, 3 for a cursor joystick
@ $BD25 label=screen_column
B $BD25,1 Column of the current screen on the hull map, 0–9 from left to right
@ $BD26 label=screen_row
B $BD26,1 Row of the current screen on the hull map, 0–10 from top to bottom
@ $BD27 label=screen_number
B $BD27,1 Number of the current screen, 0–109, ten times its row on the hull map plus its column
@ $BD28 label=launch_cells
B $BD28,8,2 Four launch cells for hostile objects, each a column byte that also holds the start direction, then a row byte
@ $BD30 label=launch_cell_ptr
W $BD30,2 Address of the next free launch cell
@ $BD32 label=colour_pattern
B $BD32,1 Twice the number of the latest graphic's colour pattern in #R$B12F(the colour pattern addresses), 0 for a graphic in one colour
@ $BD33 label=launch_cell_count
B $BD33,1 Number of launch cells on the current screen, 0–3
@ $BD34 label=skip_shadow
B $BD34,1 0 if each graphic casts its own shadow, any other value if it casts none
@ $BD35 label=run_length
B $BD35,1 Length in cells of the current layout run
u $BD36 Unused bytes
@ $BD3C label=shields
g $BD3C Game state
D $BD3C The shields, the end of the game, the Skimmer's place in the hull, and the defence devices.
B $BD3C,1 Number of shields the Skimmer has left, 0–3
@ $BD3D label=game_over
B $BD3D,1 0 while a game runs, 1 once it has ended
@ $BD3E label=inside_hull
B $BD3E,1 1 while the Skimmer is in an inner section of the hull, 0 while it is on the outer hull
@ $BD3F label=sector
B $BD3F,1 Sector of the hull that the Skimmer is in, 1–3
@ $BD40 label=device_destroyed_1
B $BD40,1 0 if the defence device of sector 1 stands, $FF if it is destroyed
@ $BD41 label=device_destroyed_2
B $BD41,1 0 if the defence device of sector 2 stands, $FF if it is destroyed
@ $BD42 label=device_destroyed_3
B $BD42,1 0 if the defence device of sector 3 stands, $FF if it is destroyed
@ $BD43 label=hull_one_band
B $BD43,1 1 to draw one band of pixel rows, 0 to repeat the band down to the bottom of the screen
@ $BD44 label=handle_fire
c $BD44 Handle the fire key
D $BD44 Fires a pulse laser shot along the one direction held with fire, or starts the hatchway animation on fire alone over a hatch. Each call then moves the shots.
  $BD44 Is a pulse laser shot in flight?
  $BD49 If so, only move the shots
  $BD4C Is fire held?
  $BD51 If not, only move the shots
N $BD54 Each direction has its own test. The Skimmer must sit half a cell off the grid along the line of fire, and the line must leave room for a shot.
N $BD54 #TABLE(default) { =h Direction | =h The Skimmer needs | =h First cell of the shot | =h The shot reaches } { Left | a column to its left | left of its second cell row | the screen's left edge } { Right | two columns to its right | right of its second cell row | the screen's right edge } { Up | a play area row above it | above its second column | the play area's top } { Down | a row below it | below its second column | the screen's bottom } TABLE#
  $BD54 Start with no direction to fire, and keep the directions held.
  $BD59 Is left the one direction held?
  $BD5B If not, test right
  $BD5D Is the Skimmer's horizontal offset half a cell?
  $BD62 If not, test right
  $BD64 Is there a column to its left?
  $BD69 If not, test right
  $BD6B Fire left from beside the Skimmer's second cell row, as far as the screen's left edge.
@ $BD72 label=fire_test_right
  $BD72 Is right the one direction held?
  $BD75 If not, test up
  $BD77 Is the Skimmer's horizontal offset half a cell?
  $BD7C If not, test up
  $BD7E Are there two columns or more to its right?
  $BD83 If not, test up
  $BD85 Fire right from beside the Skimmer's second cell row, as far as the screen's right edge.
@ $BD91 label=fire_test_up
  $BD91 Is up the one direction held?
  $BD94 If not, test down
@ $BD96 ssub=LD A,($D2B0+1)
  $BD96 Does the Skimmer's top pixel row lie half a cell down its cell row?
  $BD9D If not, test down
  $BD9F Is there a play area row above it?
  $BDA4 If not, test down
  $BDA6 Fire up from above the Skimmer's second column, as far as the play area's top.
@ $BDB0 label=fire_test_down
  $BDB0 Is down the one direction held?
  $BDB3 If not, fire nothing
@ $BDB5 ssub=LD A,($D2B0+1)
  $BDB5 Does the Skimmer's top pixel row lie half a cell down its cell row?
  $BDBC If not, fire nothing
  $BDBE Is there a row below it?
  $BDC3 If not, fire nothing
  $BDC5 Fire down from below the Skimmer's second column, as far as the screen's bottom.
@ $BDD1 label=fire_if_aimed
  $BDD1 Did a test pass?
  $BDD4 Jump if not
  $BDD6 Fire the shot, and move the shots.
@ $BDDC label=try_hatchway
  $BDDC Does the Skimmer's top-left cell lie one column inside the hatchway's?
  $BDE4 If not, only move the shots
  $BDE7 Does it lie one row inside too? It never does on a screen with no hatchway.
  $BDED If not, only move the shots
  $BDF0 Does the Skimmer rest square on the cell, with no direction held?
  $BDF5 If not, only move the shots
  $BDF8 Is the hatchway animation under way?
  $BDFC If so, only move the shots
  $BDFF Is the Skimmer on the outer hull? Take the first step as the hatch opens under it, and jump if so
  $BE08 Take the step that starts the trip out of an inner section instead.
@ $BE0A label=start_hatchway
  $BE0A Start the animation, with its pass count set so that its first step runs on the next call. Then move the shots.
@ $BE11 label=fire_laser_shot
c $BE11 Fire a pulse laser shot
D $BE11 Launches the pulse laser shot from the cell beside the Skimmer, unless that cell stops it. A hostile object there takes the hit at once, and no shot appears.
R $BE11 I:A direction of the shot, 0–3 for left, right, up or down
R $BE11 I:DE step in the attribute mirror from the Skimmer's top-left cell to the shot's first cell
  $BE11 Find the attribute mirror address of the shot's first cell, and keep the direction.
  $BE16 Does the cell stop the shot?
  $BE19 Return if so
  $BE1A Point at the pulse laser shot's record, and take the direction back.
@ $BE1E label=launch_shot
c $BE1E Launch a shot
D $BE1E Launches a shot from a cell, and draws it there.
N $BE1E The clip plays the launch of a hostile objects' shot.
N $BE1E #HTML(#PUSHS #SIM($BAEB,$BAC6,1)#SIM($CF92,$BB17)#SIM($C906,execint=1)#SIM($CF95,execint=1)#AUDIO1,$CF95,$D11D,1(shot.wav)#POPS)
R $BE1E I:A direction of the shot, 0–3 for the pulse laser shot or 4–7 for the hostile objects' shot, each for left, right, up or down
R $BE1E I:DE address of the shot's record, #R$C928 or #R$C936
R $BE1E I:HL attribute mirror address of the shot's first cell
  $BE1E Store the direction, marked so that the shot holds its first cell until its next move.
  $BE22 Start the shot's clicks: the Skimmer draw clicks the speaker on every pixel row for two passes.
  $BE2C Store the range and the first cell, and point at the store for the saved colour.
  $BE38 Draw the shot in its first cell. Does the cell stop it?
  $BE3E Return if not
N $BE3F BUG: the stop lands on the shot's range, one byte after its direction. So a shot that the draw stops would stay in flight, with a range of 255. The defect has no effect. Each launch checks the cell just before. It goes on to a cell that stops a shot only after an upward push, which neither launch gives.
  $BE3F,4 Store the stop in the shot's record.
@ $BE44 label=move_shots
c $BE44 Move the shots
D $BE44 Moves the pulse laser shot and the hostile objects' shot one cell each.
  $BE44 Move the pulse laser shot, then go on to the hostile objects' shot.
@ $BE4D label=move_one_shot
c $BE4D Move a shot
D $BE4D Moves one shot a cell along its direction. It ends the shot when its range runs out or its cell stops it.
R $BE4D I:DE address of the shot's record, #R$C928 or #R$C936
  $BE4D Is the shot in flight?
  $BE50 Return if not
  $BE51 Does it carry the launch mark? If not, move it
  $BE54,3 Clear the launch mark. The shot holds its first cell until the next call.
@ $BE58 label=shot_step
  $BE58 Note which shot moves, and take its direction.
  $BE5E Count down its range.
  $BE65 Take its cell, and point at what the shot covers there.
  $BE6C Put back what the shot covered.
  $BE6F Never jumps, since the erase always sets the zero flag.
  $BE71 Move the shot on to the next cell along its direction.
  $BE75 Is its range used up?
  $BE7A End the shot if so
  $BE7C Draw the shot in its new cell. Does the cell stop it?
  $BE82 End the shot if so
  $BE84,7 Keep the shot's new cell.
@ $BE8C label=end_shot
  $BE8C,7 End the shot.
@ $BE94 label=step_cell
c $BE94 Step one cell in a direction
D $BE94 Moves a cell's attribute mirror address one cell left, right, up or down, with no test for the screen's edges.
R $BE94 I:A direction of the step in its low two bits, 0–3 for left, right, up or down
R $BE94 I:HL attribute mirror address of the cell
R $BE94 O:HL attribute mirror address of the next cell that way
  $BE94 Is the step to the left? Jump if so
  $BE9A Is it to the right? Jump if so
  $BE9E Is it up? Jump if so
  $BEA2,4 Is it down? Jump if so
@ $BEA7 label=step_left
  $BEA7,1 Step one cell left.
@ $BEA9 label=step_right
  $BEA9,1 Step one cell right.
@ $BEAB label=step_up
  $BEAB,6 Step one cell row up.
@ $BEB2 label=step_down
  $BEB2,6 Step one cell row down.
@ $BEB9 label=erase_shot
c $BEB9 Erase a shot
D $BEB9 Puts back the colour and the pixels of the cell that a shot covered, and takes the shot's mark out of the attribute mirror.
R $BEB9 I:DE address of the saved colour and pixel rows
R $BEB9 I:HL attribute mirror address of the shot's cell
R $BEB9 O:F zero flag always set
  $BEB9 Did the shot cross this cell hidden?
  $BEBE Return if so: it left the cell as it was
  $BEBF Put back the cell's colour.
@ $BEC2 ssub=SUB (attr_mirror-$5800)/256
  $BEC7 Find the cell's top pixel row, and count its pixel rows.
@ $BED2 label=erase_shot_row
  $BED2 Put back the pixel rows, from the top.
  $BED8,7 Take the shot's mark out of the cell, and report the cell erased.
@ $BEE0 label=push_skimmer_from_shot
c $BEE0 Push the Skimmer when a shot strikes it
D $BEE0 Pushes the Skimmer the way a shot travels, for 20 passes of the play loop.
R $BEE0 I:C direction of the shot in its low two bits
R $BEE0 O:F zero flag set only for an upward push while D is 0
  $BEE0 Time the push.
  $BEE5 Turn the shot's direction into the push's order, and push the Skimmer that way.
N $BEED BUG: this reports a stop because #REGd is not 0 while #REGde points at a shot's record. At a shot's first cell, #REGde holds the step to that cell instead. Its high byte is 0 for a step left, right or down, so an upward push reports the cell as free. That push also leaves #REGhl at #R$D2C3(the Skimmer's vertical speed).
  $BEED,1 Report a stop.
@ $BEEF label=score_shot_hit
c $BEEF Score a shot's hit
D $BEEF Marks the cell that a shot strikes as a hit, counts it among the hits that wait for their hostile object, and adds 20 points.
R $BEEF I:HL attribute mirror address of the struck cell
R $BEEF O:F zero flag clear
  $BEEF Mark the cell as a hit.
  $BEF3 Count the hit.
  $BEFA Add 20 points.
  $BF02,1 Report a stop: the hit count is never 0 here.
@ $BF04 label=check_shot_cell
c $BF04 Check the cell a shot enters
D $BF04 Reports whether a shot can enter a cell. A shot that strikes the Skimmer pushes it, and one that strikes a hostile object scores a hit.
N $BF04 The marks in the cell decide. #TABLE(default) { =h Marks | =h Result } { None, or only marks that let a shot through | The shot enters } { The Skimmer's, without a hostile object's | The Skimmer gets a push, and the shot stops } { A hostile object's, without the Skimmer's | The cell becomes a hit, and the shot stops } { Any others | The shot stops } TABLE#
R $BF04 I:C direction of the shot, which a push follows
R $BF04 I:HL attribute mirror address of the cell
R $BF04 O:F zero flag set if the shot can enter the cell
  $BF04 Leave out the marks that never stop a shot. Are there no others?
  $BF07 Return if so: the shot enters
  $BF08 Is the bright graphic or bar mark the only one?
  $BF0A Return if so: the shot enters
  $BF0B Does the cell hold the Skimmer, and no hostile object?
  $BF0F Push the Skimmer if so
  $BF11 Does it hold a hostile object, and not the Skimmer?
  $BF13,2 Score a hit if so
@ $BF16 label=report_shot_stopped
c $BF16 Report a stopped shot
R $BF16 O:A $FF, for a cell that stops the shot
  $BF16,2 The cell stops the shot.
@ $BF19 label=draw_shot
c $BF19 Draw a shot
D $BF19 Draws a shot in a cell and saves what it covers, or reports that the cell stops the shot. A cell with the bright graphic or bar mark hides the shot.
R $BF19 I:A direction of the shot, 0–3 for the pulse laser shot or 4–7 for the hostile objects' shot
R $BF19 I:C direction of the shot, which a push follows
R $BF19 I:DE address in the shot's record for the saved colour and pixel rows
R $BF19 I:HL attribute mirror address of the cell
R $BF19 O:A $FF if the cell stops the shot, 0 if not
  $BF19 Is it the pulse laser shot? Take bright red ink on black paper, and jump if so
  $BF1F Take bright yellow ink on black paper for the hostile objects' shot.
@ $BF21 label=draw_shot_check
  $BF21 Keep the direction. Does the cell stop the shot?
  $BF25 Report the stop if so
  $BF27 Does the shot cross this cell hidden, under the bright graphic or bar mark?
  $BF2E Return if so, with nothing drawn
  $BF2F Give the cell the shot's mark.
  $BF35 Save the cell's colour, and paint the cell in the shot's colour.
@ $BF36 ssub=SUB (attr_mirror-$5800)/256
  $BF3D Find the cell's top pixel row, keep it, and count its pixel rows.
@ $BF49 label=draw_shot_save
  $BF49 Save the pixel rows, from the top.
  $BF4F Point at #R$9DC8(the shot's graphic) for its direction, 8 bytes each.
@ $BF55 ssub=ADD A,shot_graphics%$100
@ $BF58 ssub=LD D,shot_graphics/$100
  $BF5C Carry into the high byte.
@ $BF5D label=draw_shot_graphic
  $BF5D Go back to the cell's top pixel row, and count its pixel rows.
@ $BF60 label=draw_shot_row
  $BF60 Draw the graphic down the cell.
  $BF66,3 Report the shot drawn.
@ $BF6A label=find_hatch_graphic
c $BF6A Find the halves of the hatch for an animation step
D $BF6A Finds the parts of the hatch's bitmap that a step of the hatchway animation shows. The hatch parts in the middle, and each step slides each half one pixel row further out.
N $BF6A The routine takes the upper half as the bitmap's rows 0–12, and the lower half as rows 11–23. So the two middle rows belong to both halves.
R $BF6A I:A step of the animation in its low four bits, from 0 for the shut hatch to 13 for the open hatch
R $BF6A O:B pixel rows that each half shows
R $BF6A O:C bytes in each pixel row of the hatch
R $BF6A O:DE address of the upper half's first byte
R $BF6A O:HL address of the lower half's last byte
  $BF6A Count the rows that each half still shows: all of them when the hatch is shut, none when it is open.
  $BF71 Point at the upper half's first row that shows, 3 bytes per row down from the bitmap's top.
@ $BF75 ssub=ADD A,hatch_bitmap%$100
@ $BF78 ssub=LD D,hatch_bitmap/$100
  $BF7C Carry into the high byte.
@ $BF7D label=hatch_lower_end
  $BF7D Point at the lower half's last byte that shows: the bitmap's last byte, less 3 bytes per row that the half no longer shows.
@ $BF80 ssub=ADD A,hatch_bitmap%$100
@ $BF83 ssub=LD H,hatch_bitmap/$100
  $BF87 Carry into the high byte.
@ $BF88 label=hatch_row_bytes
  $BF88,2 Take the hatch's width.
@ $BF8B label=animate_hatchway
c $BF8B Step the hatchway animation
D $BF8B Runs a step of the hatchway animation on every fourth call, and hands back the step to run next. The hatch opens under the Skimmer and closes over it on the way into an inner section, and the reverse on the way out.
R $BF8B I:A step of the hatchway animation
R $BF8B O:A step to run next, or 0 when the animation ends
  $BF8B Count down the pass count. Is this the fourth pass?
  $BF96 If not, return the step as it is
  $BF97 Keep the step. Is the hatch over the Skimmer? Jump if so
N $BF9D The hatch lies under the Skimmer, in the Skimmer's background store.
  $BF9D Does the hatch close in this phase? Jump if not
  $BFA1 Turn the step round, so that the halves come back together.
@ $BFA7 label=under_halves
  $BFA7 Find the halves of the hatch, keep the lower half's end, and start at the store's top row.
  $BFAE Does the upper half show any rows? Jump if not
  $BFB3 Copy the upper half into the store's top rows.
@ $BFB4 label=under_upper_row
  $BFB4 Take the next row.
@ $BFB6 label=under_upper_byte
  $BFB6 Copy its bytes into the store row.
  $BFBC Skip the store row's fourth byte, and copy the next row.
  $BFC0 Is the hatch shut? If so, leave out the blank row
@ $BFC6 label=under_upper_blank
  $BFC6 Blank the store row below the upper half.
@ $BFC9 label=under_upper_clear
  $BFC9 Clear its bytes.
@ $BFCE label=under_lower
  $BFCE Take the lower half's end, and start at the last byte of the store's bottom row. Does the lower half show any rows? Jump if not
@ $BFCF ssub=LD HL,skimmer_bg_store+$5E
  $BFD7 Copy the lower half into the store's bottom rows, from the end back.
@ $BFD8 label=under_lower_row
  $BFD8 Take the next row up.
@ $BFDA label=under_lower_byte
  $BFDA Copy its bytes from right to left.
  $BFE0 Skip the fourth byte of the store row above, and copy the next row.
  $BFE4 Is the hatch shut? If so, leave out the blank row
@ $BFEB label=under_lower_blank
  $BFEB Blank the store row above the lower half.
@ $BFED label=under_lower_clear
  $BFED Clear its bytes, from right to left.
@ $BFF1 label=under_show
  $BFF1 Draw the Skimmer over the store, with the hatch behind it. Then take the next step.
@ $BFF7 label=hatch_over
N $BFF7 The hatch lies over the Skimmer. The game draws the Skimmer first, and then the hatch on the screen over it.
  $BFF7 Draw the Skimmer, and take the step again.
  $BFFC Does the hatch close in this phase? Jump if not
  $C000 Turn the step round as well.
@ $C006 label=over_halves
  $C006 Find the halves of the hatch, keep the lower half's end, and start at the Skimmer's top-left screen byte.
  $C00D Does the upper half show any rows? Jump if not
  $C012 Copy the upper half down from the Skimmer's top pixel row.
@ $C013 label=over_upper_row
  $C013 Take the next row.
@ $C016 label=over_upper_byte
  $C016 Copy its bytes onto the screen.
  $C01C Move down a pixel row. Is it in the same cell row? Jump if so
  $C023 Move down a cell row. Is it in the next third of the screen? Jump if so
  $C029 Stay in this third.
@ $C02D label=over_upper_next
  $C02D Copy the next row.
  $C030 Is the hatch shut? If so, leave out the blank row
@ $C036 label=over_upper_blank
  $C036 Blank the pixel row below the upper half.
@ $C039 label=over_upper_clear
  $C039 Clear its bytes.
@ $C03E label=over_lower
  $C03E Take the lower half's end. Find the Skimmer's bottom right screen byte, two cell rows down and two bytes right. Is it in the same third? Jump if so
  $C049 Move into the next third.
@ $C04B label=over_lower_last
  $C04B Take the cell row's last pixel row.
  $C04E Does the lower half show any rows? Jump if not
  $C053 Copy the lower half up from the Skimmer's bottom pixel row.
@ $C054 label=over_lower_row
  $C054 Take the next row up.
@ $C057 label=over_lower_byte
  $C057 Copy its bytes onto the screen, from right to left.
  $C05D Move up a pixel row. Is it in the same cell row? Jump if so
  $C066 Move up a cell row. Is it in the third above? Jump if so
  $C06C Stay in this third.
@ $C070 label=over_lower_next
  $C070 Copy the next row up.
  $C073 Is the hatch shut? If so, leave out the blank row
@ $C079 label=over_lower_blank
  $C079 Blank the pixel row above the lower half.
@ $C07B label=over_lower_clear
  $C07B Clear its bytes, from right to left.
@ $C07F label=next_hatch_step
N $C07F Each phase ends after its thirteenth step, and hands on to the next. #TABLE(default) { =h Phase | =h Next phase } { The hatch opens under the Skimmer | It closes over the Skimmer } { It closes over the Skimmer | It opens over the Skimmer } { It opens over the Skimmer | It closes under the Skimmer } { It closes under the Skimmer | None } TABLE#
  $C07F Take the step after this one. Is the hatch now open under the Skimmer?
  $C083 Jump if not
  $C085,2 Close the hatch over the Skimmer next.
@ $C088 label=test_close_under_end
  $C088 Is it now shut under the Skimmer? Jump if not
  $C08C,1 The animation is over.
@ $C08E label=test_open_over_end
  $C08E Is it now open over the Skimmer? Jump if not
  $C092,2 Close the hatch under the Skimmer next.
@ $C095 label=test_close_over_end
  $C095 Is it now shut over the Skimmer? If not, return the step
  $C098,2 Open the hatch over the Skimmer next.
@ $C09B label=random_below
c $C09B Random number below a limit
D $C09B Returns a random number below a limit: the remainder of the refresh register divided by the limit.
R $C09B I:A limit, 1–128
R $C09B O:A number from 0 to one less than the limit
  $C09B Take the refresh register as the random number. Divide it by the limit one bit at a time, from its top bit down.
@ $C0A2 label=random_bit
  $C0A2 Shift the next bit of the number into the remainder, and take the limit off it. Jump if the remainder held the limit
  $C0A8 If not, put the limit back.
@ $C0A9 label=random_next_bit
  $C0A9,2 Do the next bit while one is left.
@ $C0AC label=hostile_image_bufs
b $C0AC Image buffers of the hostile objects
D $C0AC The address of each hostile object's image buffer, one for each slot at #R$F800(the hostile object slots). The two slots that move on even counts of #R$C958(the tick) come first.
N $C0AC A buffer holds the four images of the object's design, then the four masks, 48 bytes each. Each copy sits 2 pixels further right than the one before it. #R$C227 fills them.
N $C0AC The buffers lie over the printer buffer and the system variables, which the game never needs. Its interrupts run through its own vectors. Its one ROM call, KEY-SCAN in the title tune, reads only the keyboard.
W $C0AC,8,2
@ $C0B4 label=move_hostile_objects
c $C0B4 Move the hostile objects
D $C0B4 Moves the hostile objects of one pair of slots, and those of the other pair on the next call. After the hold that starts each screen, it can also launch a new hostile object.
  $C0B4 Make the draw of the Skimmer step its cover map three cells per row, the width of a hostile object.
@ $C0B5 ssub=LD ($CC32),A
  $C0B8 Start the counts of the call's objects and removals at zero.
  $C0BE Count the call. Take the first pair of slots on an even count and the second pair on an odd count.
@ $C0CA label=move_hostile_slot
  $C0CA Make this slot the current one. Clear the record of a move or a turn, and let the object toggle the hostile object mark.
@ $C0D6 ssub=LD ($C80D+1),A
  $C0D9 Is the slot empty?
  $C0E0 Jump if so
  $C0E2 Copy the slot's record into the current hostile object, move the object and let it fire.
  $C0F4 Copy the record back into the slot.
@ $C104 label=next_hostile_slot
  $C104 Step to the next slot, and go back while the pair has one left.
  $C10F Does the hold after a new screen run?
  $C114 Jump if not
  $C116,4 Count it on. It lasts two calls, so each pair of slots gets one move of the hold.
@ $C11B label=try_launch
N $C11B A launch needs a call that removes no object. The pair must hold fewer objects of the screen than the screen has launch cells.
  $C11B Does the pair hold as many of the screen's objects as the screen has launch cells? Return if so.
  $C123 Did an object leave the game on this call? Return if so.
  $C129 Give the new object the hostile object mark, which an explosion changes.
@ $C12B ssub=LD ($C80D+1),A
  $C12E Look for an empty slot in the pair, from the first, and count the slots passed.
@ $C13E label=seek_empty_slot
  $C13E Is this slot empty?
  $C141 Jump if so
  $C143 Count the slot, and try the next one while the pair has one left.
  $C14E Both slots hold objects. Look for one whose object belongs to another screen, and count the slots passed.
@ $C15B label=seek_stale_slot
  $C15B Does this slot's object belong to the current screen?
  $C15F Jump if not
  $C161,11 Count the slot, and try the next one while the pair has one left.
N $C16C No slot is free.
@ $C16D label=stale_slot_found
  $C16D Step back from the object's screen number to the start of its slot.
@ $C172 label=empty_slot_found
  $C172 Step back from the slot's state byte to the start of the slot.
@ $C175 label=launch_in_slot
  $C175 Make it the current slot.
  $C179 Never returns: a screen with no launch cells has already ended the call.
  $C17F Pick one of the screen's launch cells at random.
@ $C183 ssub=ADD A,launch_cells%$100
@ $C186 ssub=LD H,launch_cells/$100
@ $C18B label=read_launch_cell
  $C18B Place the new object at the launch cell. The column byte's low five bits give the column, and the next byte the row.
  $C196 Take the start direction from the column byte. See #R$B67C(the store of a launch cell) for why it comes out up or left.
  $C19F Find the cell's screen address and its attribute mirror address. The object starts at the left edge of its column.
@ $C1A6 ssub=ADD A,(attr_mirror-$5800)/256
  $C1B1 Does something block a cell under it? Return if so, and launch nothing on this call. The blocked cell still takes its #R$C819(collision), so the Skimmer there gets a push, and a shot or a hit there scores 20 points.
  $C1B5 Its cover map starts the slot, and its background store follows it.
  $C1C2 Pick the slot's image buffer, by the page and the slot within it.
@ $C1CD ssub=ADD A,hostile_image_bufs%$100
@ $C1D0 ssub=LD H,hostile_image_bufs/$100
@ $C1D5 label=read_image_buf
  $C1D5 Keep the buffer's address.
  $C1DC Pick a hostile object design at random.
  $C1E1,23 Find the design, 64 bytes per design: a 16×16 image, then its mask.
@ $C1F1 ssub=ADD A,hostile_designs%$100
@ $C1F5 ssub=ADC A,hostile_designs/$100
  $C1FB It first steers toward the Skimmer on its fifth whole cell on the play area.
  $C200 Point at the new object's slot.
@ $C204 label=add_hostile
c $C204 Add the current hostile object to a slot
D $C204 Adds the current hostile object to a slot, as an object of the current screen. It draws nothing, so the object first shows at its next move.
R $C204 I:DE address of the slot
  $C204 Tie the object to the current screen, and copy its record into the slot.
@ $C216 label=place_hostile
  $C216,16 Save the background behind the object, note the cells that hide it, and give its cells the hostile object mark.
@ $C227 label=preshift_hostile
c $C227 Build a hostile object's shifted images
D $C227 Builds the four images and four masks of a hostile object design in an image buffer. Each copy sits 2 pixels further right than the one before.
N $C227 A design holds 16 pixel rows of its image, 2 bytes per row, then 16 rows of its mask. A mask bit of 1 lets the background show. Each copy in the buffer takes 3 bytes per pixel row.
R $C227 I:DE address of the design
R $C227 I:HL address of the image buffer
  $C227 Start at the first image in the buffer, with the design's first image row.
@ $C22D label=preshift_hostile_image
  $C22D Write each image row four ways, blank around the design.
  $C23C Move the build position past the four images to the first mask, and take the design's mask rows.
@ $C244 ssub=LD A,($C95F+1)
@ $C249 ssub=LD ($C95F+1),A
@ $C24E label=preshift_hostile_mask
  $C24E,15 Write each mask row four ways, open to the background around the design.
@ $C25E label=shift_image_row
c $C25E Shift one design row four ways
D $C25E Writes one row of a design into the four images or the four masks at the build position, each copy shifted 2 pixels further right. It moves the build position on to the next row.
R $C25E I:C left byte of the design row
R $C25E I:D right byte of the design row
R $C25E I:E 0 for an image row, $FF for a mask row
  $C25E Take the build position. The fill byte's low bit fills the pixels that each shift opens on the left, so keep it aside.
@ $C269 label=shift_image_row_copy
  $C269 Write the copy's three bytes, and step to the same row of the next copy.
@ $C275 label=shift_image_row_bits
  $C275 Shift the row 2 pixels right, and let the fill bit in on the left. The last shift goes unused.
  $C285,7 Move the build position to the next row.
@ $C28D label=draw_hostile
c $C28D Draw a hostile object
D $C28D Draws the current hostile object's image for its horizontal offset, through its mask, over its saved background. It leaves out the cells that hide it (#R$C76A).
  $C28D Find the image's distance from the first image, by the horizontal offset.
@ $C299 label=draw_hostile_offset
  $C299 Add it to the address of the object's images.
@ $C2A2 label=draw_hostile_mask
  $C2A2 Keep the image's address. Its mask lies four images further on.
@ $C2A9 label=draw_hostile_mask_ok
  $C2A9 Is it the defence device?
  $C2AF Jump if not
  $C2B1 The device draws through the first explosion mask, solid across its two columns.
@ $C2B4 label=draw_hostile_args
  $C2B4 Hand the draw the background store, the mask and the cover map in the other register set. Each byte it writes is the background through the mask, with the image over it.
@ $C2BD label=plot_hostile_image
N $C2BD This entry point draws an image at the object's screen address. The caller holds the image in #REGhl, and the background store, the mask and the cover map in the other register set.
  $C2BD Draw the object's 16 pixel rows through the draw loop of the Skimmer.
@ $C2C7 label=save_hostile_bg
c $C2C7 Save the background behind a hostile object
D $C2C7 Copies the screen under a hostile object into its background store.
R $C2C7 I:DE address of the background store
R $C2C7 I:HL screen address of the object's top-left byte
  $C2C7 Take each column in turn.
@ $C2C9 label=save_hostile_bg_col
  $C2C9,16 Copy the column down the object's 16 pixel rows into every third byte of the store. Then step one column right.
u $C2DA Unused bytes
@ $C2DB label=update_hostile
c $C2DB Update a hostile object
D $C2DB Runs one move of the current hostile object if it belongs to the current screen. A hit makes it explode, and otherwise it steers toward the Skimmer.
  $C2DB Does its explosion run?
  $C2E0 Jump if so
  $C2E3 Does it belong to another screen? Return if so, and leave it as it is.
  $C2EB Count it among the objects of the screen.
  $C2EF Does any hit cell wait?
  $C2F4 Jump if not
  $C2F6 Find the object's cells on the play area. Jump if it has none there.
@ $C2FD label=scan_hit_row
  $C2FD Take the next row of its cells.
@ $C300 label=scan_hit_cell
  $C300 Is this cell hit?
  $C305 Jump if not
  $C307 Clear the hit from the cell but keep the hostile object mark, and count the cell.
@ $C30E label=scan_hit_next
  $C30E Step along the row.
  $C311 Step down to the next row of cells.
@ $C31A label=scan_hit_down
  $C31A Scan the next row while one is left.
  $C31C Is any of its cells hit?
  $C31F Jump if not
  $C321 Take its cells off the count of hits, and make it explode.
@ $C330 label=update_hostile_hold
  $C330 Does the hold after a new screen run?
  $C335 Jump if not
N $C337 The hold. The object belongs to the screen the Skimmer has come back to. It shows again where it was, unless the new screen blocks it.
  $C337 Is it the defence device? Return if so: the device first draws after the hold.
  $C33D Does something block a cell under it? Jump if so, and let it vanish.
  $C343 Put it back in place, and draw it.
@ $C349 label=update_hostile_steer
  $C349 Is it the defence device?
  $C34E Jump if so: the device sits where it is and only draws again.
N $C351 The object steers only on a whole cell, wholly on the play area, and only once its count of cells runs out.
  $C351 Does it lie between two cells?
@ $C354 ssub=LD A,($C947+1)
  $C35A Jump if so
  $C35D Does it lie partly off the left or the right of the screen?
  $C362 Jump if so
  $C365 Does it lie partly above the play area?
  $C36A Jump if so
  $C36D Does it lie partly below the play area?
  $C36F Jump if so
  $C372 Count down the cells to its next turn. Jump unless the count runs out.
N $C37C It steers. It heads the way in which the Skimmer lies furthest, for as many cells as that distance.
  $C37C Store the distances in cells from the object to the Skimmer up, down, left and right, in the first four bytes of the attribute mirror. A distance the wrong way is negative.
  $C399 Look for the longest distance, from none.
@ $C39D label=steer_pick_axis
  $C39D Is the distance negative?
  $C3A0 Jump if so
  $C3A3 Is it shorter than the longest so far?
  $C3A4 Jump if so: a tie goes to the later direction.
  $C3A6 Keep it as the longest, with its direction.
@ $C3A8 label=steer_next_axis
  $C3A8 Try the next direction.
  $C3AB Head that way, and count that distance in cells to the next turn.
@ $C3B7 label=remove_hostile
c $C3B7 Remove a hostile object
D $C3B7 Takes the current hostile object off the screen and empties its slot.
  $C3B7 Take its mark off its cells, and count it as removed.
  $C3BE Empty its slot.
  $C3CB Put back the background behind it, one column at a time. Leave out the cells that hide it.
@ $C3DB label=remove_hostile_col
  $C3DB,25 Restore the column down the object's 16 pixel rows. Then step one column right on the screen, in the store and in the cover map.
@ $C3F5 label=advance_hostile
c $C3F5 Advance a hostile object
D $C3F5 Moves the current hostile object 2 pixels in its direction, and draws it there. A blocked object turns back or explodes, and one that has passed off the play area leaves the game.
  $C3F5 Lift its mark off its cells while it moves.
  $C3F8 Does it head left?
  $C3FD Jump if not
  $C3FF Step it left.
@ $C404 label=advance_hostile_right
  $C404 Does it head right?
  $C406 Jump if not
  $C408 Step it right.
@ $C40D label=advance_hostile_up
  $C40D Does it head up?
  $C40F Jump if not
  $C411 Step it up.
@ $C416 label=advance_hostile_down
  $C416 Does it head down?
  $C418 Jump if not
  $C41A Step it down.
@ $C41D label=advance_hostile_done
  $C41D Put its mark back on its cells.
  $C420 Did it turn back?
  $C425 Jump if not
  $C427 Did it strike a shot, a hit or the Skimmer?
  $C42C,2 Jump if so, to start its explosion
@ $C42F label=advance_hostile_moved
  $C42F Did it move?
  $C434 Jump if not: it lies wholly off the play area and leaves the game.
@ $C437 label=redraw_hostile
  $C437,6 Note the cells that hide it, and draw it.
@ $C43E label=finish_explosion
c $C43E End a hostile object's explosion
D $C43E Paints the current hostile object's cells white on black and removes the hostile object.
N $C43E The paint also reaches #R$CE4B(the black strip) of a screen in the hull map's left column. On the outer hull it shows the hull surface there until the next screen draw.
  $C43E Paint its cells white ink on black paper.
  $C443 Take the explosion mark off its cells as the object goes.
@ $C445 ssub=LD ($C80D+1),A
@ $C44B label=explode_hostile
c $C44B Animate a hostile object's explosion
D $C44B Starts the current hostile object's explosion or shows its next frame. An explosion inside the hull destroys the sector's defence device.
N $C44B The clip plays one explosion to its end.
N $C44B #HTML(#PUSHS #SIM($BAEB,$BAC6,1)#SIM($CF92,$BB17)#SIM($C437,execint=1)#SIM($CF95,execint=1)#POKES$F940,$FF#AUDIO1,$CF95,$C448,1(explosion.wav)#POPS)
R $C44B I:A state of the hostile object, $E0 or more to start the explosion
  $C44B Keep the state. Does the hold after a new screen run? Jump if so, and let the object vanish.
  $C453 Count it among the objects of the screen.
  $C457 Does its explosion start now?
  $C45A Jump if not
N $C45C The explosion starts.
  $C45C Swap its hostile object mark for the explosion mark.
@ $C45E ssub=LD ($C80D+1),A
  $C464 Is the Skimmer inside the hull?
  $C469 Jump if not
  $C46B Inside the hull the only hostile object is the defence device. Mark it destroyed.
@ $C470 label=explode_hostile_first
  $C470 Start from the first frame.
@ $C472 label=explode_hostile_frame
  $C472 Step to the next frame. Has the last one shown?
  $C475 Jump if so
  $C478 Keep the frame. The draw clicks the speaker on fewer pixel rows of each cell at each later frame.
@ $C47D ssub=LD ($CC0A+1),A
  $C480 Paint its cells bright yellow ink on black paper, and draw the frame.
  $C488,5 Stop the clicks of the draw.
@ $C48A ssub=LD ($CC0A+1),A
@ $C48E label=vanish_hostile
  $C48E,5 Empty its slot, and leave the screen as it is.
@ $C494 label=colour_hostile_cells
c $C494 Colour a hostile object's cells
D $C494 Paints the current hostile object's cells on the play area in an attribute, and clicks the speaker once for each row of cells. It leaves out the cells that hide the object.
R $C494 I:A attribute to paint the cells
  $C494 Keep the attribute. Find the object's cells on the play area, and return if it has none there.
  $C49B Hold the attribute aside, and turn the attribute mirror address into the attribute address.
@ $C4A0 ssub=SUB (attr_mirror-$5800)/256
@ $C4A3 label=colour_hostile_row
  $C4A3 Take the next row of its cells.
@ $C4A7 label=colour_hostile_cell
  $C4A7 Does this cell hide the object?
  $C4A9 Jump if so
  $C4AB Paint the cell.
@ $C4AE label=colour_hostile_next
  $C4AE Step along the row.
  $C4B2 Click the speaker.
  $C4BB Step down to the next row of cells and of the cover map.
@ $C4C7 label=colour_hostile_down
  $C4C7,3 Colour the next row while one is left.
@ $C4CB label=image_offsets
b $C4CB Image offsets
D $C4CB The distance of each image from the start of a hostile object's shifted images or of the explosion frames. There are eight, one word each, in steps of 48 bytes, the size of one image.
W $C4CB,16,2
@ $C4DB label=add_image_offset
c $C4DB Add an image offset
D $C4DB Turns the address of the first image of a set into the address of one of its images.
R $C4DB I:A number of the image, 0–7
R $C4DB I:HL address of the first image
R $C4DB O:HL address of the image
  $C4DB Keep the first image's address, and point at the image's word in #R$C4CB(the image offsets), 2 bytes per image.
@ $C4DD ssub=ADD A,image_offsets%$100
@ $C4E0 ssub=LD H,image_offsets/$100
  $C4E4 Never runs: the image offsets do not cross a page.
@ $C4E5 label=add_image_offset_get
  $C4E5,12 Add the image's distance to the first image's address.
@ $C4F2 label=draw_explosion
c $C4F2 Draw a hostile object's explosion frame
D $C4F2 Draws the current explosion frame at the hostile object's position, after it shifts the frame to the hostile object's horizontal offset when they differ.
  $C4F2 Take the explosion frame from the object's state, 0 for the first.
  $C4F8 Find the frame's image among the explosion frames.
@ $C500 ssub=ADD A,explosion_offsets%$100
  $C500 Point at the horizontal offset that #R$A018 records for the frame's image.
@ $C503 ssub=LD H,explosion_offsets/$100
  $C507 Never runs: those bytes do not cross a page.
@ $C508 label=draw_explosion_shift
  $C508 Does the frame sit at another horizontal offset than the object's? If so, shift it to the object's.
  $C50F Keep the frame's image for the draw.
  $C511 Find the explosion mask for the object's horizontal offset, one of the four explosion masks.
  $C51B,8 Draw the frame through the mask over the object's background store, except in the cells its cover map hides.
@ $C526 label=shift_explosion
c $C526 Shift an explosion frame
D $C526 Shifts one explosion frame in place to the current hostile object's horizontal offset and records that offset.
R $C526 I:A horizontal offset to shift the frame to, 0–3
R $C526 I:DE address of the frame's image
R $C526 I:HL address of the frame's recorded horizontal offset
  $C526 Find how many 2-pixel steps the object's horizontal offset lies right of the frame's. Does it lie left of it instead?
  $C527 Jump if so
  $C529 Shift right by 2 pixels per step, over each of the frame's pixel rows.
  $C52D Record the object's horizontal offset as the frame's.
  $C531 Start at the frame's top row.
@ $C533 label=expl_right_row
  $C533 Count the pixels to shift this row by.
@ $C535 label=expl_right_pass
  $C535 Shift the row's 24 pixels one pixel right, with a blank pixel in at the left.
  $C542,6 Move on to the next row, 3 bytes per row.
@ $C549 label=expl_left
  $C549 Shift left by 2 pixels per step, over each of the frame's pixel rows.
  $C54F Record the object's horizontal offset as the frame's.
  $C553 Start at the last byte of the frame's top row.
@ $C557 label=expl_left_row
  $C557 Count the pixels to shift this row by.
@ $C559 label=expl_left_pass
  $C559 Shift the row's 24 pixels one pixel left, with a blank pixel in at the right.
  $C566,6 Move on to the next row, 3 bytes per row.
@ $C56D label=step_hostile_left
c $C56D Move a hostile object left
D $C56D Moves the current hostile object 2 pixels left, with its background store. A blocked new column turns it back, and once it is clear of the screen's left edge it does not move.
  $C56D Step the horizontal offset one place left. Is the image back at the left edge of its column?
  $C571 Jump if so
  $C573 Was it at the left edge already?
  $C575 If not, store the new horizontal offset
  $C577 Step into the column to the left.
@ $C57A label=step_left_vacate
  $C57A The image now leaves the third byte of its rows blank, so its cover map hides that column. Put back that column of the background, except in the cells that hide the object.
  $C594 Store the horizontal offset of the left edge.
@ $C598 label=step_left_column
  $C598 Is the object clear of the screen's left edge already?
  $C59D Return if so, without a move
  $C59E Move its cells one column left.
  $C5A9 Are the cells there blocked?
  $C5AC Jump if not
  $C5AE Move its cells back, and turn it round.
@ $C5B8 label=step_left_open
  $C5B8 Shift the background store one byte right, to make room at the left of each row. As one run, the copy puts each row's last byte in the next row's first, which the save of the new column overwrites.
  $C5C7 Move the screen address one byte left.
  $C5CE Save the new left column of the background.
  $C5D8 Put the image 6 pixels into its new column.
@ $C5DA label=step_left_store
  $C5DA,7 Store the new horizontal offset, and record the move.
@ $C5E2 label=undo_step_right
c $C5E2 Turn back a hostile object blocked on the right
D $C5E2 Takes back the current hostile object's last step right, then turns it round.
  $C5E2 Take back the step.
@ $C5E6 label=reverse_hostile
  $C5E6 Turn the object round: up and down swap, and so do left and right. A struck object stays struck.
  $C5EE,4 Record the turn.
@ $C5F3 label=step_hostile_right
c $C5F3 Move a hostile object right
D $C5F3 Moves the current hostile object 2 pixels right, with its background store. A blocked new column turns it back, and once it is clear of the screen's right edge it does not move.
  $C5F3 Step the horizontal offset one place right.
  $C5FA Does the image now reach into the third byte of its rows?
  $C5FC Jump if not
  $C5FE Is the object clear of the screen's right edge already?
  $C603 Return if so, without a move
  $C604 Are the object's cells, now three columns wide, blocked?
  $C607 If so, take the step back and turn round
  $C609 Save the third byte column of the background, which the image now reaches into.
  $C61A Recover the new horizontal offset.
@ $C61C label=step_right_column
  $C61C Has the image passed the right edge of its column?
  $C61E Jump if not
  $C620 Move its cells one column right. They lay under the object already, so nothing can block them.
  $C627 Put back the first byte column of the background, except in the cells that hide the object.
  $C63B Shift the background store one byte left, so its second and third columns become the first two.
  $C648 Move the screen address one byte right, and put the image at the left edge of its new column.
@ $C650 label=step_right_store
  $C650,7 Store the new horizontal offset, and record the move.
@ $C658 label=step_hostile_up
c $C658 Move a hostile object up
D $C658 Moves the current hostile object 2 pixel rows up, with its background store. A blocked new cell row turns it back, and once it is clear of the play area's top it does not move.
  $C658 Ready the cover map's bottom row, where the image's lowest pixel rows lie unless the image is square on a cell row.
@ $C661 ssub=LD A,($C947+1)
  $C661 Is the image square on a cell row?
  $C666 Jump if not
  $C668 Is the object clear of the play area's top already?
  $C66D Return if so, without a move
  $C66E Move its cells one row up, and keep the old attribute mirror address.
  $C67D Are the cells there blocked?
  $C681 Jump if not
  $C683 Move its cells back, and turn it round.
@ $C68D label=step_up_open
  $C68D The image is square on a cell row, so its lowest pixel rows lie in the cover map's middle row.
@ $C692 label=step_up_pixels
  $C692 Is the image's top row the top row of its cell?
  $C69A Jump if not
  $C69C Move the address up a cell row, on the same pixel row.
  $C6A1 Jump if that crosses into the screen third above
  $C6A3 Within a third, add a cell's height, so that the step up lands in the cell row above.
@ $C6A5 label=step_up_line
  $C6A5 Step up to the image's new top.
  $C6A9 Find the address 16 pixel rows below the new top, where the image's 2 lowest pixel rows lay.
  $C6AD Jump unless that crosses into the next screen third
  $C6AF Move into the next third.
@ $C6B3 label=step_up_shift
  $C6B3 Put back the background's last 2 pixel rows there, except in the cells that hide the object.
  $C6C0 Shift the background store down by 2 pixel rows.
  $C6D1 Store the image's new top.
  $C6D6 Save the 2 new pixel rows of the background into the store's first rows.
  $C6DC,4 Record the move.
@ $C6E1 label=step_hostile_down
@ $C6E1 ssub=LD A,($C947+1)
c $C6E1 Move a hostile object down
D $C6E1 Moves the current hostile object 2 pixel rows down, with its background store. A blocked new cell row turns it back, and once it is clear of the screen's bottom it does not move.
  $C6E1 Is the image square on a cell row?
  $C6E8 Jump if not
  $C6EA Is the object clear of the screen's bottom already?
  $C6EF Return if so, without a move
  $C6F0 Check the three cell rows that the step reaches. With the image's top a pixel row lower, the cell search counts a third row.
@ $C6F2 ssub=LD ($C947+1),A
@ $C6F8 ssub=LD A,($C947+1)
  $C6F8 Put the image's top back.
@ $C6FC ssub=LD ($C947+1),A
  $C6FF If the cells are blocked, turn round
@ $C702 label=step_down_pixels
  $C702 Will the step take the image's top into the next cell row?
  $C706 Jump if not
  $C708 Move its cells one row down.
@ $C716 label=step_down_shift
  $C716 Put back the background's first 2 pixel rows at the image's top, except in the cells that hide the object.
  $C728 Shift the background store up by 2 pixel rows.
  $C736 Find the address 16 pixel rows below the image's top, the first of the 2 pixel rows that the image moves onto.
  $C73D Jump unless that crosses into the next screen third
  $C73F Move into the next third.
@ $C743 label=step_down_save
  $C743 Save those 2 pixel rows of the background into the store's last rows.
  $C749 Move the image's top down one step. Does it cross into the next cell row?
  $C752 Jump if not
  $C754 Move down a cell row. Does that cross into the next screen third?
  $C758 Jump if so
  $C75A Within a third, go back to the cell row's top pixel row.
@ $C75E label=step_down_store
  $C75E,7 Store the image's new top, and record the move.
@ $C766 label=cover_hostile_cell
c $C766 Hide a hostile object in a cell
D $C766 Marks a cell of the current hostile object's cover map as one that hides the object, and continues at #R$C785(the store of the map byte).
  $C766 Use the high byte of the map's address as the byte. The store at the join writes it a second time.
@ $C76A label=map_hostile_cover
c $C76A Find the cells that hide a hostile object
D $C76A Builds the current hostile object's cover map: the cells under it where a bright graphic, a bar or the Skimmer hides it.
N $C76A The map holds one byte for each of the object's 3×3 cells, in rows from the top. A byte holds the high byte of the map's own address for a cell where the game does not draw the object. Any other byte holds 0.
  $C76A Start at the map's first cell, with the high byte of its address to hand.
@ $C770 label=cover_fill
  $C770 Hide the object in every cell. A cell off the play area stays that way.
  $C774 Find the object's cells on the play area.
  $C777 Return if none lies there
  $C778 Walk the attribute mirror with one address and the map with the other.
@ $C779 label=cover_row
  $C779 Start a row of cells.
@ $C77D label=cover_cell
  $C77D Does a bright graphic, a bar or the Skimmer mark the cell?
  $C780 If so, hide the object there
  $C783 If not, show it there.
@ $C785 label=cover_store
  $C785 Store the cell's byte, and move to the next cell of the row.
  $C78A Move to the map's next row, 3 bytes per row.
  $C78E Move to the attribute mirror's next row. The count of cells is 0 here, so only the carry goes into the high byte.
  $C796,3 Count the row.
@ $C79A label=clip_hostile
c $C79A Find a hostile object's cells on the play area
D $C79A Finds the cells of the current hostile object that lie on the play area, as a block of rows and columns.
N $C79A An image at horizontal offset 0 fills 2 cells across, and at any other offset 3. An image square on a cell row fills 2 cells down, and otherwise 3.
R $C79A O:B number of cell rows on the play area, 0–3
R $C79A O:C number of cell columns on the play area, 0–3
R $C79A O:DE address in the cover map of the first cell on the play area
R $C79A O:HL attribute mirror address of the first cell on the play area
R $C79A O:F zero set if no cell lies on the play area
  $C79A Start from the object's top-left cell in the attribute mirror and in its cover map, with 3×3 cells.
  $C7A4 Is the image at the left edge of its column?
  $C7A9 Jump if not
  $C7AB It fills only 2 columns.
@ $C7AC label=clip_hostile_rows
@ $C7AC ssub=LD A,($C947+1)
  $C7AC Is the image square on a cell row?
  $C7B1 Jump if not
  $C7B3 It fills only 2 rows.
@ $C7B4 label=clip_hostile_right
  $C7B4 Does the object start off the screen's left edge?
  $C7B9 Jump if so
  $C7BC Find the column past its last cell.
@ $C7BD label=clip_right_loop
  $C7BD Does its last column lie off the right edge?
  $C7BF Jump if not
  $C7C1 Drop the last column, and check again while any column is left.
  $C7C5 None is left. Go on to the rows.
@ $C7C8 label=clip_left_loop
  $C7C8 Is the first column on the screen?
  $C7CA Jump if so
  $C7CD Drop the first column, and step both addresses one cell right. Check again while any column is left.
@ $C7D3 label=clip_hostile_bottom
  $C7D3 Does the object start above the play area?
  $C7D8 Jump if so
  $C7DA Find the row past its last cell.
@ $C7DB label=clip_bottom_loop
  $C7DB Does its last row lie below the screen's bottom?
  $C7DD Jump if not
  $C7DF Drop the last row, and check again while any row is left.
  $C7E3 None is left. Go on to the result.
@ $C7E6 label=clip_top_loop
  $C7E6 Is the first row on the play area?
  $C7E8 Jump if so
  $C7EA Drop the first row, and step the attribute mirror address one row down.
  $C7EF Jump unless that crosses a page
  $C7F1 Cross into the next page.
@ $C7F2 label=clip_top_next
  $C7F2 Step the cover map address one row down, and check again while any row is left.
@ $C7FA label=clip_hostile_done
  $C7FA Is any row left?
  $C7FD Return if not
  $C7FE,3 Is any column left? That is the answer.
@ $C802 label=toggle_hostile_marks
c $C802 Toggle a hostile object's marks in the attribute mirror
D $C802 Toggles the marks that #R$C80D(its operand) holds in each attribute mirror cell under the current hostile object on the play area. A second call with the same marks takes them away again.
N $C802 The operand holds one of these sets of marks:
N $C802 #TABLE(default) { =h Marks | =h When } { Hostile object | A move, and the set-up of a hostile object } { Hostile object and explosion | The start of an explosion, to swap the one mark for the other } { Explosion | The end of an explosion } TABLE#
  $C802 Find the object's cells on the play area.
  $C805 Return if none lies there
  $C806 Step one attribute mirror row per row of cells.
@ $C809 label=toggle_marks_row
  $C809 Start a row of cells.
@ $C80C label=toggle_marks_cell
  $C80C Toggle the marks in each cell of the row.
@ $C80D label=toggle_marks_bits
  $C813,5 Move down a row, until every row is done.
@ $C819 label=hostile_collision
c $C819 Handle a hostile object's collision
D $C819 Ends #R$C866(the block check) on a blocked cell, and makes the hostile object explode if the cell holds a shot, a hit or the Skimmer. A shot or a hit adds 20 points, and the Skimmer gets a push.
R $C819 I:HL attribute mirror address of the blocked cell
R $C819 O:F carry set
  $C819 Does the cell hold a shot or a hit?
  $C81E Jump if not
  $C820 Add 20 points.
N $C826 BUG: in a hit cell this also clears the mark of the hostile object that the hit belongs to. #R$C95B(The hit count) keeps the hit. So the struck object does not explode from it. Each move of that object then toggles its mark in the cell the wrong way round. Once the object moves off the cell, its mark stays behind there until the next screen draw.
  $C826 Take the shot or the hit out of the cell, and make the object explode.
@ $C82D label=hostile_hit_skimmer
  $C82D Does the cell hold the Skimmer?
  $C82F Jump if not: the cell only blocks the object
  $C831 Push the Skimmer the way the object moves, and time the push.
@ $C83C label=hostile_hit_explode
  $C83C Make the object explode.
@ $C841 label=hostile_hit_done
  $C841,3 Drop the row and the count that the block check saved, and return to its caller with the cell blocked.
@ $C845 label=push_skimmer
c $C845 Start a push on the Skimmer
D $C845 Gives the Skimmer its top speed in a direction, the start of a push. It leaves the step rates alone, so the Skimmer keeps its old pace on that axis until it next lies square on a cell.
R $C845 I:A direction of the push, 0–3 for up, down, left or right
  $C845 Is the push up?
  $C84A Jump if not
  $C84C,2 Give the Skimmer the top speed upward.
@ $C84F label=push_skimmer_down
  $C84F Is it down?
  $C851 Jump if not
  $C853,2 Give the Skimmer the top speed downward.
@ $C856 label=push_skimmer_left
  $C856 Is it left?
  $C85B Jump if not
  $C85D,2 Give the Skimmer the top speed to the left.
@ $C860 label=push_skimmer_right
  $C860 Is it right?
  $C862 Return if not
  $C863,2 Give the Skimmer the top speed to the right.
@ $C866 label=check_hostile_block
c $C866 Check a hostile object's cells for a block
D $C866 Reports whether a mark in the attribute mirror blocks the current hostile object in any of its cells on the play area. A blocked cell goes to #R$C819(the collision), which can make the object explode.
R $C866 O:F carry set if a cell blocks the object
  $C866 Find the object's cells on the play area.
  $C869 Jump if none lies there
  $C86B Step one attribute mirror row per row of cells.
@ $C86E label=check_block_row
  $C86E Start a row of cells.
@ $C871 label=check_block_cell
  $C871 Does a bright graphic, the Skimmer, a hostile object or an explosion mark the cell?
  $C874 If so, handle the collision there
  $C876 Move to the next cell of the row.
  $C879 Move down a row, until every row is done.
@ $C87E label=check_block_clear
  $C87E,1 No cell blocks the object.
@ $C880 label=hostile_fire
c $C880 Let a hostile object fire
D $C880 Fires the hostile objects' shot from the current hostile object at right angles to its travel, toward the Skimmer's side. The defence device never fires.
N $C880 A hostile object turns only when it lies square on a cell, so it always lies square on a cell across its travel. The first test joins its horizontal offset across and its pixel row down its cell. So it passes only when the object lies half a cell into its travel, where its middle meets a cell's middle.
  $C880 Is the object half a cell into its travel?
  $C88B Return if not
  $C88C Is the hostile objects' shot free?
  $C891 Return if not
  $C892 Will the object steer when it next lies square on a cell?
  $C897 Return if so
  $C898 Is the object on the current screen?
  $C89F Return if not
  $C8A0 Is its explosion under way?
  $C8A5 Return if so
  $C8A6 Does it move left or right?
  $C8A8 If so, fire up or down
N $C8AA The object moves up or down, so it fires left or right.
  $C8AA Does the object reach off the screen's right edge?
  $C8B2 Return if so
  $C8B3 Is it left of the Skimmer's column?
  $C8B4 If so, fire right
  $C8B6 Is it in the screen's first column?
  $C8B8 Return if so: no cell lies to its left
  $C8B9 Fire left from beside the object's middle cell row, as far as the screen's left edge.
@ $C8C1 label=hostile_fire_right
  $C8C1 Is the object too near the right edge for a shot?
  $C8C3 Return if so
N $C8C4 BUG: the range stops a shot fired right one column short of the screen's right edge. The shots fired the other three ways, and the pulse laser shot in all four, reach the edge they travel toward.
  $C8C4 Set the range to reach the column before the right edge.
  $C8C8 Fire right from beside the object's middle cell row.
@ $C8D0 label=hostile_fire_vert
  $C8D0 The object moves left or right, so it fires up or down. Does it reach above the play area?
  $C8D8 Return if so
  $C8D9 Does it reach below the screen's bottom?
  $C8DB Return if so
  $C8DC Is it above the Skimmer's row?
  $C8DD If so, fire down
  $C8DF Count the cell rows of the play area above the object.
  $C8E1 Return if there are none
  $C8E3 Fire up from beside the object's middle cell column, as far as the play area's top.
@ $C8EB label=hostile_fire_down
  $C8EB Is the object too near the bottom for a shot?
  $C8ED Return if so
  $C8EE Set the range to reach the screen's bottom.
  $C8F2 Fire down from beside the object's middle cell column.
@ $C8F7 label=hostile_fire_launch
  $C8F7 Find the attribute mirror address of the shot's first cell, and set the shot's range.
N $C8FE BUG: a first cell that holds the Skimmer pushes it in the direction in #REGc, which this routine never sets. #REGc holds 3 from the object's draw, so the push is always down, whichever way the object fires. The push reports the cell as a stop, so no shot launches.
  $C8FE Does the first cell stop the shot?
  $C901 Return if so
  $C902 Launch the hostile objects' shot in its direction.
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
B $C927,1 Range in cells of the shot that is launched or moved
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
B $C946,1 Number of hostile objects that lie on the current screen or explode, in the pair that moves
@ $C947 label=hostile_screen_pos
g $C947 Current hostile object
D $C947 A copy of the record of the hostile object that moves, from its slot.
N $C947 The state of the hostile object takes these values:
N $C947 #TABLE(default) { =h State | =h What it is } { 0–3 | It moves up, down, left or right } { $17 | It is the defence device, which never moves } { $80–$86 | It shows explosion frame 1–7 } { $FE | The slot is empty, or a struck object turned back in its move } { $FF | A struck object, whose explosion starts in its move } TABLE#
W $C947,2 Screen address of the hostile object's top pixel row
@ $C949 label=hostile_x_shift
B $C949,1 Horizontal offset of the hostile object's image from the left edge of its column, 0–3 in steps of 2 pixels
@ $C94A label=hostile_column
B $C94A,1 Column of the hostile object's left cell, from −2 to 32, where a column outside 0–31 lies off the screen
@ $C94B label=hostile_row
B $C94B,1 Character row of the hostile object's top cell, from 4 to 24, where a row outside 6–23 lies off the play area
@ $C94C label=hostile_attr_pos
W $C94C,2 Attribute mirror address of the hostile object's top-left cell
@ $C94E label=hostile_state
B $C94E,1 State of the hostile object
@ $C94F label=hostile_cover_ptr
W $C94F,2 Address of the hostile object's cover map, one byte for each of its 3×3 cells
@ $C951 label=hostile_bg_ptr
W $C951,2 Address of the hostile object's background store, 16 pixel rows of 3 bytes
@ $C953 label=hostile_image_ptr
W $C953,2 Address of the hostile object's shifted images and their masks, or of the defence device's design
@ $C955 label=hostile_steer_count
B $C955,1 Cells left before the hostile object next steers toward the Skimmer, or 23 for the defence device, which never steers
@ $C956 label=hostile_screen_num
B $C956,1 Number of the screen that the hostile object is on
@ $C957 label=hostile_moved
g $C957 Hostile object moved
B $C957,1 1 if the current hostile object stepped during its move, 0 if not
@ $C958 label=hostile_tick
g $C958 Hostile object tick
B $C958,1 Count of the moves of the hostile objects, 0–255
u $C959 Unused bytes
@ $C95B label=hit_count
g $C95B Hit count
B $C95B,1 Number of hit cells that wait for their hostile object's move
@ $C95C label=hostile_turned
g $C95C Hostile object turned
B $C95C,1 1 if the current hostile object turned back during its move, 0 if not
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
D $C963 Moves the Skimmer left by one horizontal step. A cell that blocks it turns it back, and at the screen's left edge it flags an exit.
N $C963 All four moves of the Skimmer work alike. A move checks for a block only when the Skimmer reaches into a new column or row of cells. A block or an exit leaves the Skimmer where it stands. A block also reverses the Skimmer's speed on that axis.
N $C963 A step puts back the background where the Skimmer leaves, and saves the background where it arrives. So the background store holds the screen under the Skimmer's place. Cells where the cover map hides the Skimmer keep their screen bytes.
N $C963 Each move takes the offset to be a whole number of steps from the cell grid. So a step never crosses a cell edge partway.
  $C963 Take one step off the offset. Does the Skimmer stay in its cell?
  $C96A If so, move it inside the cell
  $C96C Keep the new offset, which is below zero.
  $C96D Is the Skimmer in the screen's first column?
  $C972 If not, move it into the column on its left
  $C974,6 Flag an exit across the left edge, and drop the new offset.
@ $C97B label=move_left_blocked
  $C97B Drop the new offset.
@ $C97C label=turn_skimmer_x
N $C97C This entry point reverses the horizontal speed alone.
  $C97C,8 Reverse the horizontal speed.
@ $C985 label=move_left_cell
  $C985 Move the Skimmer's top-left cell one column left, in its column and its attribute mirror address.
  $C990 Is the way clear through the new column of cells?
  $C993 If so, move the Skimmer into it
  $C995 Blocked: put back the column and the attribute mirror address, and turn the Skimmer back.
@ $C99E label=move_left_px
N $C99E The Skimmer moves left inside its cell.
  $C99E Jump unless the Skimmer now lies square on its cell column
  $C9A0 Put back the background of the fourth column, which the Skimmer no longer covers, apart from cells where the cover map hides it.
@ $C9A6 ssub=LD DE,skimmer_bg_store+3
@ $C9AA ssub=LD HL,skimmer_cover_map+3
  $C9B3 The new offset is 0.
@ $C9B7 label=move_left_scroll
N $C9B7 The new column is clear, and the Skimmer moves into it.
  $C9B7 Shift the background store one column right, which drops its fourth column.
@ $C9BA ssub=LD HL,skimmer_bg_store+$5E
@ $C9BD ssub=LD DE,skimmer_bg_store+$5F
  $C9C2 Move the Skimmer's screen address one column left.
  $C9C9 Save the background of the new first column.
  $C9CF Take back the new offset, and add 4 to measure it in the new cell.
@ $C9D2 label=store_left_px
  $C9D2,7 Store the new offset, and count the step.
@ $C9DA label=exit_screen_right
c $C9DA Flag an exit to the screen on the right
D $C9DA Flags that the Skimmer leaves the screen across its right edge.
  $C9DA,5 Note the right edge as the one crossed.
@ $C9E0 label=move_skimmer_right
c $C9E0 Move the Skimmer right
D $C9E0 Moves the Skimmer right by one horizontal step. A cell that blocks it turns it back, and at the screen's right edge it flags an exit.
  $C9E0 Does the Skimmer lie square on its cell column?
  $C9E5 Jump if not: it already covers a fourth column
N $C9E7 The Skimmer covers three columns of cells, and a step right takes it into a fourth.
  $C9E7 Does it reach the screen's right edge?
  $C9EC If so, flag the exit
  $C9EE Is the way clear through the column of cells on its right?
  $C9F7 If not, turn the Skimmer back
@ $C9FA ssub=LD DE,skimmer_bg_store+3
  $C9FA Save the background of that column, the fourth that the Skimmer now covers.
  $CA06 The offset starts from 0.
@ $CA07 label=move_right_px
  $CA07 Add the step to the offset. Does the Skimmer stay in its cell?
  $CA0D If so, store the new offset
  $CA0F Keep the new offset, which runs past the cell.
  $CA10 Move the Skimmer's top-left cell one column right, in its column and its attribute mirror address.
  $CA18 Put back the background of the first column, which the Skimmer leaves.
  $CA28 Shift the background store one column left, which drops its first column.
@ $CA2B ssub=LD HL,skimmer_bg_store+1
  $CA33 Move the Skimmer's screen address one column right.
  $CA3A Save the background of the new fourth column.
@ $CA3D ssub=LD DE,skimmer_bg_store+3
  $CA43 Take back the new offset, and take 4 off to measure it in the new cell.
@ $CA46 label=store_right_px
  $CA46,7 Store the new offset, and count the step.
@ $CA4E label=exit_screen_top
c $CA4E Flag an exit to the screen above
D $CA4E Flags that the Skimmer leaves the screen across its top edge.
  $CA4E,5 Note the top edge as the one crossed.
@ $CA54 label=move_skimmer_up
c $CA54 Move the Skimmer up
D $CA54 Moves the Skimmer up by one vertical step. A cell that blocks it turns it back, and at the top of the play area it flags an exit.
N $CA54 A step up uncovers a strip as deep as the step along the Skimmer's bottom edge.
  $CA54 Take the strip's cells from the cover map's fourth row.
@ $CA55 ssub=LD HL,skimmer_cover_map+$0C
@ $CA59 ssub=LD A,($D2B0+1)
  $CA59 Does the Skimmer's top lie on a cell's top pixel row?
  $CA5E Jump if not: it already covers a fourth row of cells
N $CA60 The Skimmer covers three rows of cells, and a step up takes it into the row above.
  $CA60 Is it at the top of the play area?
  $CA65 If so, flag the exit
  $CA67 Move its top-left cell up a row.
  $CA6B Is the way clear through the row of cells above?
  $CA77 If so, go on with the step
  $CA79 Blocked: put the row back.
@ $CA7D label=turn_skimmer_y
  $CA7D,8 Reverse the vertical speed: the Skimmer turns back.
@ $CA86 label=move_up_row_clear
  $CA86 The way is clear. The strip lies in the Skimmer's third row of cells, so take its cells from the cover map's third row. Keep the new attribute mirror address.
@ $CA87 ssub=LD HL,skimmer_cover_map+8
@ $CA8E label=move_up_px
  $CA8E Find the screen address of the Skimmer's new top, a step higher. Does the top lie below a cell's top pixel row?
  $CA99 If so, take the step off its pixel row
  $CA9B Move up a row of cells. Does that cross into the third of the screen above?
  $CAA0 Jump if so: the step off the high byte reaches that third
  $CAA2 Add a cell's depth to the high byte, so the step lands in the cell above.
@ $CAA4 label=move_up_line
  $CAA4 Take the step off the pixel row, and keep the new top.
  $CAA7 Find the strip's screen address, three rows of cells below the new top. Does it stay in the same third of the screen?
  $CAAB Jump if so
  $CAAD Move it into the next third.
@ $CAB1 label=move_up_source
@ $CAB1 ssub=LD HL,skimmer_bg_store+$58
  $CAB1 Take the strip from the store's bottom two pixel rows. Is the step the deeper one?
  $CAB9 Jump if not
@ $CABB ssub=LD HL,skimmer_bg_store+$50
  $CABB Take it from the bottom four rows instead.
@ $CABE label=move_up_draw
  $CABE Put the strip's background back, apart from cells where the cover map hides the Skimmer.
  $CAC1 Is the step the deeper one?
  $CAC6 Jump if not
@ $CAC8 ssub=LD HL,skimmer_bg_store+$4F
  $CAC8 Shift the store down four pixel rows, which drops its bottom four.
@ $CAD0 label=move_up_small_step
@ $CAD0 ssub=LD HL,skimmer_bg_store+$57
  $CAD0 Shift the store down two pixel rows, which drops its bottom two.
@ $CAD6 label=move_up_scroll
@ $CAD6 ssub=LD DE,skimmer_bg_store+$5F
  $CAD6 Run the shift from the store's end backward.
  $CADB Make the new top the Skimmer's screen address.
  $CADF Save the background of the rows it enters into the store's top rows.
  $CAE5,4 Count the step.
@ $CAEA label=exit_screen_bottom
c $CAEA Flag an exit to the screen below
D $CAEA Flags that the Skimmer leaves the screen across its bottom edge.
  $CAEA,5 Note the bottom edge as the one crossed.
@ $CAF0 label=move_skimmer_down
@ $CAF0 ssub=LD A,($D2B0+1)
c $CAF0 Move the Skimmer down
D $CAF0 Moves the Skimmer down by one vertical step. A cell that blocks it turns it back, and at the bottom of the screen it flags an exit.
N $CAF0 A step down uncovers a strip as deep as the step along the Skimmer's top edge.
  $CAF0 Does the Skimmer's top lie on a cell's top pixel row?
  $CAF5 Jump if not: it already covers a fourth row of cells
N $CAF7 The Skimmer covers three rows of cells, and a step down takes it into the row below.
  $CAF7 Does it reach the bottom of the screen?
  $CAFC If so, flag the exit
  $CAFF Is the way clear through the row of cells below?
  $CB09 If not, turn the Skimmer back
@ $CB0C ssub=LD A,($D2B0+1)
  $CB0C Take the top's pixel row again.
@ $CB11 label=move_down_px
  $CB11 Add the step to the top's pixel row. Does the top stay in its row of cells?
  $CB17 If so, keep the row
  $CB19 Move the Skimmer's top-left cell down a row, in its row and its attribute mirror address.
@ $CB27 label=move_down_source
  $CB27 Put back the strip's background from the store's top rows, apart from cells where the cover map's first row hides the Skimmer.
  $CB36 Is the step the deeper one?
  $CB3B Jump if so
  $CB3D Shift the store up two pixel rows, which drops its top two.
@ $CB40 ssub=LD HL,skimmer_bg_store+8
@ $CB45 label=move_down_big_step
  $CB45 Shift the store up four pixel rows, which drops its top four.
@ $CB48 ssub=LD HL,skimmer_bg_store+$10
@ $CB4B label=move_down_scroll
  $CB4B Run the shift from the store's start forward.
  $CB50 Find the screen address of the rows the Skimmer enters, three rows of cells below its top. Do they stay in the same third of the screen?
  $CB57 Jump if so
  $CB59 Move into the next third.
@ $CB5D label=move_down_draw
  $CB5D Point at the store's bottom two pixel rows. Is the step the deeper one?
@ $CB60 ssub=LD DE,skimmer_bg_store+$58
  $CB65 Jump if not
@ $CB67 ssub=LD DE,skimmer_bg_store+$50
  $CB67 Point at its bottom four rows instead.
@ $CB6A label=move_down_draw_at
  $CB6A Save the background of the rows the Skimmer enters.
  $CB6D Add the step to the top's pixel row. Does it stay inside the cell?
  $CB79 If so, keep the new top
  $CB7B Move down a row of cells. Does that cross into the next third of the screen?
  $CB7F If so, the carry from the pixel row already points into that third
  $CB81 Take back the carry from the pixel row into the third.
@ $CB85 label=move_down_store
  $CB85,8 Keep the new top as the Skimmer's screen address, and count the step.
@ $CB8E label=unused_delay
c $CB8E Unused delay loop
D $CB8E A delay loop that no routine in the game calls.
  $CB8E Double the count, and take one off.
@ $CB90 label=unused_delay_pass
  $CB90 Spend time. The five loads only read the ROM, and keep no result.
  $CBA4,3 Loop until the count runs out.
@ $CBA8 label=draw_skimmer
c $CBA8 Draw the Skimmer
D $CBA8 Draws the Skimmer's flip frame or shield loss frame, or else its image for its horizontal offset, through its mask over its saved background. It leaves alone the cells where its #R$CD3A(cover map) hides it.
  $CBA8 Put back the fourth step of the cover map's rewind, which the move of the hostile objects takes out. A row of the Skimmer's map holds four cells.
@ $CBAA ssub=LD ($CC32),A
  $CBAD Does a flip run?
  $CBB2 Jump if not
  $CBB4 Take the flip frames, and count the flip's frame from 0.
@ $CBBB label=skimmer_draw_loss
  $CBBB Does a shield loss run?
  $CBC0 Jump if not
  $CBC2 Take the shield loss frames, with the stage of the loss as the frame.
N $CBC6 BUG: this reduces #REGc, which nothing reads, where the flip reduces its frame in #REGa. So stage 1 draws the second frame, and the first frame never shows.
  $CBC6 Go to find the frame's entry.
@ $CBCA label=skimmer_draw_shift
  $CBCA Otherwise take the Skimmer's normal or flipped images, with its horizontal offset as the image.
@ $CBD1 label=skimmer_draw_frame
  $CBD1 Find the frame's or image's entry, 4 bytes per entry.
  $CBD8 Hand the draw the background store, the entry's mask and the cover map in the other register set.
  $CBE6 Draw the entry's frame or image at the Skimmer's screen address.
@ $CBF3 label=skimmer_draw_row
c $CBF3 Draw a frame or image through its mask
D $CBF3 Draws a frame or image through its mask over the background store, for the Skimmer and the hostile objects alike. It leaves out the cells that the cover map hides.
R $CBF3 I:B number of pixel rows
R $CBF3 I:C number of bytes in a pixel row
R $CBF3 I:DE screen address of the top-left byte
R $CBF3 I:HL address of the frame or image
R $CBF3 I:BC' address of the cover map
R $CBF3 I:DE' address of the mask
R $CBF3 I:HL' address of the background store
  $CBF3 Start a pixel row.
@ $CBF6 label=skimmer_draw_byte
  $CBF6 Does the cover map hide the object in this cell? A hidden cell's byte equals the high byte of the map's address.
  $CBF9 Jump if so
  $CBFB Write the background through the mask, with the frame or image over it. Step on through the mask, the background store and the cover map.
@ $CC03 label=skimmer_draw_next
  $CC03 Step on through the frame or image and along the screen row, to the row's end.
  $CC07 Find the pixel row's place in its cell, 0 for the top.
@ $CC0A label=skimmer_draw_sound
  $CC0A Is it at or below #R$D2CD(the click row)? The play loop copies the click row into this operand, and an explosion sets its own.
  $CC0C Jump if not
  $CC0E Click the speaker.
@ $CC17 label=skimmer_draw_down
  $CC17 Move the screen address down one pixel row. Does the new row lie in the same row of cells?
  $CC1C Jump if so
  $CC1F Move to the next row of cells. Jump if it starts a new third of the screen.
  $CC26 Otherwise take the address back up a cell's height.
@ $CC2A label=skimmer_draw_rows_left
  $CC2A,3 Leave the cover map at its next row, and count the pixel row.
@ $CC2E label=skimmer_draw_rewind
  $CC2E The new pixel row lies in the same row of cells. Step the cover map back to the start of its row.
@ $CC32 label=skimmer_draw_map_back
  $CC32 The fourth step back. The Skimmer's draw makes it DEC C, for map rows of four cells. The hostile objects' move makes it a NOP, for rows of three.
  $CC34,3 Count the pixel row.
@ $CC38 label=skimmer_draw_covered
  $CC38 Leave the screen byte as it is. Step on through the mask, the background store and the cover map. The dummy read gives a skipped byte the same T-states as a drawn one.
@ $CC42 label=save_skimmer_bg
c $CC42 Save the background behind the Skimmer
D $CC42 Copies the screen under the Skimmer into its background store.
  $CC42 Start at the store's first byte and the Skimmer's top-left screen byte.
  $CC48 Copy three columns in this loop. The fourth follows as the loop runs on into the column copy.
@ $CC4A label=skimmer_bg_col
  $CC4A Copy one column, then move one column right on the screen and in the store.
@ $CC57 label=save_bg_column
c $CC57 Save one column of the Skimmer's background
D $CC57 Copies one column of the screen, the Skimmer's full depth, into the background store.
R $CC57 I:DE address of the column's top byte in the background store
R $CC57 I:HL screen address of the column's top byte
  $CC57 Walk the column down the Skimmer's depth, one row of the store for each pixel row.
@ $CC5A label=bg_save_row
  $CC5A Copy one byte. Return after the last pixel row.
  $CC5E Move to the store's next row.
  $CC61 Move the screen address down one pixel row. Does the new row lie in the same row of cells?
  $CC65 Jump if so
  $CC67 Move to the next row of cells. Jump if it starts a new third of the screen.
  $CC6D Otherwise take the address back up a cell's height.
@ $CC73 label=restore_bg_column
c $CC73 Put back one column of the Skimmer's background
D $CC73 Copies one column of the Skimmer's background store back to the screen. It leaves alone the cells where its cover map hides the Skimmer, so whatever hides it there stays whole.
R $CC73 I:HL screen address of the column's top byte
R $CC73 I:DE address of the column's top byte in the background store
R $CC73 I:HL' address of the column's top cell in the cover map
R $CC73 I:C' number of cells in a row of the cover map
  $CC73 Walk the column down the Skimmer's depth, one row of the store for each pixel row.
@ $CC77 label=bg_restore_row
  $CC77 Does the cover map hide the Skimmer in this cell? A hidden cell's byte equals the high byte of the map's address.
  $CC7B Jump if so
  $CC7D Put the background byte back.
@ $CC7F label=bg_restore_next
  $CC7F Return after the last pixel row.
  $CC81 Move to the store's next row.
  $CC84 Move the screen address down one pixel row. Does the new row lie in the same row of cells?
  $CC88 Jump if so
  $CC8A Move the cover map to its next row.
  $CC8F Move to the next row of cells. Jump if it starts a new third of the screen.
  $CC95 Otherwise take the address back up a cell's height.
@ $CC9B label=save_screen_block
c $CC9B Save a strip of the screen behind the Skimmer
D $CC9B Copies a strip of the screen, the Skimmer's width across and one vertical step deep, into its background store. The strip lies in one row of cells.
R $CC9B I:HL screen address of the strip's top-left byte
R $CC9B I:DE address of the strip in the background store
  $CC9B Take the Skimmer's width across, and one vertical step of pixel rows.
@ $CCA1 label=block_save_row
  $CCA1 Start a pixel row.
@ $CCA4 label=block_save_byte
  $CCA4 Copy the row, and run on through the store.
  $CCAA,5 Move down one pixel row. The strip never leaves its row of cells, so no cell row changes.
@ $CCB0 label=restore_screen_block
c $CCB0 Put back a strip of the screen behind the Skimmer
D $CCB0 Copies a strip of the Skimmer's background store back to the screen, the Skimmer's width across and one vertical step deep. It leaves alone the cells where its cover map hides the Skimmer.
N $CCB0 The strip lies in one row of cells, so every pixel row reads one row of the cover map.
R $CCB0 I:HL address of the strip in the background store
R $CCB0 I:DE screen address of the strip's top-left byte
R $CCB0 I:HL' address of the first cell of the strip's row in the cover map
  $CCB0 Take the Skimmer's width across, and one vertical step of pixel rows.
@ $CCB6 label=block_restore_row
  $CCB6 Start a pixel row.
@ $CCB9 label=block_restore_byte
  $CCB9 Does the cover map hide the Skimmer in this cell? A hidden cell's byte equals the high byte of the store's address, which lies on the map's page.
  $CCBE Jump if so
  $CCC0 Put the background byte back.
@ $CCC2 label=block_restore_next
  $CCC2 Step along the row.
  $CCC6,12 Move down one pixel row, and step the cover map back to the start of its row.
@ $CCD3 label=check_skimmer_column
c $CCD3 Check the cells beside the Skimmer
D $CCD3 Checks the column of cells that a step left or right takes the Skimmer into, for anything that blocks it. A hostile object or shot that blocks it also starts a push on the Skimmer.
N $CCD3 The flipped Skimmer passes under one kind of bright graphic that stops it the right way up.
R $CCD3 I:HL attribute mirror address of the column's top cell
R $CCD3 O:F carry set if the way is clear
  $CCD3 Take the marks that block the Skimmer the right way up.
  $CCD5 Is it flipped?
  $CCDA Jump if not
  $CCDC Drop the mark of the bright graphics that the flipped Skimmer passes under.
@ $CCDE label=check_skimmer_col_len
  $CCDE Does the Skimmer's top pixel row lie below a cell's top, so that it spans a fourth row of cells?
@ $CCE0 ssub=LD A,($D2B0+1)
  $CCE5 Jump if so
  $CCE7 It spans three.
@ $CCE8 label=check_skimmer_col_go
  $CCE8 Step down one row of cells at a time.
@ $CCEB label=check_skimmer_col_cell
  $CCEB Does a mark in this cell block the Skimmer?
  $CCED Jump if so
  $CCEF Check the next cell down.
  $CCF2,1 The way is clear.
@ $CCF4 label=skimmer_blocked
N $CCF4 The Skimmer's way is blocked. Both checks come here with #REGhl at the cell that blocks it.
  $CCF4 Does the cell hold a hostile object with no hit?
  $CCF9 Jump if so
  $CCFB Does it hold a shot, or a hit?
  $CCFD Jump if not: something else blocks the way
  $CCFF,6 Start a short push on the Skimmer, and report the way blocked.
@ $CD06 label=skimmer_blocked_mark
  $CD06 The Skimmer rams a hostile object. Mark the cell hit, count the hit and start a long push on the Skimmer.
@ $CD16 label=skimmer_blocked_done
  $CD16,1 Report the way blocked.
@ $CD18 label=check_skimmer_row
c $CD18 Check the cells above or below the Skimmer
D $CD18 Checks the row of cells that a step up or down takes the Skimmer into, for anything that blocks it. A blocked step ends at #R$CCF4(the column check's response).
R $CD18 I:HL attribute mirror address of the row's left cell
R $CD18 O:F carry set if the way is clear
  $CD18 Pick the marks that block the Skimmer, as #R$CCD3(the column check) does.
  $CD1A Is the Skimmer flipped?
  $CD1F Jump if not
  $CD21 Drop the mark that the flipped Skimmer passes under.
@ $CD23 label=check_skimmer_row_len
  $CD23 Does the Skimmer sit right of its cell's left edge, so that it spans a fourth column of cells?
  $CD2A Jump if so
  $CD2C It spans three.
@ $CD2D label=check_skimmer_row_cell
  $CD2D Does a mark in this cell block the Skimmer?
  $CD2F Jump if so
  $CD31 Check the next cell along.
  $CD34,1 The way is clear.
@ $CD36 label=cover_map_hide
c $CD36 Hide the Skimmer in a cell of its cover map
D $CD36 Hides the Skimmer in the current cell of #R$CD3A(its cover map), and goes back to the build of the map.
  $CD36 A hidden cell holds the high byte of the map's address.
@ $CD3A label=map_skimmer_cover
c $CD3A Build the Skimmer's cover map
D $CD3A Builds the Skimmer's cover map: the cells under it where a bright graphic, a bar, a hostile object or a shot hides it. At its cell's left edge the Skimmer's images leave the fourth column empty, and the map hides it there too.
  $CD3A Keep the Skimmer's horizontal offset in the other #REGa.
  $CD3F Start at the map's first cell and the Skimmer's top-left cell in the attribute mirror, with four rows of four cells to walk.
@ $CD49 label=cover_map_row
  $CD49 Start a row of cells, with the horizontal offset to hand.
@ $CD4F label=cover_map_cell
  $CD4F Does a bright graphic, a bar, a hostile object or a shot mark the cell?
  $CD52 If so, hide the Skimmer there
  $CD55 Is this the fourth column, with the Skimmer at its cell's left edge? The count of cells left plus the horizontal offset tells: only the last cell at horizontal offset 0 gives this sum.
  $CD59 If so, hide the Skimmer there
  $CD5B If not, show it there.
@ $CD5D label=cover_map_store
  $CD5D Store the cell's byte, and move to the next cell of the row.
  $CD62 Move to the attribute mirror's next row. The count of cells is 0 here, so only the carry goes into the high byte.
  $CD6A,3 Count the row.
@ $CD6E label=get_skimmer_span
c $CD6E Find the cells under the Skimmer
D $CD6E Gives the block of cells under the Skimmer in the attribute mirror. On each axis it spans three cells where the Skimmer sits on a cell edge, and four otherwise.
R $CD6E O:HL attribute mirror address of the Skimmer's top-left cell
R $CD6E O:B number of rows of cells under the Skimmer, 3 or 4
R $CD6E O:C number of columns of cells under the Skimmer, 3 or 4
  $CD6E Start from four rows and four columns at the Skimmer's top-left cell.
  $CD74 Does the Skimmer sit right of its cell's left edge?
  $CD79 Jump if so
  $CD7B It spans three columns.
@ $CD7C label=get_skimmer_span_rows
@ $CD7C ssub=LD A,($D2B0+1)
  $CD7C Does its top pixel row lie below a cell's top?
  $CD83 Return if so
  $CD84,1 It spans three rows.
@ $CD86 label=toggle_skimmer_mark
c $CD86 Toggle the Skimmer's mark in the attribute mirror
D $CD86 Toggles the Skimmer's mark in each attribute mirror cell under it, and continues into #R$CD89(the block toggle).
@ $CD89 label=toggle_cells_mark
c $CD89 Toggle the Skimmer's mark over a block of cells
D $CD89 Toggles the Skimmer's mark in each attribute mirror cell of a block that the caller gives.
R $CD89 I:B number of rows of cells
R $CD89 I:C number of columns of cells
R $CD89 I:HL attribute mirror address of the block's top-left cell
  $CD89 Step down one row of cells at a time.
@ $CD8C label=toggle_cells_mark_row
  $CD8C Start a row.
@ $CD8F label=toggle_cells_mark_cell
  $CD8F Toggle the Skimmer's mark in each cell of the row.
  $CD96,5 Move to the next row.
@ $CD9C label=skimmer_image_addrs
b $CD9C Skimmer image addresses
D $CD9C The addresses of #R$8800(the Skimmer images) and their masks, by the Skimmer's horizontal offset from its cell's left edge in steps of 2 pixels. Each entry holds the address of an image, then the address of its mask.
W $CD9C,16,4
@ $CDAC label=skimmer_flipped_addrs
N $CDAC The entries of the #R$8D60(flipped Skimmer images). They take the masks of the images the right way up.
W $CDAC,16,4
@ $CDBC label=flip_frame_addrs
b $CDBC Addresses of the Skimmer's flip frames
D $CDBC The addresses of #R$8B20(the flip frames) and their masks, which #R$CBA8(the Skimmer's draw) shows in turn whichever way the Skimmer turns over. Each entry is laid out as one of #R$CD9C(the Skimmer image addresses).
W $CDBC,12,4
@ $CDC8 label=shield_loss_addrs
b $CDC8 Addresses of the Skimmer's shield loss frames
D $CDC8 The addresses of #R$8EE0(the shield loss frames) and their masks, one entry for each #R$D2D4(the loss's stage), from 0. Each entry is laid out as one of #R$CD9C(the Skimmer image addresses).
N $CDC8 A defect in #R$CBC6(the Skimmer's draw) skips the first frame.
W $CDC8,32,4
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
c $CE26 Interrupt routine that raises the interrupt flag
D $CE26 Marks each interrupt at #R$D2AF(the interrupt flag).
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
  $CF08 The new screen has no hatchway, launch cells or hits yet, and no shield loss is due or under way. A due loss leaves the indicator at 0, so the next readout update makes the loss due again, from its first stage.
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
  $CFA3 Let the Skimmer draw click the speaker while a shot's clicks run.
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
N $D08A A step across an edge of the screen leads to the next screen on the hull map. At an edge of the hull map it leads nowhere, and the Skimmer stays at the edge of its screen. The vertical step runs first, and each step notes only an edge it crosses. So a pass that crosses two edges leaves by the side one. When that side edge is an edge of the hull map, such a pass leaves by neither.
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
  $D112 Count down the clicks of a shot. When they end, switch off their click row too.
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
D $D219 Sets one axis's step size and step mask from the Skimmer's speed on it, and adds 1 to #R$D2D3(the movement flag) when the axis moves. While no push runs, a flipped Skimmer takes the rates of the next slower speed.
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
  $D262 The loss is over. Clear its stage and #R$D48D(the shield loss due flag), and refill the indicator and show it.
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
B $D2CE,1 Passes of the play loop left in the clicks of a shot, from either side, 0 when none run
@ $D2CF label=skimmer_image_set
W $D2CF,2 Address of the entries of #R$CD9C(the Skimmer image addresses) in use, normal or flipped
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
R $D2D6 I:HL address of the first digit, in the form of #R$D479(the readout digits)
  $D2D6 Find the screen address of the first digit's cell, and keep it in the other register set for the digit printer.
  $D2DC Fetch the number of digits and the address of the first.
@ $D2DE label=readout_digit
  $D2DE,7 Print each digit, from left to right.
@ $D2E6 label=print_inverse_digit
c $D2E6 Print one control panel digit
D $D2E6 Prints one digit in inverse video, rolled partway on toward the next digit by its eighths, and moves to the next cell on the right.
R $D2E6 I:A the digit, in the form of #R$D479(the readout digits)
R $D2E6 I:HL' screen address of the digit's cell
R $D2E6 O:HL' screen address of the next cell on the right
  $D2E6 Switch to the screen address.
@ $D2E7 ssub=ADD A,font%$100
N $D2E7 The font holds the digits 0 to 9 and a second 0 after the 9, 8 bytes per glyph. A digit's byte is the offset of its glyph, plus its eighths. The eighths start the draw lower in the glyph and finish it in the top rows of the next glyph. So a digit rolls up its cell as its eighths grow, and a 9 rolls on into a 0.
  $D2E7 Point at the digit's pixel rows in the font.
@ $D2EA ssub=LD A,font/$100
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
@ $D343 ssub=LD DE,damage_digits+2
c $D343 Update the Damage Report Indicator and the score
D $D343 Runs the Damage Report Indicator down, faster while a push on the Skimmer runs, and starts a shield loss when it drops under zero. It also prints the indicator and counts the points still due into the score, one step per call.
  $D343 Take the slow drain for the indicator. Is a push on the Skimmer under way?
@ $D346 ssub=LD HL,slow_drain+2
  $D34E Jump if not
@ $D350 ssub=LD HL,fast_drain+2
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
@ $D386 ssub=LD (score_step+5),A
@ $D38F label=score_steps_left
  $D38F Are 256 steps or more left?
  $D392 Jump if not
  $D394 Is the count even?
  $D396 Jump if not
@ $D398 ssub=LD DE,score_step+5
  $D398 Is the step under four points?
  $D39E Jump if not
  $D3A0 Halve the count, double the step, and count the times the step doubled.
@ $D3AD label=score_one_step
  $D3AD Spend one step, and add it to the score.
@ $D3B1 ssub=LD DE,score_digits+5
@ $D3B4 ssub=LD HL,score_step+5
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
@ $D473 label=slow_drain
b $D473 Damage Report Indicator drains
D $D473 The amounts that the Damage Report Indicator loses on each update, as three digits in the form of #R$D479(the readout digits).
B $D473,3 Slow drain, while no push on the Skimmer runs: one eighth of a unit
@ $D476 label=fast_drain
B $D476,3 Fast drain, while a push on the Skimmer runs: three units and one eighth
@ $D479 label=score_step
g $D479 Readout digits
D $D479 The score step, the Damage Report Indicator and the score, as decimal digits, first digit first. Each digit takes one byte: eight times its value, plus its eighths on the way to the next value, from 0 to 79.
B $D479,6 Score step, in the last digit: an eighth, a quarter or a half of a point, or 1, 2 or 4 points
@ $D47F label=damage_digits
B $D47F,3 Damage Report Indicator, from 0 to 999
@ $D482 label=score_digits
B $D482,6 Score
@ $D488 label=step_count
g $D488 Score step count
W $D488,2 Number of score steps still to add to the score
@ $D48A label=points_due
g $D48A Points due
W $D48A,2 Points still to count into the score, in eighths of a point
@ $D48C label=step_doublings
g $D48C Score step doublings
B $D48C,1 Number of times the score step doubled from one eighth of a point, 0–5
@ $D48D label=shield_loss_due
g $D48D Shield loss due
B $D48D,1 1 while a shield loss is due or runs, 0 otherwise
u $D48E Unused bytes
@ $D800 label=outer_layout_addrs
w $D800 Outer hull layout addresses
D $D800 The address of the #R$D8DC(layout) of each outer hull screen, one word per screen number.
@ $D8DC label=outer_layout_0
@ $D8DC rom
b $D8DC Outer hull screen layouts
D $D8DC The graphics on each screen of the outer hull, one layout for each screen number, in the order of #R$D800(their addresses). #R$B4D9 draws them.
N $D8DC Each record of a layout places one graphic at one cell, in three bytes.
N $D8DC #TABLE(default) { =h Byte | =h Bits | =h Content } { 1 | 0–7 | Number of the graphic, or $FF after the last record } { 2 | 0–4 | Column of the graphic's top-left cell, 0–31 } { 2 | 5–7 | Ink of the graphic, which draws bright on black paper, or 0 for white ink, not bright } { 3 | 0–4 | Row of the graphic's top-left cell, 0 for the top row of the play area } { 3 | 5–7 | For the animated graphic, the calls of #R$D41A(the animation step) that each frame lasts, less 2 } { 3 | 7 | 1 if the graphic repeats in a run to the cell of the next record } TABLE#
N $D8DC A run repeats its graphic across to the next record's column, or down to its row when the two records share a column (#R$B59E).
N $D8DC Each render shows the play area as the game draws the screen at the start of a game, before the Skimmer appears.
N $D8DC #UDGTABLE { #PUSHS #DRAWSCREEN(0,0,0)#SCR2,0,6,32,18(outer_screen_0)#POPS } { Screen 0 } TABLE#
B $D8DC,48,3
B $D90C,1 End of the layout
@ $D90D label=outer_layout_1
N $D90D #UDGTABLE { #PUSHS #DRAWSCREEN(1,0,0)#SCR2,0,6,32,18(outer_screen_1)#POPS } { Screen 1 } TABLE#
B $D90D,96,3
B $D96D,1 End of the layout
@ $D96E label=outer_layout_2
N $D96E #UDGTABLE { #PUSHS #DRAWSCREEN(2,0,0)#SCR2,0,6,32,18(outer_screen_2)#POPS } { Screen 2 } TABLE#
B $D96E,1 End of the layout
@ $D96F label=outer_layout_3
N $D96F #UDGTABLE { #PUSHS #DRAWSCREEN(3,0,0)#SCR2,0,6,32,18(outer_screen_3)#POPS } { Screen 3 } TABLE#
B $D96F,54,3
B $D9A5,1 End of the layout
@ $D9A6 label=outer_layout_4
N $D9A6 #UDGTABLE { #PUSHS #DRAWSCREEN(4,0,0)#SCR2,0,6,32,18(outer_screen_4)#POPS } { Screen 4 } TABLE#
B $D9A6,48,3
B $D9D6,1 End of the layout
@ $D9D7 label=outer_layout_5
N $D9D7 #UDGTABLE { #PUSHS #DRAWSCREEN(5,0,0)#SCR2,0,6,32,18(outer_screen_5)#POPS } { Screen 5 } TABLE#
B $D9D7,42,3
B $DA01,1 End of the layout
@ $DA02 label=outer_layout_6
N $DA02 #UDGTABLE { #PUSHS #DRAWSCREEN(6,0,0)#SCR2,0,6,32,18(outer_screen_6)#POPS } { Screen 6 } TABLE#
B $DA02,15,3
B $DA11,1 End of the layout
@ $DA12 label=outer_layout_7
N $DA12 #UDGTABLE { #PUSHS #DRAWSCREEN(7,0,0)#SCR2,0,6,32,18(outer_screen_7)#POPS } { Screen 7 } TABLE#
B $DA12,69,3
B $DA57,1 End of the layout
@ $DA58 label=outer_layout_8
N $DA58 #UDGTABLE { #PUSHS #DRAWSCREEN(8,0,0)#SCR2,0,6,32,18(outer_screen_8)#POPS } { Screen 8 } TABLE#
B $DA58,1 End of the layout
@ $DA59 label=outer_layout_9
N $DA59 #UDGTABLE { #PUSHS #DRAWSCREEN(9,0,0)#SCR2,0,6,32,18(outer_screen_9)#POPS } { Screen 9 } TABLE#
B $DA59,1 End of the layout
@ $DA5A label=outer_layout_10
N $DA5A #UDGTABLE { #PUSHS #DRAWSCREEN(0,1,0)#SCR2,0,6,32,18(outer_screen_10)#POPS } { Screen 10 } TABLE#
B $DA5A,54,3
B $DA90,1 End of the layout
@ $DA91 label=outer_layout_11
N $DA91 #UDGTABLE { #PUSHS #DRAWSCREEN(1,1,0)#SCR2,0,6,32,18(outer_screen_11)#POPS } { Screen 11 } TABLE#
B $DA91,54,3
B $DAC7,1 End of the layout
@ $DAC8 label=outer_layout_12
N $DAC8 #UDGTABLE { #PUSHS #DRAWSCREEN(2,1,0)#SCR2,0,6,32,18(outer_screen_12)#POPS } { Screen 12 } TABLE#
B $DAC8,54,3
B $DAFE,1 End of the layout
@ $DAFF label=outer_layout_13
N $DAFF #UDGTABLE { #PUSHS #DRAWSCREEN(3,1,0)#SCR2,0,6,32,18(outer_screen_13)#POPS } { Screen 13 } TABLE#
B $DAFF,39,3
B $DB26,1 End of the layout
@ $DB27 label=outer_layout_14
N $DB27 #UDGTABLE { #PUSHS #DRAWSCREEN(4,1,0)#SCR2,0,6,32,18(outer_screen_14)#POPS } { Screen 14 } TABLE#
B $DB27,21,3
B $DB3C,1 End of the layout
@ $DB3D label=outer_layout_15
N $DB3D #UDGTABLE { #PUSHS #DRAWSCREEN(5,1,0)#SCR2,0,6,32,18(outer_screen_15)#POPS } { Screen 15 } TABLE#
B $DB3D,21,3
B $DB52,1 End of the layout
@ $DB53 label=outer_layout_16
N $DB53 #UDGTABLE { #PUSHS #DRAWSCREEN(6,1,0)#SCR2,0,6,32,18(outer_screen_16)#POPS } { Screen 16 } TABLE#
B $DB53,21,3
B $DB68,1 End of the layout
@ $DB69 label=outer_layout_17
N $DB69 #UDGTABLE { #PUSHS #DRAWSCREEN(7,1,0)#SCR2,0,6,32,18(outer_screen_17)#POPS } { Screen 17 } TABLE#
B $DB69,51,3
B $DB9C,1 End of the layout
@ $DB9D label=outer_layout_18
N $DB9D #UDGTABLE { #PUSHS #DRAWSCREEN(8,1,0)#SCR2,0,6,32,18(outer_screen_18)#POPS } { Screen 18 } TABLE#
B $DB9D,1 End of the layout
@ $DB9E label=outer_layout_19
N $DB9E #UDGTABLE { #PUSHS #DRAWSCREEN(9,1,0)#SCR2,0,6,32,18(outer_screen_19)#POPS } { Screen 19 } TABLE#
B $DB9E,1 End of the layout
@ $DB9F label=outer_layout_20
N $DB9F #UDGTABLE { #PUSHS #DRAWSCREEN(0,2,0)#SCR2,0,6,32,18(outer_screen_20)#POPS } { Screen 20 } TABLE#
B $DB9F,45,3
B $DBCC,1 End of the layout
@ $DBCD label=outer_layout_21
N $DBCD #UDGTABLE { #PUSHS #DRAWSCREEN(1,2,0)#SCR2,0,6,32,18(outer_screen_21)#POPS } { Screen 21 } TABLE#
B $DBCD,84,3
B $DC21,1 End of the layout
@ $DC22 label=outer_layout_22
N $DC22 #UDGTABLE { #PUSHS #DRAWSCREEN(2,2,0)#SCR2,0,6,32,18(outer_screen_22)#POPS } { Screen 22 } TABLE#
B $DC22,45,3
B $DC4F,1 End of the layout
@ $DC50 label=outer_layout_23
N $DC50 #UDGTABLE { #PUSHS #DRAWSCREEN(3,2,0)#SCR2,0,6,32,18(outer_screen_23)#POPS } { Screen 23 } TABLE#
B $DC50,21,3
B $DC65,1 End of the layout
@ $DC66 label=outer_layout_24
N $DC66 #UDGTABLE { #PUSHS #DRAWSCREEN(4,2,0)#SCR2,0,6,32,18(outer_screen_24)#POPS } { Screen 24 } TABLE#
B $DC66,24,3
B $DC7E,1 End of the layout
@ $DC7F label=outer_layout_25
N $DC7F #UDGTABLE { #PUSHS #DRAWSCREEN(5,2,0)#SCR2,0,6,32,18(outer_screen_25)#POPS } { Screen 25 } TABLE#
B $DC7F,54,3
B $DCB5,1 End of the layout
@ $DCB6 label=outer_layout_26
N $DCB6 #UDGTABLE { #PUSHS #DRAWSCREEN(6,2,0)#SCR2,0,6,32,18(outer_screen_26)#POPS } { Screen 26 } TABLE#
B $DCB6,60,3
B $DCF2,1 End of the layout
@ $DCF3 label=outer_layout_27
N $DCF3 #UDGTABLE { #PUSHS #DRAWSCREEN(7,2,0)#SCR2,0,6,32,18(outer_screen_27)#POPS } { Screen 27 } TABLE#
B $DCF3,36,3
B $DD17,1 End of the layout
@ $DD18 label=outer_layout_28
N $DD18 #UDGTABLE { #PUSHS #DRAWSCREEN(8,2,0)#SCR2,0,6,32,18(outer_screen_28)#POPS } { Screen 28 } TABLE#
B $DD18,1 End of the layout
@ $DD19 label=outer_layout_29
N $DD19 #UDGTABLE { #PUSHS #DRAWSCREEN(9,2,0)#SCR2,0,6,32,18(outer_screen_29)#POPS } { Screen 29 } TABLE#
B $DD19,1 End of the layout
@ $DD1A label=outer_layout_30
N $DD1A #UDGTABLE { #PUSHS #DRAWSCREEN(0,3,0)#SCR2,0,6,32,18(outer_screen_30)#POPS } { Screen 30 } TABLE#
B $DD1A,51,3
B $DD4D,1 End of the layout
@ $DD4E label=outer_layout_31
N $DD4E #UDGTABLE { #PUSHS #DRAWSCREEN(1,3,0)#SCR2,0,6,32,18(outer_screen_31)#POPS } { Screen 31 } TABLE#
B $DD4E,72,3
B $DD96,1 End of the layout
@ $DD97 label=outer_layout_32
N $DD97 #UDGTABLE { #PUSHS #DRAWSCREEN(2,3,0)#SCR2,0,6,32,18(outer_screen_32)#POPS } { Screen 32 } TABLE#
B $DD97,42,3
B $DDC1,1 End of the layout
@ $DDC2 label=outer_layout_33
N $DDC2 #UDGTABLE { #PUSHS #DRAWSCREEN(3,3,0)#SCR2,0,6,32,18(outer_screen_33)#POPS } { Screen 33 } TABLE#
B $DDC2,54,3
B $DDF8,1 End of the layout
@ $DDF9 label=outer_layout_34
N $DDF9 #UDGTABLE { #PUSHS #DRAWSCREEN(4,3,0)#SCR2,0,6,32,18(outer_screen_34)#POPS } { Screen 34 } TABLE#
B $DDF9,54,3
B $DE2F,1 End of the layout
@ $DE30 label=outer_layout_35
N $DE30 #UDGTABLE { #PUSHS #DRAWSCREEN(5,3,0)#SCR2,0,6,32,18(outer_screen_35)#POPS } { Screen 35 } TABLE#
B $DE30,45,3
B $DE5D,1 End of the layout
@ $DE5E label=outer_layout_36
N $DE5E #UDGTABLE { #PUSHS #DRAWSCREEN(6,3,0)#SCR2,0,6,32,18(outer_screen_36)#POPS } { Screen 36 } TABLE#
B $DE5E,63,3
B $DE9D,1 End of the layout
@ $DE9E label=outer_layout_37
N $DE9E #UDGTABLE { #PUSHS #DRAWSCREEN(7,3,0)#SCR2,0,6,32,18(outer_screen_37)#POPS } { Screen 37 } TABLE#
B $DE9E,24,3
B $DEB6,1 End of the layout
@ $DEB7 label=outer_layout_38
N $DEB7 #UDGTABLE { #PUSHS #DRAWSCREEN(8,3,0)#SCR2,0,6,32,18(outer_screen_38)#POPS } { Screen 38 } TABLE#
B $DEB7,1 End of the layout
@ $DEB8 label=outer_layout_39
N $DEB8 #UDGTABLE { #PUSHS #DRAWSCREEN(9,3,0)#SCR2,0,6,32,18(outer_screen_39)#POPS } { Screen 39 } TABLE#
B $DEB8,1 End of the layout
@ $DEB9 label=outer_layout_40
N $DEB9 #UDGTABLE { #PUSHS #DRAWSCREEN(0,4,0)#SCR2,0,6,32,18(outer_screen_40)#POPS } { Screen 40 } TABLE#
B $DEB9,36,3
B $DEDD,1 End of the layout
@ $DEDE label=outer_layout_41
N $DEDE #UDGTABLE { #PUSHS #DRAWSCREEN(1,4,0)#SCR2,0,6,32,18(outer_screen_41)#POPS } { Screen 41 } TABLE#
B $DEDE,57,3
B $DF17,1 End of the layout
@ $DF18 label=outer_layout_42
N $DF18 #UDGTABLE { #PUSHS #DRAWSCREEN(2,4,0)#SCR2,0,6,32,18(outer_screen_42)#POPS } { Screen 42 } TABLE#
B $DF18,78,3
B $DF66,1 End of the layout
@ $DF67 label=outer_layout_43
N $DF67 #UDGTABLE { #PUSHS #DRAWSCREEN(3,4,0)#SCR2,0,6,32,18(outer_screen_43)#POPS } { Screen 43 } TABLE#
B $DF67,78,3
B $DFB5,1 End of the layout
@ $DFB6 label=outer_layout_44
N $DFB6 #UDGTABLE { #PUSHS #DRAWSCREEN(4,4,0)#SCR2,0,6,32,18(outer_screen_44)#POPS } { Screen 44 } TABLE#
B $DFB6,45,3
B $DFE3,1 End of the layout
@ $DFE4 label=outer_layout_45
N $DFE4 #UDGTABLE { #PUSHS #DRAWSCREEN(5,4,0)#SCR2,0,6,32,18(outer_screen_45)#POPS } { Screen 45 } TABLE#
B $DFE4,48,3
B $E014,1 End of the layout
@ $E015 label=outer_layout_46
N $E015 #UDGTABLE { #PUSHS #DRAWSCREEN(6,4,0)#SCR2,0,6,32,18(outer_screen_46)#POPS } { Screen 46 } TABLE#
B $E015,60,3
B $E051,1 End of the layout
@ $E052 label=outer_layout_47
N $E052 #UDGTABLE { #PUSHS #DRAWSCREEN(7,4,0)#SCR2,0,6,32,18(outer_screen_47)#POPS } { Screen 47 } TABLE#
B $E052,57,3
B $E08B,1 End of the layout
@ $E08C label=outer_layout_48
N $E08C #UDGTABLE { #PUSHS #DRAWSCREEN(8,4,0)#SCR2,0,6,32,18(outer_screen_48)#POPS } { Screen 48 } TABLE#
B $E08C,1 End of the layout
@ $E08D label=outer_layout_49
N $E08D #UDGTABLE { #PUSHS #DRAWSCREEN(9,4,0)#SCR2,0,6,32,18(outer_screen_49)#POPS } { Screen 49 } TABLE#
B $E08D,1 End of the layout
@ $E08E label=outer_layout_50
N $E08E #UDGTABLE { #PUSHS #DRAWSCREEN(0,5,0)#SCR2,0,6,32,18(outer_screen_50)#POPS } { Screen 50 } TABLE#
B $E08E,33,3
B $E0AF,1 End of the layout
@ $E0B0 label=outer_layout_51
N $E0B0 #UDGTABLE { #PUSHS #DRAWSCREEN(1,5,0)#SCR2,0,6,32,18(outer_screen_51)#POPS } { Screen 51 } TABLE#
B $E0B0,27,3
B $E0CB,1 End of the layout
@ $E0CC label=outer_layout_52
N $E0CC #UDGTABLE { #PUSHS #DRAWSCREEN(2,5,0)#SCR2,0,6,32,18(outer_screen_52)#POPS } { Screen 52 } TABLE#
B $E0CC,57,3
B $E105,1 End of the layout
@ $E106 label=outer_layout_53
N $E106 #UDGTABLE { #PUSHS #DRAWSCREEN(3,5,0)#SCR2,0,6,32,18(outer_screen_53)#POPS } { Screen 53 } TABLE#
B $E106,18,3
B $E118,1 End of the layout
@ $E119 label=outer_layout_54
N $E119 #UDGTABLE { #PUSHS #DRAWSCREEN(4,5,0)#SCR2,0,6,32,18(outer_screen_54)#POPS } { Screen 54 } TABLE#
B $E119,24,3
B $E131,1 End of the layout
@ $E132 label=outer_layout_55
N $E132 BUG: the last record starts a run, so the run takes its end column from #R$E145(the next screen's layout). The graphic draws once. The shadow switch keeps that column, so the graphic casts no shadow, and the cell below its right half stays unshaded.
N $E132 #UDGTABLE { #PUSHS #DRAWSCREEN(5,5,0)#SCR2,0,6,32,18(outer_screen_55)#POPS } { Screen 55 } TABLE#
B $E132,18,3
B $E144,1 End of the layout
@ $E145 label=outer_layout_56
N $E145 #UDGTABLE { #PUSHS #DRAWSCREEN(6,5,0)#SCR2,0,6,32,18(outer_screen_56)#POPS } { Screen 56 } TABLE#
B $E145,30,3
B $E163,1 End of the layout
@ $E164 label=outer_layout_57
N $E164 #UDGTABLE { #PUSHS #DRAWSCREEN(7,5,0)#SCR2,0,6,32,18(outer_screen_57)#POPS } { Screen 57 } TABLE#
B $E164,33,3
B $E185,1 End of the layout
@ $E186 label=outer_layout_58
N $E186 #UDGTABLE { #PUSHS #DRAWSCREEN(8,5,0)#SCR2,0,6,32,18(outer_screen_58)#POPS } { Screen 58 } TABLE#
B $E186,12,3
B $E192,1 End of the layout
@ $E193 label=outer_layout_59
N $E193 #UDGTABLE { #PUSHS #DRAWSCREEN(9,5,0)#SCR2,0,6,32,18(outer_screen_59)#POPS } { Screen 59 } TABLE#
B $E193,6,3
B $E199,1 End of the layout
@ $E19A label=outer_layout_60
N $E19A #UDGTABLE { #PUSHS #DRAWSCREEN(0,6,0)#SCR2,0,6,32,18(outer_screen_60)#POPS } { Screen 60 } TABLE#
B $E19A,33,3
B $E1BB,1 End of the layout
@ $E1BC label=outer_layout_61
N $E1BC #UDGTABLE { #PUSHS #DRAWSCREEN(1,6,0)#SCR2,0,6,32,18(outer_screen_61)#POPS } { Screen 61 } TABLE#
B $E1BC,57,3
B $E1F5,1 End of the layout
@ $E1F6 label=outer_layout_62
N $E1F6 #UDGTABLE { #PUSHS #DRAWSCREEN(2,6,0)#SCR2,0,6,32,18(outer_screen_62)#POPS } { Screen 62 } TABLE#
B $E1F6,81,3
B $E247,1 End of the layout
@ $E248 label=outer_layout_63
N $E248 #UDGTABLE { #PUSHS #DRAWSCREEN(3,6,0)#SCR2,0,6,32,18(outer_screen_63)#POPS } { Screen 63 } TABLE#
B $E248,60,3
B $E284,1 End of the layout
@ $E285 label=outer_layout_64
N $E285 #UDGTABLE { #PUSHS #DRAWSCREEN(4,6,0)#SCR2,0,6,32,18(outer_screen_64)#POPS } { Screen 64 } TABLE#
B $E285,36,3
B $E2A9,1 End of the layout
@ $E2AA label=outer_layout_65
N $E2AA #UDGTABLE { #PUSHS #DRAWSCREEN(5,6,0)#SCR2,0,6,32,18(outer_screen_65)#POPS } { Screen 65 } TABLE#
B $E2AA,30,3
B $E2C8,1 End of the layout
@ $E2C9 label=outer_layout_66
N $E2C9 #UDGTABLE { #PUSHS #DRAWSCREEN(6,6,0)#SCR2,0,6,32,18(outer_screen_66)#POPS } { Screen 66 } TABLE#
B $E2C9,48,3
B $E2F9,1 End of the layout
@ $E2FA label=outer_layout_67
N $E2FA #UDGTABLE { #PUSHS #DRAWSCREEN(7,6,0)#SCR2,0,6,32,18(outer_screen_67)#POPS } { Screen 67 } TABLE#
B $E2FA,39,3
B $E321,1 End of the layout
@ $E322 label=outer_layout_68
N $E322 #UDGTABLE { #PUSHS #DRAWSCREEN(8,6,0)#SCR2,0,6,32,18(outer_screen_68)#POPS } { Screen 68 } TABLE#
B $E322,1 End of the layout
@ $E323 label=outer_layout_69
N $E323 #UDGTABLE { #PUSHS #DRAWSCREEN(9,6,0)#SCR2,0,6,32,18(outer_screen_69)#POPS } { Screen 69 } TABLE#
B $E323,6,3
B $E329,1 End of the layout
@ $E32A label=outer_layout_70
N $E32A #UDGTABLE { #PUSHS #DRAWSCREEN(0,7,0)#SCR2,0,6,32,18(outer_screen_70)#POPS } { Screen 70 } TABLE#
B $E32A,57,3
B $E363,1 End of the layout
@ $E364 label=outer_layout_71
N $E364 #UDGTABLE { #PUSHS #DRAWSCREEN(1,7,0)#SCR2,0,6,32,18(outer_screen_71)#POPS } { Screen 71 } TABLE#
B $E364,84,3
B $E3B8,1 End of the layout
@ $E3B9 label=outer_layout_72
N $E3B9 #UDGTABLE { #PUSHS #DRAWSCREEN(2,7,0)#SCR2,0,6,32,18(outer_screen_72)#POPS } { Screen 72 } TABLE#
B $E3B9,60,3
B $E3F5,1 End of the layout
@ $E3F6 label=outer_layout_73
N $E3F6 #UDGTABLE { #PUSHS #DRAWSCREEN(3,7,0)#SCR2,0,6,32,18(outer_screen_73)#POPS } { Screen 73 } TABLE#
B $E3F6,69,3
B $E43B,1 End of the layout
@ $E43C label=outer_layout_74
N $E43C #UDGTABLE { #PUSHS #DRAWSCREEN(4,7,0)#SCR2,0,6,32,18(outer_screen_74)#POPS } { Screen 74 } TABLE#
B $E43C,39,3
B $E463,1 End of the layout
@ $E464 label=outer_layout_75
N $E464 #UDGTABLE { #PUSHS #DRAWSCREEN(5,7,0)#SCR2,0,6,32,18(outer_screen_75)#POPS } { Screen 75 } TABLE#
B $E464,21,3
B $E479,1 End of the layout
@ $E47A label=outer_layout_76
N $E47A #UDGTABLE { #PUSHS #DRAWSCREEN(6,7,0)#SCR2,0,6,32,18(outer_screen_76)#POPS } { Screen 76 } TABLE#
B $E47A,12,3
B $E486,1 End of the layout
@ $E487 label=outer_layout_77
N $E487 #UDGTABLE { #PUSHS #DRAWSCREEN(7,7,0)#SCR2,0,6,32,18(outer_screen_77)#POPS } { Screen 77 } TABLE#
B $E487,33,3
B $E4A8,1 End of the layout
@ $E4A9 label=outer_layout_78
N $E4A9 #UDGTABLE { #PUSHS #DRAWSCREEN(8,7,0)#SCR2,0,6,32,18(outer_screen_78)#POPS } { Screen 78 } TABLE#
B $E4A9,1 End of the layout
@ $E4AA label=outer_layout_79
N $E4AA #UDGTABLE { #PUSHS #DRAWSCREEN(9,7,0)#SCR2,0,6,32,18(outer_screen_79)#POPS } { Screen 79 } TABLE#
B $E4AA,6,3
B $E4B0,1 End of the layout
@ $E4B1 label=outer_layout_80
N $E4B1 #UDGTABLE { #PUSHS #DRAWSCREEN(0,8,0)#SCR2,0,6,32,18(outer_screen_80)#POPS } { Screen 80 } TABLE#
B $E4B1,51,3
B $E4E4,1 End of the layout
@ $E4E5 label=outer_layout_81
N $E4E5 #UDGTABLE { #PUSHS #DRAWSCREEN(1,8,0)#SCR2,0,6,32,18(outer_screen_81)#POPS } { Screen 81 } TABLE#
B $E4E5,69,3
B $E52A,1 End of the layout
@ $E52B label=outer_layout_82
N $E52B #UDGTABLE { #PUSHS #DRAWSCREEN(2,8,0)#SCR2,0,6,32,18(outer_screen_82)#POPS } { Screen 82 } TABLE#
B $E52B,57,3
B $E564,1 End of the layout
@ $E565 label=outer_layout_83
N $E565 #UDGTABLE { #PUSHS #DRAWSCREEN(3,8,0)#SCR2,0,6,32,18(outer_screen_83)#POPS } { Screen 83 } TABLE#
B $E565,57,3
B $E59E,1 End of the layout
@ $E59F label=outer_layout_84
N $E59F #UDGTABLE { #PUSHS #DRAWSCREEN(4,8,0)#SCR2,0,6,32,18(outer_screen_84)#POPS } { Screen 84 } TABLE#
B $E59F,87,3
B $E5F6,1 End of the layout
@ $E5F7 label=outer_layout_85
N $E5F7 #UDGTABLE { #PUSHS #DRAWSCREEN(5,8,0)#SCR2,0,6,32,18(outer_screen_85)#POPS } { Screen 85 } TABLE#
B $E5F7,18,3
B $E609,1 End of the layout
@ $E60A label=outer_layout_86
N $E60A #UDGTABLE { #PUSHS #DRAWSCREEN(6,8,0)#SCR2,0,6,32,18(outer_screen_86)#POPS } { Screen 86 } TABLE#
B $E60A,39,3
B $E631,1 End of the layout
@ $E632 label=outer_layout_87
N $E632 #UDGTABLE { #PUSHS #DRAWSCREEN(7,8,0)#SCR2,0,6,32,18(outer_screen_87)#POPS } { Screen 87 } TABLE#
B $E632,69,3
B $E677,1 End of the layout
@ $E678 label=outer_layout_88
N $E678 #UDGTABLE { #PUSHS #DRAWSCREEN(8,8,0)#SCR2,0,6,32,18(outer_screen_88)#POPS } { Screen 88 } TABLE#
B $E678,1 End of the layout
@ $E679 label=outer_layout_89
N $E679 #UDGTABLE { #PUSHS #DRAWSCREEN(9,8,0)#SCR2,0,6,32,18(outer_screen_89)#POPS } { Screen 89 } TABLE#
B $E679,6,3
B $E67F,1 End of the layout
@ $E680 label=outer_layout_90
N $E680 #UDGTABLE { #PUSHS #DRAWSCREEN(0,9,0)#SCR2,0,6,32,18(outer_screen_90)#POPS } { Screen 90 } TABLE#
B $E680,27,3
B $E69B,1 End of the layout
@ $E69C label=outer_layout_91
N $E69C #UDGTABLE { #PUSHS #DRAWSCREEN(1,9,0)#SCR2,0,6,32,18(outer_screen_91)#POPS } { Screen 91 } TABLE#
B $E69C,48,3
B $E6CC,1 End of the layout
@ $E6CD label=outer_layout_92
N $E6CD #UDGTABLE { #PUSHS #DRAWSCREEN(2,9,0)#SCR2,0,6,32,18(outer_screen_92)#POPS } { Screen 92 } TABLE#
B $E6CD,78,3
B $E71B,1 End of the layout
@ $E71C label=outer_layout_93
N $E71C #UDGTABLE { #PUSHS #DRAWSCREEN(3,9,0)#SCR2,0,6,32,18(outer_screen_93)#POPS } { Screen 93 } TABLE#
B $E71C,60,3
B $E758,1 End of the layout
@ $E759 label=outer_layout_94
N $E759 #UDGTABLE { #PUSHS #DRAWSCREEN(4,9,0)#SCR2,0,6,32,18(outer_screen_94)#POPS } { Screen 94 } TABLE#
B $E759,54,3
B $E78F,1 End of the layout
@ $E790 label=outer_layout_95
N $E790 #UDGTABLE { #PUSHS #DRAWSCREEN(5,9,0)#SCR2,0,6,32,18(outer_screen_95)#POPS } { Screen 95 } TABLE#
B $E790,33,3
B $E7B1,1 End of the layout
@ $E7B2 label=outer_layout_96
N $E7B2 #UDGTABLE { #PUSHS #DRAWSCREEN(6,9,0)#SCR2,0,6,32,18(outer_screen_96)#POPS } { Screen 96 } TABLE#
B $E7B2,57,3
B $E7EB,1 End of the layout
@ $E7EC label=outer_layout_97
N $E7EC #UDGTABLE { #PUSHS #DRAWSCREEN(7,9,0)#SCR2,0,6,32,18(outer_screen_97)#POPS } { Screen 97 } TABLE#
B $E7EC,63,3
B $E82B,1 End of the layout
@ $E82C label=outer_layout_98
N $E82C #UDGTABLE { #PUSHS #DRAWSCREEN(8,9,0)#SCR2,0,6,32,18(outer_screen_98)#POPS } { Screen 98 } TABLE#
B $E82C,1 End of the layout
@ $E82D label=outer_layout_99
N $E82D #UDGTABLE { #PUSHS #DRAWSCREEN(9,9,0)#SCR2,0,6,32,18(outer_screen_99)#POPS } { Screen 99 } TABLE#
B $E82D,6,3
B $E833,1 End of the layout
@ $E834 label=outer_layout_100
N $E834 #UDGTABLE { #PUSHS #DRAWSCREEN(0,10,0)#SCR2,0,6,32,18(outer_screen_100)#POPS } { Screen 100 } TABLE#
B $E834,66,3
B $E876,1 End of the layout
@ $E877 label=outer_layout_101
N $E877 #UDGTABLE { #PUSHS #DRAWSCREEN(1,10,0)#SCR2,0,6,32,18(outer_screen_101)#POPS } { Screen 101 } TABLE#
B $E877,60,3
B $E8B3,1 End of the layout
@ $E8B4 label=outer_layout_102
N $E8B4 #UDGTABLE { #PUSHS #DRAWSCREEN(2,10,0)#SCR2,0,6,32,18(outer_screen_102)#POPS } { Screen 102 } TABLE#
B $E8B4,6,3
B $E8BA,1 End of the layout
@ $E8BB label=outer_layout_103
N $E8BB #UDGTABLE { #PUSHS #DRAWSCREEN(3,10,0)#SCR2,0,6,32,18(outer_screen_103)#POPS } { Screen 103 } TABLE#
B $E8BB,48,3
B $E8EB,1 End of the layout
@ $E8EC label=outer_layout_104
N $E8EC #UDGTABLE { #PUSHS #DRAWSCREEN(4,10,0)#SCR2,0,6,32,18(outer_screen_104)#POPS } { Screen 104 } TABLE#
B $E8EC,69,3
B $E931,1 End of the layout
@ $E932 label=outer_layout_105
N $E932 #UDGTABLE { #PUSHS #DRAWSCREEN(5,10,0)#SCR2,0,6,32,18(outer_screen_105)#POPS } { Screen 105 } TABLE#
B $E932,48,3
B $E962,1 End of the layout
@ $E963 label=outer_layout_106
N $E963 #UDGTABLE { #PUSHS #DRAWSCREEN(6,10,0)#SCR2,0,6,32,18(outer_screen_106)#POPS } { Screen 106 } TABLE#
B $E963,60,3
B $E99F,1 End of the layout
@ $E9A0 label=outer_layout_107
N $E9A0 #UDGTABLE { #PUSHS #DRAWSCREEN(7,10,0)#SCR2,0,6,32,18(outer_screen_107)#POPS } { Screen 107 } TABLE#
B $E9A0,33,3
B $E9C1,1 End of the layout
@ $E9C2 label=outer_layout_108
N $E9C2 #UDGTABLE { #PUSHS #DRAWSCREEN(8,10,0)#SCR2,0,6,32,18(outer_screen_108)#POPS } { Screen 108 } TABLE#
B $E9C2,6,3
B $E9C8,1 End of the layout
@ $E9C9 label=outer_layout_109
N $E9C9 #UDGTABLE { #PUSHS #DRAWSCREEN(9,10,0)#SCR2,0,6,32,18(outer_screen_109)#POPS } { Screen 109 } TABLE#
B $E9C9,12,3
B $E9D5,1 End of the layout
u $E9D6 Unused bytes
@ $EA00 label=inner_layout_addrs
w $EA00 Inner section layout addresses
D $EA00 The address of the #R$EADC(layout) of each inner section screen, one word per screen number.
@ $EADC label=inner_layout_0
b $EADC Inner section screen layouts
D $EADC The graphics on each screen of the inner sections, one layout for each screen number, in the order of #R$EA00(their addresses). The records take the form of #R$D8DC(the outer hull layouts), with graphic numbers from #R$A818(the inner section directory).
N $EADC The renders show each screen as at #R$D8DC(the outer hull layouts).
B $EADC,1 End of the layout
@ $EADD label=inner_layout_1
B $EADD,1 End of the layout
@ $EADE label=inner_layout_2
B $EADE,1 End of the layout
@ $EADF label=inner_layout_3
B $EADF,1 End of the layout
@ $EAE0 label=inner_layout_4
B $EAE0,1 End of the layout
@ $EAE1 label=inner_layout_5
N $EAE1 #UDGTABLE { #PUSHS #DRAWSCREEN(5,0,1)#SCR2,0,6,32,18(inner_screen_5)#POPS } { Screen 5, WALL DONE } TABLE#
B $EAE1,1 End of the layout
@ $EAE2 label=inner_layout_6
N $EAE2 #UDGTABLE { #PUSHS #DRAWSCREEN(6,0,1)#SCR2,0,6,32,18(inner_screen_6)#POPS } { Screen 6 } TABLE#
B $EAE2,33,3
B $EB03,1 End of the layout
@ $EB04 label=inner_layout_7
N $EB04 #UDGTABLE { #PUSHS #DRAWSCREEN(7,0,1)#SCR2,0,6,32,18(inner_screen_7)#POPS } { Screen 7 } TABLE#
B $EB04,33,3
B $EB25,1 End of the layout
@ $EB26 label=inner_layout_8
N $EB26 #UDGTABLE { #PUSHS #DRAWSCREEN(8,0,1)#SCR2,0,6,32,18(inner_screen_8)#POPS } { Screen 8 } TABLE#
B $EB26,18,3
B $EB38,1 End of the layout
@ $EB39 label=inner_layout_9
B $EB39,1 End of the layout
@ $EB3A label=inner_layout_10
B $EB3A,1 End of the layout
@ $EB3B label=inner_layout_11
B $EB3B,1 End of the layout
@ $EB3C label=inner_layout_12
B $EB3C,1 End of the layout
@ $EB3D label=inner_layout_13
B $EB3D,1 End of the layout
@ $EB3E label=inner_layout_14
B $EB3E,1 End of the layout
@ $EB3F label=inner_layout_15
B $EB3F,1 End of the layout
@ $EB40 label=inner_layout_16
B $EB40,1 End of the layout
@ $EB41 label=inner_layout_17
B $EB41,1 End of the layout
@ $EB42 label=inner_layout_18
B $EB42,1 End of the layout
@ $EB43 label=inner_layout_19
B $EB43,1 End of the layout
@ $EB44 label=inner_layout_20
B $EB44,1 End of the layout
@ $EB45 label=inner_layout_21
B $EB45,1 End of the layout
@ $EB46 label=inner_layout_22
B $EB46,1 End of the layout
@ $EB47 label=inner_layout_23
B $EB47,1 End of the layout
@ $EB48 label=inner_layout_24
B $EB48,1 End of the layout
@ $EB49 label=inner_layout_25
B $EB49,1 End of the layout
@ $EB4A label=inner_layout_26
B $EB4A,1 End of the layout
@ $EB4B label=inner_layout_27
B $EB4B,1 End of the layout
@ $EB4C label=inner_layout_28
B $EB4C,1 End of the layout
@ $EB4D label=inner_layout_29
B $EB4D,1 End of the layout
@ $EB4E label=inner_layout_30
B $EB4E,1 End of the layout
@ $EB4F label=inner_layout_31
B $EB4F,1 End of the layout
@ $EB50 label=inner_layout_32
B $EB50,1 End of the layout
@ $EB51 label=inner_layout_33
B $EB51,1 End of the layout
@ $EB52 label=inner_layout_34
B $EB52,1 End of the layout
@ $EB53 label=inner_layout_35
B $EB53,1 End of the layout
@ $EB54 label=inner_layout_36
B $EB54,1 End of the layout
@ $EB55 label=inner_layout_37
B $EB55,1 End of the layout
@ $EB56 label=inner_layout_38
B $EB56,1 End of the layout
@ $EB57 label=inner_layout_39
B $EB57,1 End of the layout
@ $EB58 label=inner_layout_40
B $EB58,1 End of the layout
@ $EB59 label=inner_layout_41
B $EB59,1 End of the layout
@ $EB5A label=inner_layout_42
B $EB5A,1 End of the layout
@ $EB5B label=inner_layout_43
B $EB5B,1 End of the layout
@ $EB5C label=inner_layout_44
B $EB5C,1 End of the layout
@ $EB5D label=inner_layout_45
B $EB5D,1 End of the layout
@ $EB5E label=inner_layout_46
B $EB5E,1 End of the layout
@ $EB5F label=inner_layout_47
B $EB5F,1 End of the layout
@ $EB60 label=inner_layout_48
B $EB60,1 End of the layout
@ $EB61 label=inner_layout_49
B $EB61,1 End of the layout
@ $EB62 label=inner_layout_50
N $EB62 #UDGTABLE { #PUSHS #DRAWSCREEN(0,5,1)#SCR2,0,6,32,18(inner_screen_50)#POPS } { Screen 50 } TABLE#
B $EB62,15,3
B $EB71,1 End of the layout
@ $EB72 label=inner_layout_51
N $EB72 #UDGTABLE { #PUSHS #DRAWSCREEN(1,5,1)#SCR2,0,6,32,18(inner_screen_51)#POPS } { Screen 51 } TABLE#
B $EB72,30,3
B $EB90,1 End of the layout
@ $EB91 label=inner_layout_52
N $EB91 #UDGTABLE { #PUSHS #DRAWSCREEN(2,5,1)#SCR2,0,6,32,18(inner_screen_52)#POPS } { Screen 52 } TABLE#
B $EB91,45,3
B $EBBE,1 End of the layout
@ $EBBF label=inner_layout_53
N $EBBF #UDGTABLE { #PUSHS #DRAWSCREEN(3,5,1)#SCR2,0,6,32,18(inner_screen_53)#POPS } { Screen 53 } TABLE#
B $EBBF,39,3
B $EBE6,1 End of the layout
@ $EBE7 label=inner_layout_54
N $EBE7 #UDGTABLE { #PUSHS #DRAWSCREEN(4,5,1)#SCR2,0,6,32,18(inner_screen_54)#POPS } { Screen 54 } TABLE#
B $EBE7,42,3
B $EC11,1 End of the layout
@ $EC12 label=inner_layout_55
N $EC12 #UDGTABLE { #PUSHS #DRAWSCREEN(5,5,1)#SCR2,0,6,32,18(inner_screen_55)#POPS } { Screen 55 } TABLE#
B $EC12,45,3
B $EC3F,1 End of the layout
@ $EC40 label=inner_layout_56
N $EC40 #UDGTABLE { #PUSHS #DRAWSCREEN(6,5,1)#SCR2,0,6,32,18(inner_screen_56)#POPS } { Screen 56 } TABLE#
B $EC40,48,3
B $EC70,1 End of the layout
@ $EC71 label=inner_layout_57
B $EC71,1 End of the layout
@ $EC72 label=inner_layout_58
B $EC72,1 End of the layout
@ $EC73 label=inner_layout_59
B $EC73,1 End of the layout
@ $EC74 label=inner_layout_60
N $EC74 #UDGTABLE { #PUSHS #DRAWSCREEN(0,6,1)#SCR2,0,6,32,18(inner_screen_60)#POPS } { Screen 60 } TABLE#
B $EC74,30,3
B $EC92,1 End of the layout
@ $EC93 label=inner_layout_61
N $EC93 #UDGTABLE { #PUSHS #DRAWSCREEN(1,6,1)#SCR2,0,6,32,18(inner_screen_61)#POPS } { Screen 61 } TABLE#
B $EC93,18,3
B $ECA5,1 End of the layout
@ $ECA6 label=inner_layout_62
N $ECA6 #UDGTABLE { #PUSHS #DRAWSCREEN(2,6,1)#SCR2,0,6,32,18(inner_screen_62)#POPS } { Screen 62 } TABLE#
B $ECA6,18,3
B $ECB8,1 End of the layout
@ $ECB9 label=inner_layout_63
B $ECB9,1 End of the layout
@ $ECBA label=inner_layout_64
N $ECBA #UDGTABLE { #PUSHS #DRAWSCREEN(4,6,1)#SCR2,0,6,32,18(inner_screen_64)#POPS } { Screen 64 } TABLE#
B $ECBA,21,3
B $ECCF,1 End of the layout
@ $ECD0 label=inner_layout_65
N $ECD0 #UDGTABLE { #PUSHS #DRAWSCREEN(5,6,1)#SCR2,0,6,32,18(inner_screen_65)#POPS } { Screen 65 } TABLE#
B $ECD0,51,3
B $ED03,1 End of the layout
@ $ED04 label=inner_layout_66
N $ED04 #UDGTABLE { #PUSHS #DRAWSCREEN(6,6,1)#SCR2,0,6,32,18(inner_screen_66)#POPS } { Screen 66 } TABLE#
B $ED04,54,3
B $ED3A,1 End of the layout
@ $ED3B label=inner_layout_67
N $ED3B #UDGTABLE { #PUSHS #DRAWSCREEN(7,6,1)#SCR2,0,6,32,18(inner_screen_67)#POPS } { Screen 67 } TABLE#
B $ED3B,24,3
B $ED53,1 End of the layout
@ $ED54 label=inner_layout_68
B $ED54,1 End of the layout
@ $ED55 label=inner_layout_69
B $ED55,1 End of the layout
@ $ED56 label=inner_layout_70
N $ED56 #UDGTABLE { #PUSHS #DRAWSCREEN(0,7,1)#SCR2,0,6,32,18(inner_screen_70)#POPS } { Screen 70 } TABLE#
B $ED56,30,3
B $ED74,1 End of the layout
@ $ED75 label=inner_layout_71
N $ED75 #UDGTABLE { #PUSHS #DRAWSCREEN(1,7,1)#SCR2,0,6,32,18(inner_screen_71)#POPS } { Screen 71 } TABLE#
B $ED75,15,3
B $ED84,1 End of the layout
@ $ED85 label=inner_layout_72
B $ED85,1 End of the layout
@ $ED86 label=inner_layout_73
B $ED86,1 End of the layout
@ $ED87 label=inner_layout_74
N $ED87 #UDGTABLE { #PUSHS #DRAWSCREEN(4,7,1)#SCR2,0,6,32,18(inner_screen_74)#POPS } { Screen 74 } TABLE#
B $ED87,30,3
B $EDA5,1 End of the layout
@ $EDA6 label=inner_layout_75
N $EDA6 #UDGTABLE { #PUSHS #DRAWSCREEN(5,7,1)#SCR2,0,6,32,18(inner_screen_75)#POPS } { Screen 75 } TABLE#
B $EDA6,27,3
B $EDC1,1 End of the layout
@ $EDC2 label=inner_layout_76
N $EDC2 #UDGTABLE { #PUSHS #DRAWSCREEN(6,7,1)#SCR2,0,6,32,18(inner_screen_76)#POPS } { Screen 76 } TABLE#
B $EDC2,27,3
B $EDDD,1 End of the layout
@ $EDDE label=inner_layout_77
B $EDDE,1 End of the layout
@ $EDDF label=inner_layout_78
B $EDDF,1 End of the layout
@ $EDE0 label=inner_layout_79
B $EDE0,1 End of the layout
@ $EDE1 label=inner_layout_80
B $EDE1,1 End of the layout
@ $EDE2 label=inner_layout_81
B $EDE2,1 End of the layout
@ $EDE3 label=inner_layout_82
B $EDE3,1 End of the layout
@ $EDE4 label=inner_layout_83
B $EDE4,1 End of the layout
@ $EDE5 label=inner_layout_84
N $EDE5 #UDGTABLE { #PUSHS #DRAWSCREEN(4,8,1)#SCR2,0,6,32,18(inner_screen_84)#POPS } { Screen 84 } TABLE#
B $EDE5,30,3
B $EE03,1 End of the layout
@ $EE04 label=inner_layout_85
B $EE04,1 End of the layout
@ $EE05 label=inner_layout_86
B $EE05,1 End of the layout
@ $EE06 label=inner_layout_87
B $EE06,1 End of the layout
@ $EE07 label=inner_layout_88
B $EE07,1 End of the layout
@ $EE08 label=inner_layout_89
B $EE08,1 End of the layout
@ $EE09 label=inner_layout_90
B $EE09,1 End of the layout
@ $EE0A label=inner_layout_91
N $EE0A #UDGTABLE { #PUSHS #DRAWSCREEN(1,9,1)#SCR2,0,6,32,18(inner_screen_91)#POPS } { Screen 91 } TABLE#
B $EE0A,69,3
B $EE4F,1 End of the layout
@ $EE50 label=inner_layout_92
N $EE50 #UDGTABLE { #PUSHS #DRAWSCREEN(2,9,1)#SCR2,0,6,32,18(inner_screen_92)#POPS } { Screen 92 } TABLE#
B $EE50,42,3
B $EE7A,1 End of the layout
@ $EE7B label=inner_layout_93
B $EE7B,1 End of the layout
@ $EE7C label=inner_layout_94
B $EE7C,1 End of the layout
@ $EE7D label=inner_layout_95
B $EE7D,1 End of the layout
@ $EE7E label=inner_layout_96
B $EE7E,1 End of the layout
@ $EE7F label=inner_layout_97
B $EE7F,1 End of the layout
@ $EE80 label=inner_layout_98
B $EE80,1 End of the layout
@ $EE81 label=inner_layout_99
B $EE81,1 End of the layout
@ $EE82 label=inner_layout_100
N $EE82 #UDGTABLE { #PUSHS #DRAWSCREEN(0,10,1)#SCR2,0,6,32,18(inner_screen_100)#POPS } { Screen 100 } TABLE#
B $EE82,24,3
B $EE9A,1 End of the layout
@ $EE9B label=inner_layout_101
N $EE9B #UDGTABLE { #PUSHS #DRAWSCREEN(1,10,1)#SCR2,0,6,32,18(inner_screen_101)#POPS } { Screen 101 } TABLE#
B $EE9B,30,3
B $EEB9,1 End of the layout
@ $EEBA label=inner_layout_102
B $EEBA,1 End of the layout
@ $EEBB label=inner_layout_103
B $EEBB,1 End of the layout
@ $EEBC label=inner_layout_104
B $EEBC,1 End of the layout
@ $EEBD label=inner_layout_105
B $EEBD,1 End of the layout
@ $EEBE label=inner_layout_106
B $EEBE,1 End of the layout
@ $EEBF label=inner_layout_107
B $EEBF,1 End of the layout
@ $EEC0 label=inner_layout_108
B $EEC0,1 End of the layout
@ $EEC1 label=inner_layout_109
B $EEC1,1 End of the layout
u $EEC2 Unused bytes
@ $F000 label=play_title_tune
c $F000 Play the title tune
D $F000 Plays the title tune with interrupts off, over and over until the player presses a key.
N $F000 The clip plays the tune's introduction and its first round.
N $F000 #HTML(#PUSHS #SIM($F472,$F45F,1,sp=$F7F8)#AUDIO1,$F009,$F03E(title-tune.wav)#POPS)
  $F000,5 Play the tune with interrupts held off.
@ $F006 label=run_title_tune
c $F006 Decrypt and run the title tune player
D $F006 Decrypts #R$F009(the tune player) and runs straight into it. The player encrypts itself again before it returns.
  $F006 Decrypt the player, then run on into it.
b $F009 Title tune player, encrypted
D $F009 The title tune player, XOR-encrypted in place. #R$F45F decrypts these bytes with key $41 for the first byte and one more for each byte after it.
N $F009 #R$F009@tune(The decrypted listing) shows these bytes as the game runs them.
@ $F30A label=title_tune_notes
b $F30A Title tune notes
D $F30A The notes of the title tune that lie outside #R$F009(the encrypted player): the end of the tune's first part, then its second part.
N $F30A Each note is a record of 3 bytes: the period of its first tone, the period of its second tone, then its length. A record with a length of 0 ends a part. The first part starts at #R$F1BF@tune(the first notes), inside the encrypted player. Its records run on into this block, and the second part follows its end record.
@ $F45F label=crypt_title_tune
c $F45F Decrypt or re-encrypt the title tune player
D $F45F Decrypts the title tune player at #R$F009, or encrypts it again. XOR is its own inverse, so one pass does either.
  $F45F Start at the player's first byte, with the first key.
@ $F468 label=crypt_byte
  $F468,10 XOR each byte with the key, and take one more for the key of the next byte, until every byte of the player is done.
u $F473 Unused bytes
S $F473,13
@ $F480 label=copy_new_keys
@ $F480 ssub=LD A,(redefinable_keys+5)
c $F480 Copy the new fire and flip keys into the control key sets
D $F480 Gives the keyboard's set the fire and flip keys from the redefine-keys screen, and gives each joystick's set the new flip key.
  $F480 Make the new flip key the flip key of the Sinclair joystick, the cursor joystick and the keyboard.
@ $F483 ssub=LD (control_keys+8),A
@ $F486 ssub=LD (control_keys+16),A
@ $F48C ssub=LD A,(redefinable_keys+4)
  $F48C,6 Make the new fire key the keyboard's fire key.
@ $F48F ssub=LD (control_keys+1),A
u $F493 Unused bytes
S $F493,809,365,8*55,4
s $F7BC Stack
D $F7BC Room for the stack, which #R$BAC6(the main loop) sets to grow down from #R$F7F8. The stack is at its deepest when #R$CE07(the readouts interrupt) breaks into #R$B3B0(the draw of a graphic joined by a vertical bar).
S $F7BC,60,4,8*7 Room for the stack
@ $F7F8 label=stack_start
B $F7F8,8 Bytes just above the stack, which grows down from this address, where #R$BAC6 points SP
@ $F800 label=hostile_slots
g $F800 Hostile object slots
D $F800 The four hostile object slots, 80 bytes per slot, with two at the start of each page. The rest of each page is unused.
N $F800 #TABLE(default) { =h Offset | =h Holds } { $00–$08 | Cover map, one byte per cell of 3×3 } { $09–$38 | Background store, 16 rows of 3 bytes } { $39–$48 | Record, as at #R$C947(the current hostile object) } { $49–$4F | Unused } TABLE#
N $F800 The record holds the object's state at offset $40 and its screen number at $48.
B $F800,9,3 Cover map
@ $F809 label=slot_1_bg_store
S $F809,48 Background store
B $F839,7 Position of the object
@ $F840 label=slot_1_state
B $F840,1 State of the object
B $F841,7 Addresses of the object's cover map, background store and images, and its steer count
@ $F848 label=slot_1_screen
B $F848,1 Number of the screen the object is on
B $F849,7 Unused
B $F850,9,3 Cover map
S $F859,48 Background store
B $F889,7 Position of the object
@ $F890 label=slot_2_state
B $F890,1 State of the object
B $F891,7 Addresses of the object's cover map, background store and images, and its steer count
B $F898,1 Number of the screen the object is on
B $F899,7 Unused
S $F8A0,96 Unused
B $F900,9,3 Cover map
S $F909,48 Background store
B $F939,7 Position of the object
@ $F940 label=slot_3_state
B $F940,1 State of the object
B $F941,7 Addresses of the object's cover map, background store and images, and its steer count
B $F948,1 Number of the screen the object is on
B $F949,7 Unused
B $F950,9,3 Cover map
S $F959,48 Background store
B $F989,7 Position of the object
@ $F990 label=slot_4_state
B $F990,1 State of the object
B $F991,7 Addresses of the object's cover map, background store and images, and its steer count
B $F998,1 Number of the screen the object is on
B $F999,7 Unused
S $F9A0,96 Unused
i $FA00
