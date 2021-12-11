fishes = File.read("input.txt").split(",").map(&:to_i)
80.times {
  len = fishes.length
  for i in 0...fishes.length do
    fishes[i] -= 1
    if fishes[i] == -1 then 
      fishes[i] = 6
      fishes << 8
    end
  end
}

puts fishes.length