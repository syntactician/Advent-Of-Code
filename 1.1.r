n <- 0
f <- readChar("input.txt", file.info("input.txt")$size)
for(x in 1:nchar(f)){
  c <- substring(f,x,x)
  if(identical("(",c)){
    n <- n + 1
  } else if (identical(")",c)) {
    n <- n - 1
  }
}

print(n)