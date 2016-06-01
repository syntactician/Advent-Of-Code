#!/usr/bin/env Rscript

input <- readLines('5.txt')

vowels <- '(.*[aeiou]){3}'
substrings <- '(ab|cd|pq|xy)'
doubleLetter <- '(.)\\1'

isNice <- function(x) (grepl(vowels, x) & !grepl(substrings, x) & grepl(doubleLetter, x))

niceStrings <- sum(isNice(input))


pair <- '(..).*\\1'
repeater <- '(.).\\1'

isReallyNice <- function(x) (grepl(pair, x, perl = TRUE) & grepl(repeater, x))

niceStrings <- sum(isReallyNice(input))
