#!/usr/bin/env python3
"""Read and write .z80 snapshots (v2, 48K) so SHADSKIM.Z80 can be rebuilt exactly.

  z80snap.py unpack SNAPSHOT.Z80 HEADER.bin RAM.bin
      Split a snapshot into its 55-byte header (30-byte base + 2-byte length
      + 23-byte v2 extension) and the 48K of RAM ($4000-$FFFF).
  z80snap.py build HEADER.z80header OUT.Z80 FILE.bin@ADDR [FILE.bin@ADDR ...]
      Rebuild a snapshot from source: the header from its annotated hex text
      (src/shadskim.z80header), then 48K of RAM laid together from binaries,
      each placed at its hex address. Every byte from $4000 to $FFFF must be
      supplied exactly once. The RAM is written as pages 4, 5, 8 (the order of
      the original file), each compressed with the .z80 RLE scheme.

Compression (the scheme of the original 1996 converter, verified by round-trip):
a run of 5+ identical bytes, or 2+ $ED bytes, becomes ED ED count byte
(count <= 255); a lone $ED is emitted as-is and the byte that follows it is
never the start of a block.
"""
import sys

# Page number -> address in 48K mode, in the order the original file stores them.
PAGES = [(4, 0x8000), (5, 0xC000), (8, 0x4000)]


def decompress(data):
    out = bytearray()
    i = 0
    while i < len(data):
        if data[i] == 0xED and i + 1 < len(data) and data[i + 1] == 0xED:
            out += bytes([data[i + 3]]) * data[i + 2]
            i += 4
        else:
            out.append(data[i])
            i += 1
    return bytes(out)


def compress(data):
    out = bytearray()
    i, n = 0, len(data)
    while i < n:
        b = data[i]
        run = 1
        while i + run < n and data[i + run] == b and run < 255:
            run += 1
        if run >= 5 or (b == 0xED and run >= 2):
            out += bytes([0xED, 0xED, run, b])
            i += run
        elif b == 0xED:
            # A single ED: emit it and the following byte literally.
            out.append(b)
            i += 1
            if i < n:
                out.append(data[i])
                i += 1
        else:
            out.append(b)
            i += 1
    return bytes(out)


def unpack(snap):
    hdr_len = 32 + snap[30] + 256 * snap[31]
    header, pos = snap[:hdr_len], hdr_len
    ram = bytearray(0xC000)
    order = []
    while pos < len(snap):
        length = snap[pos] + 256 * snap[pos + 1]
        page = snap[pos + 2]
        pos += 3
        if length == 0xFFFF:
            block, length = snap[pos:pos + 0x4000], 0x4000
        else:
            block = decompress(snap[pos:pos + length])
        assert len(block) == 0x4000, (page, len(block))
        addr = dict(PAGES)[page]
        ram[addr - 0x4000:addr] = block
        order.append(page)
        pos += length
    return bytes(header), bytes(ram), order


def pack(header, ram):
    out = bytearray(header)
    for page, addr in PAGES:
        block = compress(ram[addr - 0x4000:addr])
        out += bytes([len(block) & 255, len(block) >> 8, page]) + block
    return bytes(out)


def read_header(path):
    data = bytearray()
    for line in open(path):
        data += bytes.fromhex(line.split(';', 1)[0])
    return bytes(data)


def lay_ram(specs):
    ram = bytearray(0xC000)
    owner = [None] * 0xC000
    for spec in specs:
        path, addr = spec.rsplit('@', 1)
        addr = int(addr, 16)
        data = open(path, 'rb').read()
        if addr < 0x4000 or addr + len(data) > 0x10000:
            sys.exit(f'{spec}: ${addr:04X}-${addr + len(data) - 1:04X} is outside $4000-$FFFF')
        for i, b in enumerate(data):
            a = addr + i - 0x4000
            if owner[a] is not None:
                sys.exit(f'${addr + i:04X} is supplied by both {owner[a]} and {path}')
            owner[a] = path
            ram[a] = b
    gaps = [i + 0x4000 for i, o in enumerate(owner) if o is None]
    if gaps:
        sys.exit(f'{len(gaps)} bytes not supplied, first at ${gaps[0]:04X}')
    return bytes(ram)


def main(argv):
    if len(argv) == 5 and argv[1] == 'unpack':
        header, ram, order = unpack(open(argv[2], 'rb').read())
        assert order == [p for p, _ in PAGES], order
        open(argv[3], 'wb').write(header)
        open(argv[4], 'wb').write(ram)
    elif len(argv) >= 5 and argv[1] == 'build':
        header = read_header(argv[2])
        ram = lay_ram(argv[4:])
        open(argv[3], 'wb').write(pack(header, ram))
    else:
        sys.exit(__doc__)


if __name__ == '__main__':
    main(sys.argv)
