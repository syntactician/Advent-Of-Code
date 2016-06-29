#!/usr/bin/env Rscript

library(magrittr)
library(readr)

parse <- function(str) {
  input.chars <- str %>% strsplit('') %>% unlist %>% head(-1)
  ifelse(input.chars == '(', 1, -1)
}

side.a <- sum

side.b <- function(num) {
  which(cumsum(num) == -1) %>% min
}

main <- function() {
  contents <- read_file('../1.txt')
  input <- parse(contents)
  cat(side.a(input), '\n')
  cat(side.b(input), '\n')
}

main()
