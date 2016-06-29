#!/usr/bin/env Rscript

library(ggplot2)
library(readr)

parse <- function(str) {
  flights <- append(ifelse(head(unlist(strsplit(str, '')), -1) == '(',
                           1, -1),
                    0, 0)
  data.frame(x = 1:length(flights), y = cumsum(flights))
}

visualize <- function(input) {
  ggplot(data = input) +
    geom_hline(yintercept = 0, color = '#3C8D0D') +
    geom_line(aes(x = x, y = y), color = '#C21717') +
    theme( axis.line = element_blank(),
           axis.text.x = element_blank(),
           axis.text.y = element_blank(),
           axis.ticks = element_blank(),
           axis.title.x = element_blank(),
           axis.title.y = element_blank(),
           legend.position = 'none',
           panel.background = element_blank(),
           panel.border = element_blank(),
           panel.grid.major = element_blank(),
           panel.grid.minor = element_blank(),
           plot.background = element_blank(),
           plot.margin = unit(c(0, 0, 0, 0), 'mm'))
}

main <- function() {
  contents <- read_file('../1.txt')
  input <- parse(contents)
  
  suppressMessages(ggsave('1.png', visualize(input)))
}

main()
