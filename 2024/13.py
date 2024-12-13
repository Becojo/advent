import z3
import sys
import re

machines = []
with open(sys.argv[1], 'r') as f:
    for m in f.read().split("\n\n"):
        a, b, p = m.splitlines()
        ax, ay = map(int, re.findall(r"\d+", a))
        bx, by = map(int, re.findall(r"\d+", b))
        px, py = map(int, re.findall(r"\d+", p))
        machines.append([
            [ax, ay],
            [bx, by],
            [px, py]
        ])

part1 = 0
for ((ax, ay), (bx, by), (px, py)) in machines:
    a = z3.Int('a')
    b = z3.Int('b')
    s = z3.Solver()

    s.add(a >= 0)
    s.add(b >= 0)
    s.add(ax * a + bx * b == px)
    s.add(ay * a + by * b == py)

    if s.check() == z3.sat:
        m = s.model()
        part1 += m[a].as_long() * 3 + m[b].as_long()

print(part1)


part2 = 0
for ((ax, ay), (bx, by), (px, py)) in machines:
    a = z3.Int('a')
    b = z3.Int('b')
    s = z3.Solver()

    s.add(a >= 0)
    s.add(b >= 0)
    s.add(ax * a + bx * b == px + 10000000000000)
    s.add(ay * a + by * b == py + 10000000000000)

    if s.check() == z3.sat:
        m = s.model()
        part2 += m[a].as_long() * 3 + m[b].as_long()

print(part2)