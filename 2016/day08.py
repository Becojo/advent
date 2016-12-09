import sys

input = sys.stdin.read().split("\n")
screen = [[' '] * 50 for _ in range(6)]

def t(lis):
    return list(map(list, zip(*lis)))


def format_screen():
    return "\n".join([''.join(line) for line in screen])


for i in input:
    parts = i.strip().split(' ')

    if 'rect' in i:
        w, h = map(int, parts[1].split('x'))

        for x in range(w):
            for y in range(h):
                screen[y][x] = '1'

    if 'rotate row' in i:
        y = int(parts[2].split('=')[1])
        by = int(parts[-1])

        screen[y] = screen[y][(50 - by):] + screen[y][:(50 - by)]

    if 'rotate col' in i:
        x = int(parts[2].split('=')[1])
        by = int(parts[-1])

        tmp = t(screen)
        tmp[x] = tmp[x][(6 - by):] + tmp[x][:(6 - by)]
        screen = t(tmp)


print(format_screen().count('1'))
print(format_screen())
