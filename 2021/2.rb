# made with Copilot

# read all the lines of the file "2"
input = File.readlines("2")

# let x y be 0
x = 0
y = 0

# for each line, split the line by spaces and convert the second value to an integer
# if the first value is "forward", add second value to x
# if the first value is "down", add second value to y
# if the first value is "up", minus second value to y
# after the for loop, puts x times y
input.each do |line|
  line = line.split(" ")
  if line[0] == "forward"
    x += line[1].to_i
  elsif line[0] == "down"
    y += line[1].to_i 
  elsif line[0] == "up"
    y -= line[1].to_i
  end
end

puts x * y

aim = 0
x = 0
y = 0

# for each line, split the line by spaces and convert the second value to an integer
# if the first value is "forward", add second value to x and add second value * aim to y
# if the first value is "down", add second value to aim
# if the first value is "up", minus second value to aim
# after the for loop, puts x times y
input.each do |line|
  line = line.split(" ")
  if line[0] == "forward"
    x += line[1].to_i
    y += line[1].to_i * aim
  elsif line[0] == "down"
    aim += line[1].to_i
  elsif line[0] == "up"
    aim -= line[1].to_i
  end
end

puts x * y