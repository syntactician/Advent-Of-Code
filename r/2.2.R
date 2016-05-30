#!/usr/bin/env Rscript

input <- lapply(strsplit(readLines("2.txt"), 'x'), strtoi)

edgesToRibbon <- function(x) {
    sort(x) -> s # sides
    
    prod(x) + 2 * (s[1] + s[2])
}

totalRibbon <- sum(unlist(lapply(input, edgesToRibbon)))
