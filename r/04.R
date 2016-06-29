#!/usr/bin/env Rscript

library(digest)
library(magrittr)

mine <- function(input, test) {
  length <- nchar(test)
  getHash <- function(x) {
    input %>% paste0(x) %>%
      digest(algo = 'md5', serialize = FALSE) %>%
      substr(1, length)
  }

  i <- 1
  while (getHash(i) != test) {
    i <- i + 1
  }
  i
}

side.a <- function(input) {
  mine(input, '00000')
}

side.b <- function(input) {
  mine(input, '000000')
}

main <- function() {
  input <- 'ckczppom'
  cat(side.a(input), '\n')
  cat(side.b(input), '\n')
}

main()
