data = input().strip()

def decompress(data):
    count = 0

    while '(' in data:
        s = data.index('(')
        e = data.index(')') + 1
        a, b = map(int, data[s+1:e-1].split('x'))
        count += s + a * b
        data = data[(e+a):]

    return count

def decompress2(data):
    if '(' not in data:
        return len(data)

    count = 0

    while '(' in data:
        s = data.index('(')
        e = data.index(')') + 1
        a, b = map(int, data[s+1:e-1].split('x'))
        count += s + decompress2(data[e:e+a]) * b
        data = data[(e+a):]

    return count

print(decompress(data))
print(decompress2(data))
