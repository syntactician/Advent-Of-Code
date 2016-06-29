#!/usr/bin/env Rscript

suppressMessages(library(mgcv))
library(readr)
library(ggplot2)

parse <- function(str) {
  raw.contents <- head(unlist(strsplit(str, '')), -1)

  n <- c(0, 1)
  e <- c(1, 0)
  s <- c(0, -1)
  w <- c(-1, 0)

  contents.list <- list(n, e, s, w)[match(raw.contents, c('^', '>', 'v', '<'))]
  do.call(rbind, contents.list)
}

side.a <- function(input) {
  cbind(cumsum(input[,1]), cumsum(input[,2]))
}

visualize.a <- function(output) {
  positions <- data.frame(x = output[,1], y = output[,2])
  
  ggplot(data = positions) +
    geom_point(size = 1, alpha = 1/3, color = '#C21717',
               aes(x = x, y = y)) +
    guides(color = 'none') +
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

side.b <- function(input) {
  anthro.input <- input[c(TRUE, FALSE),]
  robo.input <- input[c(FALSE, TRUE),]

  anthro.positions <- cbind(cumsum(anthro.input[,1]),
                            cumsum(anthro.input[,2]),
                            0)
  robo.positions <- cbind(cumsum(robo.input[,1]),
                          cumsum(robo.input[,2]),
                          1)

  rbind(anthro.positions, robo.positions)
}

visualize.b <- function(output) {
    positions <- data.frame(x = output[,1], y = output[,2],
                            santa = factor(output[,3], levels = c(0, 1),
                                           labels = c('Santa', 'Robo-Santa')))

  ggplot(data = positions) + 
    geom_point(size = 1, alpha = 1/3, aes(x = x, y = y, color = santa)) + 
    guides(color = guide_legend(override.aes = list(size = 5, alpha = 1))) +
    scale_color_manual(values = c('#C21717', '#3C8D0D')) + 
    theme(axis.line=element_blank(),
            axis.text.x=element_blank(),
            axis.text.y=element_blank(),
            axis.ticks=element_blank(),
            axis.title.x=element_blank(),
            axis.title.y=element_blank(),
            legend.justification = c(1, 0),
            legend.key = element_blank(),
            legend.position = c(1, 0),
            legend.title = element_blank(),
            panel.background = element_blank(),
            panel.background=element_blank(),
            panel.border=element_blank(),
            panel.grid.major=element_blank(),
            panel.grid.minor=element_blank(),
            plot.background=element_blank(),
            plot.margin = unit(c(0, 0, 0, 0), 'mm'))
}

main <- function() {
  contents <- read_file('../3.txt')
  input <- parse(contents)
  
  output.a <- side.a(input)
  suppressMessages(ggsave('3a.png', visualize.a(output.a)))

  output.b <- side.b(input)
  suppressMessages(ggsave('3b.png', visualize.b(output.b)))
}

main()
