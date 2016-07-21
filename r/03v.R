#!/usr/bin/env Rscript

library(animation)
library(ggplot2)
library(readr)

parse <- function(str) {
  raw.contents <- head(unlist(strsplit(str, '')), -1)

  n <- c(0, 1)
  e <- c(1, 0)
  s <- c(0, -1)
  w <- c(-1, 0)

  contents.list <- list(n, e, s, w)[match(raw.contents, c('^', '>', 'v', '<'))]
  do.call(rbind, contents.list)
}

mutate.a <- function(input) {
  data.frame(x = cumsum(input[,1]), y = cumsum(input[,2]))
}

visualize.a <- function(a) {
  ggplot(data = a) +
    geom_point(size = 1, alpha = 1/3, color = '#C21717',
               aes(x = x, y = y)) +
    guides(color = 'none') +
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

iterate.a <- function(a, i) {
  df <- a[1:i, ]
    
  g <- ggplot(data = df) +
    geom_point(size = 1, alpha = 1/3, color = '#C21717',
               aes(x = x, y = y)) +
    guides(color = 'none') +
    scale_x_continuous(limits = c(-79, 38)) +
    scale_y_continuous(limits = c(-48, 43)) +
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
  print(g)
}

mutate.b <- function(input) {
  anthro.input <- input[c(TRUE, FALSE),]
  robo.input <- input[c(FALSE, TRUE),]

  anthro.positions <- data.frame(x = cumsum(anthro.input[,1]),
                                 y = cumsum(anthro.input[,2]),
                                 santa = 'Santa')
  robo.positions <- data.frame(x = cumsum(robo.input[,1]),
                               y = cumsum(robo.input[,2]),
                               santa = 'Robo-Santa')

  rbind(anthro.positions, robo.positions)
}

visualize.b <- function(b) {
  ggplot(data = b) + 
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

iterate.b <- function(b, i) {
  df <- rbind(b[1:i, ], b[4097:(4096+i), ])
  
  g <- ggplot(data = df) +
    geom_point(size = 1, alpha = 1/3, aes(x = x, y = y, color = santa)) + 
    guides(color = guide_legend(override.aes = list(size = 5, alpha = 1))) +
    scale_color_manual(values = c('#C21717', '#3C8D0D')) + 
    scale_x_continuous(limits = c(-42, 31)) +
    scale_y_continuous(limits = c(-52, 70)) +
    theme(axis.line = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          legend.justification = c(1, 0),
          legend.key = element_blank(),
          legend.position = c(1, 0),
          legend.title = element_blank(),
          panel.background = element_blank(),
          panel.border = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          plot.background = element_blank(),
          plot.margin = unit(c(0, 0, 0, 0), 'mm'))
  print(g)
}

main <- function() {
  contents <- read_file('../3.txt')
  input <- parse(contents)
  
  vd.opts <- '-pix_fmt yuv420p -r 30 -s:v 720x720 -profile:v high -c:v libx264'
  
  a <- mutate.a(input)
  suppressMessages(ggsave('3a.png', visualize.a(a)))
  suppressMessages(saveVideo({
    for (i in 1:nrow(a)) iterate.a(a, i)
  }, interval = 0.0025, other.opts = vd.opts, video.name = '03a.mp4'))


  b <- mutate.b(input)
  suppressMessages(ggsave('3b.png', visualize.b(b)))
  suppressMessages(saveVideo({
    for (i in 1:(nrow(b)/2)) iterate.b(b, i)
  }, interval = 0.005, other.opts = vd.opts, video.name = '03b.mp4'))
}

main()
