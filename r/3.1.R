#!/usr/bin/env Rscript

suppressMessages(require(readr))
suppressMessages(require(mgcv))

input <- head(unlist(strsplit(read_file('3.txt'), '')), -1)

north <- c( 0,  1)
east  <- c( 1,  0)
south <- c( 0, -1)
west  <- c(-1,  0)

directions <- list(north, east, south, west)[ match(input, c('^', '>', 'v', '<')) ]

movements <- do.call(rbind, directions)

positions <- cbind(cumsum(movements[,1]), cumsum(movements[,2]))
uniquePositions <- uniquecombs(positions)

uniqueHouses <- nrow(uniquePositions)
uniqueHouses
