# Shadow Skimmer – disassembly notes

This file covers where the disassembly stands, how the map was made, what is known about the snapshot and the code, and what comes next under the `zx-game-disasm` skill.

---

## The source snapshot

`SHADSKIM.Z80` is a version 3 `.z80` snapshot of a 48K Spectrum (41,483 bytes, dated 31-10-1996). It was taken after the BASIC loader had loaded the code block, while it waited at line 30:

```
10 BORDER 0: PAPER 0: CLS
20 LOAD "SHADOWSKIM"CODE 25000
30 PAUSE 0
80 RANDOMIZE USR 25085
```

So the RAM is the pristine post-load image the skill asks for, and the game has not run yet. The saved PC is `$1F3D` (the ROM's PAUSE), and the loading screen is still in display memory.

| Number | Value            | Source                                  |
|:-------|:-----------------|:----------------------------------------|
| `ORG`  | `$61A8` (25000)  | `LOAD … CODE 25000`; the tape header    |
| `SIZE` | `$9858` (39000)  | tape header left in the BASIC workspace |
| `PC`   | `$61FD` (25085)  | `RANDOMIZE USR 25085`                   |
| `SP`   | `$FF52`          | the snapshot header                     |

---

## How "byte for byte" is proved

`gmake restore` builds the whole file from source and `cmp`s it with the original:

1. `src/shadskim.ctl` → `build/shadskim.skool` → `build/shadskim.asm` → `pasmo` → the code block `$61A8–$F9FF`, the same route as the skill's round trip. Without `pasmo`, `skool2bin.py` assembles the `.skool` instead.
2. `src/environment.ctl` → two skool files → the RAM below and above the code block: the loading screen, system variables, BASIC and the stack/UDG area.
3. `src/shadskim.z80header` → the 86-byte header: registers, interrupt mode and the version 3 extension.
4. `tools/z80snap.py build` lays the three binaries into 48K, refusing any gap or overlap. It compresses pages 4, 5 and 8 in the original's order with the `.z80` RLE scheme and writes `build/SHADSKIM.Z80`.

The RLE detail matters. A run of 5 or more identical bytes, or 2 or more `$ED` bytes, becomes `ED ED n b`, and the byte after a lone `$ED` is never the start of a run. That reproduces the 1996 converter's output exactly, so all three compressed blocks match too, not only the RAM.

---

## Memory map (first pass)

| Range         | Contents                                                  |
|:--------------|:----------------------------------------------------------|
| `$4000–$5AFF` | Loading screen (pixels and attributes)                    |
| `$5B00–$5DF0` | Printer buffer, system variables, BASIC, workspace        |
| `$5DF1–$61A7` | Zeros below the code block                                |
| `$61A8–$61FC` | Code-like stub, never executed in play (dig-task)         |
| `$61FD`       | Entry point: `JP $B000`                                   |
| `$6200–$AFFF` | Data: pointer tables, graphics, level data (unmapped)     |
| `$B000–$D472` | Main game code                                            |
| `$D473–$EFFF` | Data (unmapped)                                           |
| `$F000–$F008` | Wrapper: `DI`, decrypt, run, `EI`                         |
| `$F009–$F309` | Title tune player, encrypted (see below)                  |
| `$F30A–$F45E` | Undetermined bytes                                        |
| `$F45F–$F472` | XOR decrypt/re-encrypt routine                            |
| `$FA00–$FFFF` | Outside the block: runtime workspace, IM 2 vector, stack  |

The code at `$B003` clears the screen and fills `$FA00–$FCFF` with `$01`. The game writes a jump at `$FDFD`, which is executed, and points a vector table at `$FE00`, so it runs in interrupt mode 2.

---

## Findings worth knowing before editing the map

The routine at `$F009–$F309` is **encrypted in place**. `$F45F` XORs 769 bytes from `$F009` with a key that starts at `$41` and goes up by one per byte (wrapping at `$FF`). Because XOR is its own inverse, a second call restores the ciphertext. In the snapshot those bytes are ciphertext, so they are a `b` block. Executing the snapshot bytes as code is meaningless; the coverage trace hit addresses there only because it ran the decrypted copy. Its decrypted listing is a second code of the site, "tune": `tools/tune_player.py` writes the decrypted bytes to `build/tune_player.bin`, and `src/tune.ctl` disassembles them (wired up by `src/tune.ref` and the Makefile).

The game also **modifies its own code** in four places. Each is written as `label+1` with an `@ssub` so the source stays relocatable:

| Instruction | Patched by                                   |
|:------------|:---------------------------------------------|
| `$B859`     | `$BACE`                                      |
| `$B87A`     | `$CF3C`, `$CF53`                             |
| `$C80D`     | `$B756`, `$C0D6`, `$C12B`, `$C445`, `$C45E`  |
| `$CC0A`     | `$C47D`, `$C48A`, `$CFA6`, `$D10F`           |

Besides those, `$B032` and `$B501` store a whole opcode at `$B058` (it toggles `INC DE`/`DEC DE`). `$B751`, `$C0B5` and `$CBAA` store into `$CC32`. Two `LD HL` instructions take the address of `$CE07` and `$CE26`, which may be data inside a code block.

---

## How the code/data map was made

The skill says to promote a block to code only on execution evidence. SkoolKit's own Z80 simulator supplied it:

1. `tools/coverage_trace.py` runs the game from `$61FD` headlessly. It walks every menu option, redefines the keys, then plays with pseudo-random held keys, pressing fire/start every 1,500 frames so a lost game restarts. Six 60,000-frame sessions (about 20 minutes of game time each) found 4,077 executed addresses.
2. Hits inside the encrypted routine were dropped, as above.
3. `tools/extend_map.py` added the branches of those routines that play never took, restricted to the regions play proved to be code. An unrestricted walk leaked into the graphics through computed jumps.
4. `sna2ctl.py -m` turned the map into a control file. Its text guesses were turned back into bytes, since `t` is reserved for real text.
5. Every operand that pointed into the middle of a data row was split into its own line. Every reference into the middle of an instruction was resolved as SMC (above). After that, `skool2asm.py --create-labels -s` reports **zero warnings**.

Random play mostly stays in sector 1, so code reached only in sectors 2 and 3, on game completion, or on the death of the last shield may still sit inside a `b` block. The skill's FuseX profiler (`zx-fuse-driver`) over a recorded full playthrough is the way to close that gap.

---

## Where it stands against the skill's bar

`gmake coverage` reports 120 routines, all skeletal (named by address only, no descriptions), across 1,026 bare basic blocks. It also reports no `#AUDIO` for the 4 speaker writes and no `#TABLE`s. Ten data arrays have no per-record markup. Labels are 100% named (no `L####`), and no raw operand points into the game region. Raw operands do remain for the workspace above `$FA00`; these become `@equ` constants.

That is stage 2 done. In the skill's words, the project is **NOT at the bar**.

The gate is green against a recorded starting point: `CHECKS PASS [SkoolKit 10.1, gate 14/e4c25bf]`. Every gating check was adopted once (`--adopt`) into `tools/lint-baseline.toml`, which holds the 196 findings of the undocumented map (155 untitled entries, 25 data-structure, 10 array, 4 publication, 2 comment). From here the baseline can only shrink: a new finding fails the gate, and so does a fixed one still listed, so a fix takes its entry with it.

---

## Since the map phase

This file records the map phase (v0.1.0). Stages 3–5 are done: the hook is installed, every routine is documented, the catalogs and the behaviour spec are published, and the dig-tasks above are closed. `CHANGELOG.md` and `docs/PLAN.md` hold the history, and `README.md` the method. The snapshot is no longer tracked; each user supplies it, and the Makefile checks its SHA-256.
