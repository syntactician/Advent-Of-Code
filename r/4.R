#!/usr/bin/env Rscript

library(digest)

mine <- function(input, test) {
    length <- nchar(test)
    getHash <- function(x) {
        substr(digest(paste(input, x, sep = ''),
                      algo = 'md5', serialize = FALSE),
               1, length)
    }

    i <- 1
    while (getHash(i) != test) {
        i <- i + 1
    }
    i
}

sideA <- function(input) {
    mine(input, '00000')
}

sideB <- function(input) {
    mine(input, '000000')
}

main <- function() {
    input <- 'ckczppom'
    cat(sideA(input), '\n')
    cat(sideB(input), '\n')
}

main()
