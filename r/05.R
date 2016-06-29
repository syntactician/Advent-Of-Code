#!/usr/bin/env Rscript

side.a <- function(input) {
  isNice <- function(str) {
    vowels <- '(.*[aeiou]){3}'
    substrings <- '(ab|cd|pq|xy)'
    doubleLetter <- '(.)\\1'

    grepl(vowels, str) & !grepl(substrings, str) & grepl(doubleLetter, str)
  }

  sum(isNice(input))
}

side.b <- function(input) {
  isNice <- function(str) {
    pair <- '(..).*\\1'
    repeater = '(.).\\1'

    grepl(pair, str, perl = TRUE) & grepl(repeater, str)
  }

  sum(isNice(input))
}

main <- function() {
  input <- readLines('../5.txt')
  cat(side.a(input), '\n')
  cat(side.b(input), '\n')
}

main()
