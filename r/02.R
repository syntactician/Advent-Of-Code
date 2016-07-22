#!/usr/bin/env Rscript --vanilla

library(magrittr)

parse <- function(contents) {
  contents %>% strsplit('') %>% lapply(strtoi)
}

side.a <- function(input) {
  wrap <- function(dims) {
    d <- sort(dims)
    3 * d[1] * d[2] + 2 * d[2] * d[3] + 2 * d[3] * d[1]
  }
  input %>% lapply(wrap) %>% unlist %>% sum
}

side.b <- function(input) {
  tie <- function(dims) {
    d <- sort(dims)
    prod(d) + 2 * (d[1] + d[2])
  }
  input %>% lapply(tie) %>% unlist %>% sum
}

main <- function() {
  contents <- readLines('../input/02.txt')
  input <- parse(contents)
  cat(side.a(input), "\n")
  cat(side.b(input), "\n")
}

main()
