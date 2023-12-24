import sys
from pathlib import Path
from z3 import *
import re

input = [
    list(map(float, re.split("[@, ]+", line)))
    for line in Path(sys.argv[1]).read_text().splitlines()
]

s = Solver()
rx, ry, rz, rdx, rdy, rdz = Reals("rx ry rz rdx rdy rdz")
i = 0

for x, y, z, dx, dy, dz in input:
    i += 1
    t = Real(f"t{i}")
    p = (x + t * dx, y + t * dy, z + t * dz)
    r = (rx + t * rdx, ry + t * rdy, rz + t * rdz)

    s.add(t >= 0)
    s.add(p[0] == r[0])
    s.add(p[1] == r[1])
    s.add(p[2] == r[2])

if s.check() == sat:
    m = s.model()
    print(m[rx].as_long() + m[ry].as_long() + m[rz].as_long())
