import sys
import re

count1 = 0
count2 = 0
input = sys.stdin.read().split('\n')

for i in input:
    parts = re.split('\[([^\]]+)\]', i)
    outside = ','.join(parts[::2])
    inside = ','.join(parts[1::2])
    valid = True

    for (a, b) in re.findall('(?=(.)(.)\\2\\1)', inside):
        if a != b:
            valid = False

    if valid:
        for (a, b) in re.findall('(?=(.)(.)\\2\\1)', outside):
            if a != b:
                count1 += 1
                break

for i in input:
    parts = re.split('\[([^\]]+)\]', i)
    outside = ','.join(parts[::2])
    inside = ','.join(parts[1::2])

    for (a, b) in re.findall('(?=(.)(.)\\1)', outside):
        if a != b:
            if b+a+b in inside:
                count2 += 1
                break

print(count1)
print(count2)
