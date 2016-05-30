#!/usr/bin/env Rscript

suppressMessages(require(digest))

input <- 'ckczppom'

mine <- function(x) substr(digest(x, algo='md5', serialize=FALSE), 1, 5)

sift <- function(x) {
    ore <- mine(input)
    i <- 0

    while (ore != '00000') {
        i <- i + 1
        ore <- mine(paste(x, i, sep = ''))
    }
    i
}

coin <- sift(input)
