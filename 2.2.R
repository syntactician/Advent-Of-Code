t <- 0
f <- strsplit(readLines("input.txt"), 'x')
c <- vector("list",(length(f)-1))

for(x in 1:length(c)){
  for(n in 1:length(f[[x]])){
    c[[x]][n] <- strtoi(sort(f[[x]])[n])
  }
  c[[x]] <- l <- sort(c[[x]])
  p <- prod(l) + (l[1] + l[2]) * 2
  t <- t + p
}
print(t)