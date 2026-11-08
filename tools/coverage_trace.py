#!/usr/bin/env python3
"""Play SHADSKIM.Z80 headlessly under SkoolKit's Z80 simulator and log every
address an instruction started at, as evidence for the code/data map.

  coverage_trace.py SNAPSHOT.Z80 MAPFILE [--seed N] [--frames N] [--shots DIR]

Execution starts at the game's entry point ($61FD, the USR address of the BASIC
loader). A scripted session walks the menu (every control option, the
redefine-keys screen) and then plays with pseudo-random held keys, pressing
"0" (start / fire) regularly so a lost game restarts. The map file is in the
format sna2ctl.py -m reads: one $-hex address per line, RAM only.
"""
import argparse
import contextlib
import io
import os
import random

from skoolkit.simulator import Simulator
from skoolkit.snapshot import Snapshot
from skoolkit.simutils import from_snapshot, PC
from skoolkit.trace import Tracer

try:
    from skoolkit.csimulator import CSimulator
except ImportError:  # pragma: no cover
    CSimulator = None

FRAME = 69888
ENTRY = 0x61FD

# (half-row, bit) of each key the session presses. Half-row i is selected by
# bit i of the port's high byte being reset.
KEYS = {
    'CAPS': (0, 0), 'Z': (0, 1), 'X': (0, 2),
    'A': (1, 0), 'Q': (2, 0), 'W': (2, 1),
    '1': (3, 0), '2': (3, 1), '3': (3, 2), '4': (3, 3), '5': (3, 4),
    '0': (4, 0), '6': (4, 4), '7': (4, 3), '8': (4, 2), '9': (4, 1),
    'P': (5, 0), 'O': (5, 1), 'I': (5, 2),
    'ENTER': (6, 0), 'L': (6, 1), 'K': (6, 2),
    'SPACE': (7, 0), 'M': (7, 2),
}


class DriveTracer(Tracer):
    def read_port(self, registers, port):
        if port & 0xFF == 0x1F:  # Kempston: nothing pressed
            return 0
        return super().read_port(registers, port)


def press(keyboard, keys):
    for i in range(8):
        keyboard[i] = 0
    for k in keys:
        row, bit = KEYS[k]
        keyboard[row] |= 1 << bit


def script(rng, frames):
    """Yield the set of keys held for each frame."""
    menu = []
    # Visit every control option, then the redefine-keys screen with a full
    # set of answers (left, right, up, down, fire, flip), then keyboard.
    for k in ('2', '3', '4', '1'):
        menu += [()] * 40 + [(k,)] * 6
    menu += [()] * 40 + [('5',)] * 6
    for k in ('Q', 'W', 'P', 'L', 'M', 'A'):
        menu += [()] * 30 + [(k,)] * 6
    menu += [()] * 60 + [('1',)] * 6 + [()] * 40
    yield from menu
    moves = [('Z',), ('X',), ('O',), ('K',), ('Z', 'O'), ('X', 'K'),
             ('X', 'O'), ('Z', 'K'), ('0',), ('X', '0'), ('O', '0'),
             ('K', '0'), ('CAPS',), ('X', 'CAPS'), ()]
    f = len(menu)
    held = ()
    while f < frames:
        if f % 1500 < 8:
            held_now = ('0',)
        else:
            if f % 20 == 0:
                held = rng.choice(moves)
            held_now = held
        yield held_now
        f += 1


def save_screen(memory, path):
    from PIL import Image
    pal = [(0, 0, 0), (0, 0, 205), (205, 0, 0), (205, 0, 205),
           (0, 205, 0), (0, 205, 205), (205, 205, 0), (205, 205, 205)]
    bright = [(0, 0, 0), (0, 0, 255), (255, 0, 0), (255, 0, 255),
              (0, 255, 0), (0, 255, 255), (255, 255, 0), (255, 255, 255)]
    img = Image.new('RGB', (256, 192))
    px = img.load()
    for y in range(192):
        row = 0x4000 + ((y & 0xC0) << 5) + ((y & 7) << 8) + ((y & 0x38) << 2)
        for cx in range(32):
            b = memory[row + cx]
            a = memory[0x5800 + (y // 8) * 32 + cx]
            p = bright if a & 64 else pal
            ink, paper = p[a & 7], p[(a >> 3) & 7]
            for bit in range(8):
                px[cx * 8 + bit, y] = ink if b & (128 >> bit) else paper
    img.resize((512, 384), Image.NEAREST).save(path)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('snapshot')
    ap.add_argument('mapfile')
    ap.add_argument('--seed', type=int, default=1)
    ap.add_argument('--frames', type=int, default=30000)
    ap.add_argument('--shots')
    args = ap.parse_args()

    snapshot = Snapshot.get(args.snapshot)
    sim = from_snapshot(CSimulator or Simulator, snapshot, {'PC': ENTRY})
    tracer = DriveTracer(sim, snapshot.border, 0, 0, [0] * 16, 0, False)
    sim.set_tracer(tracer)
    tracer.keyboard = [0] * 8
    exec_map = set()
    rng = random.Random(args.seed)
    if args.shots:
        os.makedirs(args.shots, exist_ok=True)
    for f, keys in enumerate(script(rng, args.frames)):
        press(tracer.keyboard, keys)
        with contextlib.redirect_stdout(io.StringIO()):
            tracer.run(sim.registers[PC], -1, 0, FRAME, True, None, exec_map,
                       None, None, '$', '02X', '04X')
        if args.shots and f % 1000 == 0:
            save_screen(sim.memory, os.path.join(args.shots, f'f{f:06d}.png'))
    with open(args.mapfile, 'w') as out:
        for addr in sorted(a for a in exec_map if a >= 0x4000):
            out.write(f'${addr:04X}\n')


if __name__ == '__main__':
    main()
