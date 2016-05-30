#!/usr/bin/env Rscript

suppressMessages(require(digest))

input <- 'ckczppom'
key <- '000000'

mine <- function(x, length) substr(digest(x, algo='md5', serialize=FALSE), 1, length)

sift <- function(x, prefix) {
    length <- nchar(prefix)

    ore <- mine(x, length)
    i <- 0

    while (ore != prefix) {
        i <- i + 1
        ore <- mine(paste(x, i, sep = ''), length)

        print(i)
        print(ore)
    }
    i
}

coin <- sift(input, key)
