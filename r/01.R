#!/usr/bin/env Rscript

library(readr)

parse <- function(str) {
  ifelse(head(unlist(strsplit(str, '')), -1) == '(', 1, -1)
}

side.a <- sum

side.b <- function(num) {
  min(which(cumsum(num) == -1))
}

main <- function() {
  contents <- read_file('../1.txt')
  input <- parse(contents)
  cat(side.a(input), '\n')
  cat(side.b(input), '\n')
}

main()
