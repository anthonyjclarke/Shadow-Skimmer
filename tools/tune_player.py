#!/usr/bin/env python3
"""Write the title tune player as it runs: $F009-$F309 decrypted.

  tune_player.py SNAPSHOT.Z80 OUT.bin

In the snapshot these 769 bytes are XOR-encrypted, as the routine at $F45F
leaves them: the first byte with key $41, each byte after it with a key one
higher (wrapping from $FF to $00). XOR is its own inverse, so applying the
same keys gives the code the game runs. OUT.bin holds those bytes alone, to be
disassembled with origin $F009 (sna2skool.py -o 0xF009).

The script checks itself before it writes: the keys applied twice give the
snapshot's bytes back, and the decrypted player opens on LD HL,$F043.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import z80snap  # noqa: E402

START, END = 0xF009, 0xF309      # the span $F45F decrypts (BC = $0301)
FIRST_KEY = 0x41


def crypt(data):
    """XOR each byte with its key, as the game's $F45F does."""
    return bytes(b ^ ((FIRST_KEY + i) & 0xFF) for i, b in enumerate(data))


def main(argv):
    if len(argv) != 3:
        sys.exit(__doc__)
    _, ram, _ = z80snap.unpack(open(argv[1], 'rb').read())
    cipher = ram[START - 0x4000:END + 1 - 0x4000]
    plain = crypt(cipher)
    assert len(plain) == 0x301, len(plain)
    assert crypt(plain) == cipher, 'the keys are not their own inverse'
    assert plain[:3] == bytes([0x21, 0x43, 0xF0]), 'player does not open on LD HL,$F043'
    open(argv[2], 'wb').write(plain)


if __name__ == '__main__':
    main(sys.argv)
