# Shadow Skimmer – ZX Spectrum disassembly

A complete, commented and reassemblable disassembly of *Shadow Skimmer* (The Edge / Softek, 1987, by John Marshall and Jack Wilkes). It is built from the snapshot `SHADSKIM.Z80` with [SkoolKit](https://skoolkit.ca) and the [`zx-game-disasm`](https://github.com/morozov/zx-spectrum-skills) skill, and published as an HTML site with every graphic, screen and sound rendered by the game's own code.

**Status (v0.4.1, 11-11-2026):** finished. `gmake restore` rebuilds `SHADSKIM.Z80` from source, identical to the original byte for byte. The skill's full gate passes, and every diff since the code map has been approved by an independent review.

---

## What is here

| Part                | Content                                       |
|:--------------------|:----------------------------------------------|
| Listing             | 130 routines, 83 data entries, all commented  |
| Title tune listing  | The XOR-encrypted player, decrypted           |
| Graphics page       | All 151 hull graphics, sprites, hatch opening |
| Screens page        | Every outer and inner screen, 10 × 11 map     |
| Sound page          | Tune, shot and explosion as WAV clips         |
| Workspace page      | The attribute mirror and runtime buffers      |
| Glossary            | Terms and a Write/Not word registry           |
| Behaviour spec      | 15 pages, `spec/*.md`, published on the site  |

The listing records eleven defects as BUG notes, in the code and in the game's data. Two of them:

- `$C8C4`: a hostile object's shot fired right stops one column short of the edge.
- `$E132`: screen 55's last layout record carries a stray run flag, so that graphic casts no shadow.

---

## Quick start

macOS on Apple silicon, with Xcode and Homebrew.

### Getting the snapshot

The game itself is not in this repository. Put your own copy of the snapshot in the project root as `SHADSKIM.Z80`. The copy this disassembly was made from is a version 3 `.z80` file of 41,483 bytes. [Spectrum Computing](https://spectrumcomputing.co.uk/entry/4426) and [World of Spectrum](https://worldofspectrum.org/archive/software/games/shadow-skimmer-the-edge) archive the game, but their downloads have not been checked against it. The build checks the snapshot's SHA-256 before anything else:

```
3adeb924bdf5e85ea5e7086a77dd57b2546291fd893cef08f90cf2019bd29183  SHADSKIM.Z80
```

A different dump of the game fails that check, and the disassembly will not match it.

### Build

Run these once on a fresh checkout:

```bash
tools/bootstrap.sh
```

```bash
gmake restore
```

```bash
gmake html
```

The site is then in `build/html/shadskim/index.html`.

| Command           | What it does                                    |
|:------------------|:------------------------------------------------|
| `gmake restore`   | Rebuild `SHADSKIM.Z80` from source, `cmp` it    |
| `gmake`           | The skill's full gate (lint, round trip, review) |
| `gmake html`      | The HTML site in `build/html/`                  |
| `gmake lint-prose`| Vale over the prose (advisory)                  |
| `gmake coverage`  | The skill's "is it done?" gauge                 |
| `gmake fuse`      | `restore`, then open the result in Fuse         |

Use `gmake` (GNU make 4); `/usr/bin/make` is 3.81 and cannot run the skill's framework.

---

## Background

*Shadow Skimmer* is a 48K Spectrum shoot-'em-up. You fly a skimmer over the hull of an alien mothership, drop through hatchways into its inner sections, and destroy the defence device of each of three sectors. When all three are gone, the gates on outer screen 5 open, and the hatchway beyond them ends the game ("WALL DONE").

The aim of this project was to take one game through the whole `zx-game-disasm` workflow, from an unknown snapshot to a published, reviewed and byte-exact disassembly. The secondary aim was to learn how far a team of Claude agents could carry that work, and what it costs.

---

## Approach

### The workflow

The skill sets a fixed pipeline and a rulebook (`references/rules.md`, 131 rules). Each phase ended in a reviewed commit on `dev`:

1. **Code and data map.** The snapshot was split into code and data, from execution traces (`tools/coverage_trace.py`, `tools/extend_map.py`) and static reading. The `.z80` file, header and RLE included, is rebuilt exactly (`tools/z80snap.py`).
2. **Naming.** Nine slices of the listing were named in parallel, under one set of name rulings, such as "hostile object", "attribute mirror", "hatchway" and "hatch".
3. **Depth.** Every routine was documented to the skill's prose bar, in slices: the graphics engine, layouts, the game loop, hostile objects, the Skimmer, firing, the control panel, and the decrypted tune player.
4. **Catalogs.** The Graphics, Screens and Sound pages. Each render comes from the game's own code, run in SkoolKit's simulator (`#SIM`, `#AUDIO`).
5. **Behaviour spec.** Fifteen pages describe the game as a system. They also cover the state, actions and rewards an agent would see.
6. **Dig-tasks.** About 60 open questions were settled: entry splits, behaviour questions, renders, the stack's depth and the glossary.
7. **Runtime check.** FuseX runs, driven by keys, reached sectors 2 and 3 and the ending. They confirmed the listing's claims about those parts.

### Manager, Worker, Challenger

The skill defines three roles. This session's main agent was the **Manager**: it planned, wrote briefs, kept `docs/PLAN.md` and committed. **Workers** were subagents that edited the `.ctl` and `.ref` files. A separate **Challenger** subagent reviewed each exact diff against the rulebook. A pre-commit hook refuses any commit without the Challenger's COMMIT record for that diff hash.

Most checkpoints took one or two SPLIT rounds before COMMIT. The Challenger caught real errors: wrong row ranges, an overstated defect, a claim built on a run instead of the code, and two of its own earlier rulings, which it withdrew when the gate proved them wrong.

### Upstream skill fixes

The work turned up 18 defects in the skill itself. They include checks that misfired on link text, the gate skipping the tune listing's control file, theme layout faults, and a generic spec converter living in this repo. They are fixed in 25 commits, each with a test fixture, on branch `shadskim-fixes` of a fork. They are offered upstream as [morozov/zx-spectrum-skills#1](https://github.com/morozov/zx-spectrum-skills/pull/1), and vendored here in `vendor/zx-game-disasm/`.

---

## Tools and aids

| Tool                         | Use                                           |
|:-----------------------------|:----------------------------------------------|
| [SkoolKit](https://skoolkit.ca) 10.1 | Disassembly, simulator, HTML, `#AUDIO` |
| [zx-spectrum-skills](https://github.com/morozov/zx-spectrum-skills) | `zx-game-disasm` workflow, gate, rules |
| [pasmo](https://pasmo.speccy.org/) 0.5.5 | Assembles the round trip, built from source |
| GNU make 4.4 (Homebrew)      | Runs the skill's framework (`gmake`)          |
| [Vale](https://vale.sh) 3.26 | Prose lint (Microsoft style, ZXDisasm rules)      |
| [Fuse for macOS](https://sourceforge.net/p/fuse-for-macosx/) (arm64) | Manual play testing, `tools/build_fuse.sh` |
| [FuseX](https://github.com/speccytools/fusex) | Headless runs via `libfusex`, `tools/build_fusex.sh` |
| Python 3.14, Pillow, numpy, markdown | Project tools and renders       |
| Headless Chrome              | Page screenshots for visual review            |
| Claude Code (desktop app)    | Manager, Worker, Challenger and Researcher agents |
| `gh` CLI                     | Fork and pull request                         |

### Sources

- The game's leaflet text (not included), which backs the game's own words ("mothership", "pulse lasers").
- The instructions archived at [nvg.ntnu.no](https://rk.nvg.ntnu.no/sinclair/instructions/shadowsk.html) come from a different edition. They say "liner" and "welding lasers", and put the shield count at top left, where the code prints it.
- [Spectrum Computing entry 4426](https://spectrumcomputing.co.uk/entry/4426) and [World of Spectrum](https://worldofspectrum.org/archive/software/games/shadow-skimmer-the-edge) for the release details.

---

## Use of Claude

The whole disassembly was done in Claude Code. A human owner set direction, made the rulings (which skill fixes to take, where the spec converter lives, installing Vale, the FuseX build, the PR) and approved anything outward-facing. Claude agents did the reading, writing, reviewing and testing.

| Item                          | Figure                                       |
|:------------------------------|:---------------------------------------------|
| Elapsed time                  | 08-11-2026 to 11-11-2026, about 3 days       |
| Model                         | Claude Opus 5.5 (1M context)                 |
| Plan                          | Claude Pro                                   |
| Subagents                     | 68 (Workers, Challengers, Researchers)       |
| API calls                     | about 5,600 (727 Manager, 4,844 subagent)    |
| Output tokens                 | about 5.2 M (0.57 M Manager, 4.66 M subagent) |
| Cache writes                  | about 29 M                                   |
| Cache reads                   | about 1,250 M                                |
| Usage-limit stops             | several; each resumed after the reset        |

The figures are summed from the session transcripts. Cache reads dominate: each tool call re-reads the agent's whole context, so a long-lived agent becomes more expensive with every step. The largest single agents were the depth Workers and the two skill-fix Workers, at 40–60 M tokens each, mostly cache reads over 120–190 calls.

### How the token use could be improved

- **Shorter-lived agents.** One reused Challenger grew past 500 K tokens of history. Reuse was cheap for re-reviews of the same diff, but costly when the same agent reviewed new diffs. A fresh Challenger per checkpoint, with a short brief of the standing rulings, would cost less.
- **Smaller slices.** Workers with 150+ tool calls spent most of their tokens re-reading their own context. Slices of 30–50 entries, rather than whole subsystems, would keep each agent's context small.
- **Briefs that point, not paste.** Writing briefs to files and passing a path worked well. Putting the standing rulings in `docs/PLAN.md` and `CLAUDE.md`, and not in each brief, avoided repeating them.
- **Gate output to files.** Every gate run was redirected to a file and only its verdict lines read back. Doing the same for every long tool output saves context.
- **Batch Challenger fixes.** Several SPLIT rounds turned on one-line wording that a linter then rejected, such as sentence length or a noun phrase with a full stop. Running the gate on a proposed fix before sending it back would save a round trip.
- **Fix tooling first.** The extractor and SYNTH_ECHO false positives cost several rounds of work-arounds before they were fixed at the source. A short pass over the skill's checks on the first real findings would have saved that.
- **Run cheaper models for reading.** Read-only research and census work could run on a smaller model. Here everything ran on Opus.

---

## Lessons

- **Ground truth beats inference.** Every claim about behaviour was settled from the code, and runs were used only to confirm it. The FuseX runs found no contradiction. One early claim, which closed screen 55's stray run flag (`$E132`) as harmless, was wrong. The review caught it, and it is now a documented data defect.
- **A byte-exact round trip is a strong safety net.** Structural edits (entry splits, merges, typed words) could be made freely, because `gmake restore` proved nothing moved.
- **Independent review earns its cost.** The Challenger refused to accept work-arounds (WORK-2: "never appease a check"). That forced several checker defects to be fixed at the source, instead of being hidden in the prose.
- **Linters encode a house style, and can be wrong.** Several checks fired on correct text. Fixing the check, with a fixture for the bad and the good case, was always better than rewording around it.
- **Let the game draw itself.** Rendering screens, graphics and sound by running the game's own routines in the simulator made every render trustworthy, and it surfaced data defects that a redrawn picture would have hidden.
- **Encrypted code needs its own listing.** The title tune player at `$F009–$F309` is XOR-encrypted in the snapshot. A separate decrypted listing kept the main listing byte-exact and the player readable.

---

## Potential issues

- **The vendored skill is ahead of upstream.** `tools/bootstrap.sh` clones the unmodified upstream skill. Until [PR #1](https://github.com/morozov/zx-spectrum-skills/pull/1) is merged, a fresh clone fails `vendor-check`. Switch `external/zx-spectrum-skills` to the `shadskim-fixes` branch of [the fork](https://github.com/anthonyjclarke/zx-spectrum-skills) to build.
- **Copyright.** The game is © 1987 The Edge / Softek. This repository does not include it: you supply your own snapshot, and the build checks its SHA-256. The disassembly is for preservation and study.
- **macOS only.** The bootstrap and build scripts assume Apple silicon with Homebrew and Xcode. FuseX also needs Apple's Metal Toolchain for its GUI app; the headless library builds without it.
- **Unpinned tools.** SkoolKit is pinned to 10.1, but Vale's style packages and the `markdown` package are not pinned. A newer release may change the prose lint's findings.
- **Advisory prose findings remain.** `gmake lint-prose` reports 147 advisory findings: passives with no actor, Oxford commas the project does not use, sentences over Microsoft's length limit, three adverbs and two British logical quotes. They are left by choice.
- **One question has no answer.** Nothing in the game or either leaflet names the animated 3×3 graphic at `$95D0`.

---

## Layout

| Path                     | Holds                                        |
|:-------------------------|:---------------------------------------------|
| `SHADSKIM.Z80`           | Your copy of the snapshot (not tracked)      |
| `src/shadskim.ctl`       | Control file for the code block              |
| `src/tune.ctl`           | The decrypted title tune player              |
| `src/environment.ctl`    | Screen, system vars, BASIC, top of RAM       |
| `src/*.ref`              | Site pages: graphics, screens, sound, glossary |
| `spec/*.md`              | The behaviour specification                  |
| `tools/`                 | Snapshot, trace, tune and build scripts      |
| `vendor/zx-game-disasm/` | The skill's site build (`gmake vendor`)      |
| `docs/PLAN.md`           | The Manager's plan, rulings and closed tasks |
| `docs/DISASSEMBLY.md`    | Method and findings from the map phase       |
| `external/`, `build/`    | Clones and generated files (not tracked)     |

The `.ctl`, `.ref` and `spec/*.md` files are the only hand-edited sources. Everything under `build/` is generated from them.

---

## Credits

- Game © 1987 The Edge / Softek. By John Marshall and Jack Wilkes.
- [SkoolKit](https://skoolkit.ca) by Richard Dymond.
- [zx-spectrum-skills](https://github.com/morozov/zx-spectrum-skills) by morozov.
- [FuseX](https://github.com/speccytools/fusex) by speccytools; [Fuse](https://fuse-emulator.sourceforge.net/) by Philip Kendall and contributors.
- Disassembly by Anthony Clarke, with Claude.
