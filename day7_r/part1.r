positions <- scan("input.txt", what = numeric(), sep = ",")
min <- min(positions)
max <- max(positions)

min_abs_sum <- 10000000
x_min <- positions[0]
for (i in min:max) {
  abs_sum <- 0
  for (x in positions) {
    abs_sum <- abs_sum + abs(x - i)
  }
  if (abs_sum < min_abs_sum) {
    x_min <- i
    min_abs_sum <- abs_sum
  }
}

print(x_min)
print(min_abs_sum)