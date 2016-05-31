#!/usr/bin/env Rscript

suppressMessages(require(mgcv))
suppressMessages(require(readr))

input <- head(unlist(strsplit(read_file('../3.txt'), '')), -1)

north <- c( 0,  1)
east  <- c( 1,  0)
south <- c( 0, -1)
west  <- c(-1,  0)

directions <- list(north, east, south, west)[ match(input, c('^', '>', 'v', '<')) ]

movements <- do.call(rbind, directions)

positions <- cbind(cumsum(movements[,1]), cumsum(movements[,2]))
uniquePositions <- uniquecombs(positions)

uniqueHouses <- nrow(uniquePositions)

# 3.2

realDirections <- directions[c(TRUE, FALSE)]
roboDirections <- directions[c(FALSE, TRUE)]

realMovements <- do.call(rbind, realDirections)
roboMovements <- do.call(rbind, roboDirections)

realPositions <- cbind(cumsum(realMovements[,1]), cumsum(realMovements[,2]))
roboPositions <- cbind(cumsum(roboMovements[,1]), cumsum(roboMovements[,2]))

bothPositions <- rbind(realPositions, roboPositions)
    
bothUniquePositions <- uniquecombs(bothPositions)

bothUniqueHouses <- nrow(bothUniquePositions)
bothUniqueHouses
