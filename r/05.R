#!/usr/bin/env Rscript

library(magrittr)

side.a <- function(input) {
  is.nice <- function(str) {
    vowels <- '(.*[aeiou]){3}'
    substrings <- '(ab|cd|pq|xy)'
    doubleLetter <- '(.)\\1'

    grepl(vowels, str) & !grepl(substrings, str) & grepl(doubleLetter, str)
  }
  input %>% is.nice %>% sum
}

side.b <- function(input) {
  is.nice <- function(str) {
    pair <- '(..).*\\1'
    repeater = '(.).\\1'

    grepl(pair, str, perl = TRUE) & grepl(repeater, str)
  }
  input %>% is.nice %>% sum
}

main <- function() {
  input <- readLines('../5.txt')
  cat(side.a(input), '\n')
  cat(side.b(input), '\n')
}

main()
