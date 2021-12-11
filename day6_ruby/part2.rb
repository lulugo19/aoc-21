fishes = File.read("input.txt").split(",").map(&:to_i).inject(Array.new(9, 0)) {|l, e| l[e] += 1; l}

256.times { |i|
  fishes[(i + 7) % fishes.length] += fishes[i % fishes.length]
}

puts fishes.inject(0, :+)