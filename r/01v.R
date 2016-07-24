#!/usr/bin/env Rscript --vanilla

library(ggplot2)
library(magrittr)
library(readr)

parse <- function(str) {
  input.chars <- str %>% strsplit('') %>% unlist %>% head(-1)
  flights <- ifelse(input.chars == '(', 1, -1) %>% append(0, 0)
  data.frame(x = 1:length(flights), y = cumsum(flights))
}

visualize <- function(input) {
  ggplot(input) +
    geom_hline(yintercept = 0, color = '#3C8D0D', alpha = 1/3) +
    annotate('rect', xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = 0, 
             fill = '#3C8D0D', alpha = 1/3) +
    geom_line(aes(x = x, y = y), color = '#C21717') +
    theme(axis.line = element_blank(),
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
  contents <- read_file('../input/01.txt')
  input <- parse(contents)
  
  suppressMessages(ggsave('1.png', visualize(input)))
}

main()
