n <- 0
t <- TRUE
f <- readChar("input.txt", file.info("input.txt")$size)
for(x in 1:nchar(f)){
  c <- substring(f,x,x)
  if(identical("(",c)){
    n <- n + 1
  } else if (identical(")",c)) {
    n <- n - 1
  }
  if(n < 0 && t) {
    print(x)
    t <- FALSE
  }
}