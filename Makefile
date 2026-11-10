# Shadow Skimmer (The Edge, 1987) - SkoolKit disassembly.
#
# Built on the zx-game-disasm skill (github.com/morozov/zx-spectrum-skills),
# cloned into external/ by tools/bootstrap.sh. Run with GNU make 4 (gmake on
# macOS; the system make is 3.81).
#
#   gmake restore  Rebuild SHADSKIM.Z80 from source and cmp it with the original
#   gmake          The skill's gate: round-trip cmp + .ctl linters + HTML site
#   gmake coverage The skill's "is it done?" gauge
#   gmake html     The HTML site (build/html/)
#   gmake fuse     Open the rebuilt snapshot in Fuse
#   gmake clean    Remove build/

GAME = shadskim

# The game's code block (LOAD "SHADOWSKIM"CODE 25000, 39000 bytes), its entry
# point (RANDOMIZE USR 25085) and the stack pointer in the snapshot. Decimal:
# the skill's extract_bytes.py reads ORG and SIZE with int().
ORG  = 25000
SIZE = 39000
PC   = 25085
SP   = 65362
RELOC_FLOOR = 0x5B00   # refs at/above must be labels (below = ROM/screen, fixed)

$(foreach v,ORG SIZE PC SP,$(if $($(v)),,$(error set $(v) to the game's value)))

# SkoolKit, pasmo and the Python tools live in the project's virtualenv.
export PATH := $(CURDIR)/.venv/bin:$(PATH)

SKILL ?= $(CURDIR)/external/zx-spectrum-skills/zx-game-disasm
SITE_DIR = vendor/zx-game-disasm
DEV_MK = $(SKILL)/tools/disassembly.mk

# --- Full-snapshot restoration (this project's own) ---------------------------
#
# The skill proves the code block round-trips. This proves the whole file does:
# the .z80 header (src/shadskim.z80header), the RAM outside the code block
# (src/environment.ctl) and the code block itself are assembled and packed into
# build/SHADSKIM.Z80, which must equal the original byte for byte.
ORIGINAL   = SHADSKIM.Z80
HEADER     = src/$(GAME).z80header
ENV_CTL    = src/environment.ctl
RESTORED   = build/SHADSKIM.Z80

# The code block is assembled from the .asm by pasmo, as the skill's round-trip
# does. Until pasmo is installed, SkoolKit's own assembler (skool2bin.py) builds
# it from the .skool instead.
HAVE_PASMO := $(shell command -v pasmo 2>/dev/null)
TOOLS_restore := sna2skool.py skool2bin.py $(if $(HAVE_PASMO),skool2asm.py pasmo)
TOOLS_fuse := $(TOOLS_restore)

-include $(SITE_DIR)/site.mk
ifneq ($(wildcard $(DEV_MK)),)
    include $(DEV_MK)
else ifndef SITE_HOME
    $(error $(SITE_DIR)/site.mk not found, and no skill at $(SKILL) to vendor it from)
else
    $(info $(DEV_MK) not found: only the site build is available)
endif

# The game comes as a snapshot, not a tape, so the snapshot the skill's build
# would make with tap2sna.py is a copy of the original. ($(T2S) stays a
# prerequisite of the skill's rule; src/shadskim.t2s records the provenance.)
$(Z80): $(ORIGINAL)
	@mkdir -p $(dir $@)
	cp $< $@

# One .ctl, two skool files: skool2bin.py lays an entry after an `i` block
# straight after the one before it, so the two ranges are disassembled apart.
ENV_SKOOL_LOW  = $(BUILD)/environment-4000.skool
ENV_SKOOL_HIGH = $(BUILD)/environment-FA00.skool
ENV_LOW   = $(BUILD)/environment-4000.bin
ENV_HIGH  = $(BUILD)/environment-FA00.bin
PROG_BIN  = $(if $(HAVE_PASMO),$(ASM_BIN),$(BUILD)/$(GAME).skool.bin)

$(ENV_SKOOL_LOW): $(Z80) $(ENV_CTL)
	sna2skool.py --hex -e 0x61A8 --ctl $(ENV_CTL) $(Z80) > $@

$(ENV_SKOOL_HIGH): $(Z80) $(ENV_CTL)
	sna2skool.py --hex -s 0xFA00 --ctl $(ENV_CTL) $(Z80) > $@

$(ENV_LOW): $(ENV_SKOOL_LOW)
	skool2bin.py $< $@

$(ENV_HIGH): $(ENV_SKOOL_HIGH)
	skool2bin.py $< $@

$(BUILD)/$(GAME).skool.bin: $(SKOOL)
	skool2bin.py -w -S 0x61A8 -E 0xFA00 $< $@

$(RESTORED): $(HEADER) $(ENV_LOW) $(PROG_BIN) $(ENV_HIGH) tools/z80snap.py
	python3 tools/z80snap.py build $(HEADER) $@ \
	    $(ENV_LOW)@4000 $(PROG_BIN)@61A8 $(ENV_HIGH)@FA00

.PHONY: restore fuse
restore: $(RESTORED)
	cmp $(ORIGINAL) $(RESTORED)
	@echo "RESTORE OK: $(RESTORED) is identical to $(ORIGINAL) (code block assembled by $(if $(HAVE_PASMO),pasmo,skool2bin.py))"

FUSE_APP ?= Fuse
fuse: restore
	open -a "$(FUSE_APP)" $(RESTORED)

# --- The title tune player ($F009-$F309) -------------------------------------
#
# Those bytes are encrypted in the snapshot, so the main listing holds them as
# data. tools/tune_player.py decrypts them, and src/tune.ctl disassembles the
# result as a second code of the site, "tune" (src/tune.ref names its source).
TUNE_BIN   = $(BUILD)/tune_player.bin
TUNE_SKOOL = $(BUILD)/tune.skool

$(TUNE_BIN): $(ORIGINAL) tools/tune_player.py tools/z80snap.py
	@mkdir -p $(dir $@)
	python3 tools/tune_player.py $< $@

$(TUNE_SKOOL): $(TUNE_BIN) src/tune.ctl
	sna2skool.py --hex -o 0xF009 --ctl src/tune.ctl $< > $@

$(HTML_DIR)/.stamp: $(TUNE_SKOOL)
