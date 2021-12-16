positions <- scan("input.txt", what = numeric(), sep = ",")
min <- min(positions)
max <- max(positions)

min_abs_sum <- 10000000000000
x_min <- positions[0]
for (i in min:max) {
  abs_sum <- 0
  for (x in positions) {
    n <- abs(x - i)
    abs_sum <- abs_sum + n * (n + 1) / 2
  }
  if (abs_sum < min_abs_sum) {
    x_min <- i
    min_abs_sum <- abs_sum
  }
}

print(min_abs_sum)