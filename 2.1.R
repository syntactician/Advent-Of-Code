t <- 0
f <- strsplit(readLines("input.txt"), 'x')

for(x in 1:length(f)){
  p <- rep(NA,3)
  for(n in 1:length(f[[x]])){
    p[n] <- strtoi(f[[x]][n])
  }
  p <- sort(p)
  t <- t + p[1] * p[2] * 3 + p[2] * p[3] * 2 + p[3] * p[1] * 2
}
print(t)