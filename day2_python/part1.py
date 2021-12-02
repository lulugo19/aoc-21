def parse_line(line):
  cmd, step = line.split(" ")
  return (cmd, int(step))

file = open("input.txt", "r")
input = file.read()
file.close()

depth = 0
x = 0
for (cmd, step) in map(parse_line, input.splitlines()):
  if cmd == "forward":
    x = x + step
  elif cmd == "down":
    depth = depth + step
  elif cmd == "up":
    depth = depth - step

result = x * depth
print(result)