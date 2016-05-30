#!/usr/bin/env Rscript

suppressMessages(require(readr))
suppressMessages(require(mgcv))

input <- head(unlist(strsplit(read_file('3.txt'), '')), -1)

north <- c( 0,  1)
east  <- c( 1,  0)
south <- c( 0, -1)
west  <- c(-1,  0)

directions <- list(north, east, south, west)[ match(input, c('^', '>', 'v', '<')) ]

realDirections <- directions[c(TRUE, FALSE)]
roboDirections <- directions[c(FALSE, TRUE)]

realMovements <- do.call(rbind, realDirections)
roboMovements <- do.call(rbind, roboDirections)

realPositions <- cbind(cumsum(realMovements[,1]), cumsum(realMovements[,2]))
roboPositions <- cbind(cumsum(roboMovements[,1]), cumsum(roboMovements[,2]))

positions <- rbind(realPositions, roboPositions)
    
uniquePositions <- uniquecombs(positions)

uniqueHouses <- nrow(uniquePositions)
uniqueHouses
