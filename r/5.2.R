#!/usr/bin/env Rscript

input <- readLines('5.txt')

pair <- '(..).*\\1'
repeater <- '(.).\\1'

isNice <- function(x) (grepl(pair, x, perl = TRUE) & grepl(repeater, x))

niceStrings <- sum(isNice(input))
