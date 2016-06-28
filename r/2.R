#!/usr/bin/env Rscript

parse <- function(contents) {
  lapply(strsplit(contents, 'x'), strtoi)
}

side.a <- function(input) {
  wrap <- function(dims) {
    d <- sort(dims)
    3 * d[1] * d[2] + 2 * d[2] * d[3] + 2 * d[3] * d[1]
  }

  sum(unlist(lapply(input, wrap)))
}

side.b <- function(input) {
  tie <- function(dims) {
    d <- sort(dims)
    prod(d) + 2 * (d[1] + d[2])
  }

  sum(unlist(lapply(input, tie)))
}

main <- function() {
  contents <- readLines('../2.txt')
  input <- parse(contents)
  cat(side.a(input), "\n")
  cat(side.b(input), "\n")
}

main()
