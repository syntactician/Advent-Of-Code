#!/usr/bin/env Rscript

input <- lapply(strsplit(readLines("../2.txt"), 'x'), strtoi)

edgesToPaper <- function(x) {
    sort(x) -> s #sides
    # 3 of the smallest side, 2 of each other
    (3 * s[1] * s[2]) + (2 * s[2] * s[3]) + (2 * s[3] * s[1])
}

totalPaper <- sum(unlist(lapply(input, edgesToPaper)))

edgesToRibbon <- function(x) {
    sort(x) -> s # sides
    
    prod(x) + 2 * (s[1] + s[2])
}

totalRibbon <- sum(unlist(lapply(input, edgesToRibbon)))
