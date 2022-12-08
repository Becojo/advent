package day8

map = [[to_number(c) | c = split(y, "")[_]] | y = split(input, "\n")[_]]
width = count(map[0])
height = count(map)

heights[[x, y]] = h {
	h = map[y][x]
}

visible_up[[x, y]] {
    x > 0
	y > 0
	x < width - 1
	y < height - 1

	d = heights[[x, y]]
	ys = numbers.range(0, y - 1)
	0 == count([1 | d2 = heights[[x, ys[_]]]; d2 >= d])
}

visible_down[[x, y]] {
    x > 0
	y > 0
	x < width - 1
	y < height - 1

	d = heights[[x, y]]
	ys = numbers.range(y, height)
	0 == count([1 | d2 = heights[[x, ys[_]]]; d2 >= d])
}

visible_left[[x, y]] {
    x > 0
	y > 0
	x < width - 1
	y < height - 1

	d = heights[[x, y]]
	xs = numbers.range(0, x - 1)
	0 == count([1 | d2 = heights[[xs[_], y]]; d2 >= d])
}

visible_right[[x, y]] {
    x > 0
	y > 0
	x < width - 1
	y < height - 1

	d = heights[[x, y]]
	xs = numbers.range(x + 1, width)
	0 == count([1 | d2 = heights[[xs[_], y]]; d2 >= d])
}


visible_from_outside[[0, y]] {
	heights[[0, y]]
}

visible_from_outside[[x, 0]] {
	heights[[x, 0]]
}


visible_from_outside[[x, y]] {
	heights[[x, y]]
	x = width - 1
}

visible_from_outside[[x, y]] {
	heights[[x, y]]
	y = height - 1
}


visible_from_outside[[x, y]] {
	visible_left[[x, y]]
}

visible_from_outside[[x, y]] {
	visible_right[[x, y]]
}

visible_from_outside[[x, y]] {
	visible_up[[x, y]]
}

visible_from_outside[[x, y]] {
	visible_down[[x, y]]
}


part_1 = count(visible_from_outside)

part_2 = 42
