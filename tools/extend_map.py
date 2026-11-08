#!/usr/bin/env python3
"""Extend an execution map with the code statically reachable from it.

  extend_map.py SNAPSHOT.Z80 IN.map OUT.map [--range LO-HI ...]

A play session only charges the paths it took. From every executed address
this follows fall-through, JR/JP/DJNZ/CALL/RST targets, and stops at an
unconditional jump or return, so a branch that was never taken in play (a
rare collision, the end-of-game sequence) still lands in the map. Only
addresses inside the given hex ranges (the regions play showed to be code) are
followed: a static walk let loose over the whole image leaks into graphics
through computed jumps and inline data, and promotes sprites to code.
"""
import argparse
import re

from skoolkit.snaskool import DisassemblerConfig, Instruction
from skoolkit.components import get_component
from skoolkit.snapshot import make_snapshot

TARGET = re.compile(r'\b(?:JP|JR|CALL|DJNZ)\b(?:\s+[A-Z]+,)?\s*\$([0-9A-F]{4})$')
RST = re.compile(r'\bRST\s+\$([0-9A-F]{2})$')
STOP = re.compile(r'^(RET|RETI|RETN|JP|JR)(\s+\$[0-9A-F]{4}|\s+\((HL|IX|IY)\))?$')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('snapshot')
    ap.add_argument('inmap')
    ap.add_argument('outmap')
    ap.add_argument('--range', action='append', default=[],
                    help='hex LO-HI (HI exclusive); may be repeated')
    args = ap.parse_args()
    ranges = [tuple(int(v, 16) for v in r.split('-')) for r in args.range]
    inside = lambda a: any(lo <= a < hi for lo, hi in ranges)

    memory = make_snapshot(args.snapshot, None)[0]
    config = DisassemblerConfig(True, False, 8, 65, 1, 0, Instruction, '', 0)
    dis = get_component('Disassembler', memory, config)
    seen = set()
    todo = [int(line.strip()[1:], 16) for line in open(args.inmap) if line.strip()]
    todo = [a for a in todo if inside(a)]
    while todo:
        addr = todo.pop()
        while inside(addr) and addr not in seen:
            seen.add(addr)
            instr = dis.disassemble(addr, addr + 1, 'n')[0]
            op = instr.operation.upper()
            m = TARGET.search(op)
            if m:
                todo.append(int(m.group(1), 16))
            m = RST.search(op)
            if m:
                todo.append(int(m.group(1), 16))
            if STOP.match(op):
                break
            addr += len(instr.bytes)
    with open(args.outmap, 'w') as out:
        for a in sorted(seen):
            out.write(f'${a:04X}\n')


if __name__ == '__main__':
    main()
