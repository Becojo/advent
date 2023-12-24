import sys
from pathlib import Path
from z3 import *
import re
import itertools
from tqdm import tqdm

input = [
    list(map(float, re.split("[@, ]+", line)))
    for line in Path(sys.argv[1]).read_text().splitlines()
]

pairs = list(itertools.combinations(input, 2))
min = 200000000000000
max = 400000000000000
count = 0

for a, b in tqdm(pairs):
    t1, t2 = Reals("t1 t2")
    x1, y1, _, dx1, dy1, _ = a
    x2, y2, _, dx2, dy2, _ = b
    p1 = (x1 + t1 * dx1, y1 + t1 * dy1)
    p2 = (x2 + t2 * dx2, y2 + t2 * dy2)

    s = Solver()
    s.add(And(t1 >= 0, t2 >= 0))
    s.add(p1[0] >= min)
    s.add(p1[0] <= max)
    s.add(p1[1] >= min)
    s.add(p1[1] <= max)
    s.add(p1[0] == p2[0])
    s.add(p1[1] == p2[1])

    if s.check() == sat:
        count += 1

print(count)