package day2

map = {
	"A": "R",
	"B": "P",
	"C": "S",
	"X": "R",
	"Y": "P",
	"Z": "S",
}

outcome = {
	"R": {"R": 3, "P": 0, "S": 6},
	"P": {"R": 6, "P": 3, "S": 0},
	"S": {"R": 0, "P": 6, "S": 3},
}

values = {
	"R": 1,
	"P": 2,
	"S": 3,
}

rounds_1[i] = result {
	input[i]

	[op, you] = [map[play] | play := input[i][_]]

	result := outcome[you][op] + values[you]
}

part_1 = sum([r | r := rounds_1[_]])

endmap = {
	# lose
	"X": {"R": "S", "P": "R", "S": "P"},
	# draw
	"Y": {"R": "R", "P": "P", "S": "S"},
	# win
	"Z": {"R": "P", "P": "S", "S": "R"},
}

rounds_2[i] = result {
	input[i]

	op := map[input[i][0]]
	you := endmap[input[i][1]][op]

	result := outcome[you][op] + values[you]
}

part_2 = sum([r | r := rounds_2[_]])
