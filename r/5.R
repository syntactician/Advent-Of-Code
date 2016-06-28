#!/usr/bin/env Rscript

sideA <- function(input) {
    isNice <- function(str) {
        vowels <- '(.*[aeiou]){3}'
        substrings <- '(ab|cd|pq|xy)'
        doubleLetter <- '(.)\\1'

        grepl(vowels, str) & !grepl(substrings, str) & grepl(doubleLetter, str)
    }

    sum(isNice(input))
}

sideB <- function(input) {
    isNice <- function(str) {
        pair <- '(..).*\\1'
        repeater = '(.).\\1'

        grepl(pair, str, perl = TRUE) & grepl(repeater, str)
    }

    sum(isNice(input))
}

main <- function() {
    input <- readLines('../5.txt')
    cat(sideA(input), '\n')
    cat(sideB(input), '\n')
}

main()
