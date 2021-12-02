def parse_line(line):
  cmd, step = line.split(" ")
  return (cmd, int(step))

file = open("input.txt", "r")
input = file.read()
file.close()

depth = 0
x = 0
aim = 0
for (cmd, step) in map(parse_line, input.splitlines()):
  if cmd == "forward":
    x = x + step
    depth = depth + aim * step
  elif cmd == "down":
    aim = aim + step
  elif cmd == "up":
    aim = aim - step

result = x * depth
print(result)