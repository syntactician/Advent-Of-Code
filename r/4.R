#!/usr/bin/env Rscript

suppressMessages(require(digest))

input <- 'ckczppom'

mine <- function(x, length) substr(digest(x, algo='md5', serialize=FALSE), 1, length)

sift <- function(x, prefix) {
    length <- nchar(prefix)
    ore <- mine(x, length)
    i <- 0

    while (ore != prefix) {
        i <- i + 1
        ore <- mine(paste(x, i, sep = ''), length)
    }
    i
}

fiveCoin <- sift(input, '00000')
sixCoin <- sift(input, '000000')
