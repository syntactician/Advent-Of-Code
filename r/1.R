#!/usr/bin/env Rscript

suppressMessages(require(readr))

input <- read_file("../1.txt")

inputVector <- head(unlist(strsplit(input, '')), -1) # remove trailing newline
floorChanges <- ifelse(inputVector == '(', 1, -1)

endingFloor <- sum(floorChanges) # 1.1
firstBasement <- min(which(cumsum(floorChanges) == -1)) # 1.2
