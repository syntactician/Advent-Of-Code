#!/usr/bin/env Rscript

library(readr)

parse <- function(str) {
    ifelse(head(unlist(strsplit(str, "")), -1) == '(', 1, -1)
}

sideA <- sum

sideB <- function(num) {
    min(which(cumsum(num) == -1))
}

main <- function() {
    contents <- read_file("../1.txt")
    input <- parse(contents)
    cat(sideA(input), "\n")
    cat(sideB(input), "\n")
}

main()
