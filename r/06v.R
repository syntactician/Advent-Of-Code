#!/usr/bin/env Rscript

library(animation)
library(ggplot2)

parse <- function(contents) {
  parseLine <- function(line) {
    words <- unlist(strsplit(line, ' '))

    if (words[1] == 'turn') {
      instruction <- paste0(words[1], words[2])
      optind <- 3
    } else {
      instruction <- words[1]
      optind <- 2
    }

    x0 <- as.numeric(unlist(strsplit(words[optind], ','))[1]) + 1
    x1 <- as.numeric(unlist(strsplit(words[optind+2], ','))[1]) + 1

    y0 <- as.numeric(unlist(strsplit(words[optind], ','))[2]) + 1
    y1 <- as.numeric(unlist(strsplit(words[optind+2], ','))[2]) + 1

    data.frame(instruction, x0, x1, y0, y1)
  }

  do.call(rbind, lapply(contents, parseLine))
}

mutate.a <- function(input) {
  lights <- matrix(data = FALSE, nrow = 1000, ncol = 1000)

  follow.instruction <- function(r) {
    type <- r[1]
    x0 <- r[2]
    x1 <- r[3]
    y0 <- r[4]
    y1 <- r[5]

    if (type == 'turnon') {
      lights[y0:y1, x0:x1] <<- TRUE
    } else if (type == 'turnoff') {
      lights[y0:y1, x0:x1] <<- FALSE
    } else if (type == 'toggle') {
      lights[y0:y1, x0:x1] <<- !lights[y0:y1, x0:x1]
    }
  }

  apply(input, 1, follow.instruction)

  data.frame(x = as.vector(row(lights)),
             y = as.vector(col(lights)),
             state = as.vector(lights))
}

visualize.a <- function(a) {
  ggplot(a) +
    geom_tile(aes(x = x, y = y, fill = state)) +
    scale_fill_manual(values = c('#3C8D0D', '#C21717')) +
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

iterate.a <- function(input, i) {
  lights <- matrix(data = FALSE, nrow = 1000, ncol = 1000)
  
  follow.instruction <- function(r) {
    type <- r[1]
    x0 <- r[2]
    x1 <- r[3]
    y0 <- r[4]
    y1 <- r[5]
    
    if (type == 'turnon') {
      lights[y0:y1, x0:x1] <<- TRUE
    } else if (type == 'turnoff') {
      lights[y0:y1, x0:x1] <<- FALSE
    } else if (type == 'toggle') {
      lights[y0:y1, x0:x1] <<- !lights[y0:y1, x0:x1]
    }
  }
  
  if (i > 0) apply(input[1:i, ], 1, follow.instruction)

  df <- data.frame(x = as.vector(row(lights)),
                   y = as.vector(col(lights)),
                   state = as.vector(lights))
  
  g <- ggplot(df) +
    geom_tile(aes(x = x, y = y, fill = state)) +
    scale_fill_manual(values = c('#3C8D0D', '#C21717')) +
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
  lights <- matrix(data = 0, nrow = 1000, ncol = 1000)
  
  follow.instruction <- function(r) {
    type <- r[1]
    x0 <- r[2]
    x1 <- r[3]
    y0 <- r[4]
    y1 <- r[5]

    if (type == 'turnon') {
      lights[y0:y1, x0:x1] <<- lights[y0:y1, x0:x1] + 1
    } else if (type == 'turnoff') {
      lights[y0:y1, x0:x1] <<- lights[y0:y1, x0:x1] - 1
    } else if (type == 'toggle') {
      lights[y0:y1, x0:x1] <<- lights[y0:y1, x0:x1] + 2
    }
    lights[lights < 0] <<- 0
  }

  apply(input, 1, follow.instruction)
  
  data.frame(x = as.vector(row(lights)),
             y = as.vector(col(lights)),
             brightness = as.vector(lights))
}

visualize.b <- function(b) {
  ggplot(b) +
    geom_tile(aes(x = x, y = y, fill = brightness)) +
    scale_x_continuous() +
    scale_y_continuous() +
    scale_fill_gradient(low = '#3C8D0D', high = '#C21717') +
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

iterate.b <- function(input, i) {
  lights <- matrix(data = 0, nrow = 1000, ncol = 1000)
  
  follow.instruction <- function(r) {
    type <- r[1]
    x0 <- r[2]
    x1 <- r[3]
    y0 <- r[4]
    y1 <- r[5]
    
    if (type == 'turnon') {
      lights[y0:y1, x0:x1] <<- lights[y0:y1, x0:x1] + 1
    } else if (type == 'turnoff') {
      lights[y0:y1, x0:x1] <<- lights[y0:y1, x0:x1] - 1
    } else if (type == 'toggle') {
      lights[y0:y1, x0:x1] <<- lights[y0:y1, x0:x1] + 2
    }
    lights[lights < 0] <<- 0
  }
  
  if (i > 0) apply(input[1:i, ], 1, follow.instruction)
  
  df <- data.frame(x = as.vector(row(lights)),
                   y = as.vector(col(lights)),
                   brightness = as.vector(lights))
  
  g <- ggplot(df) +
    geom_tile(aes(x = x, y = y, fill = brightness)) +
    scale_x_continuous() +
    scale_y_continuous() +
    scale_fill_gradient(limits = c(0, 49), low = '#3C8D0D', high = '#C21717') +
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

main <- function() {
  contents <- readLines('../6.txt')
  input <- parse(contents)
  
  vd.opts <- '-pix_fmt yuv420p -r 30 -s:v 720x720 -profile:v high -c:v libx264'
  
  a <- mutate.a(input)
  suppressMessages(ggsave('6a.png', visualize.a(a)))
  saveVideo({
    for (i in 0:nrow(input)) iterate.a(input, i)
  }, interval = 20/nrow(input), other.opts = vd.opts, video.name = '06a.mp4')
  
  b <- mutate.b(input)
  suppressMessages(ggsave('6b.png', visualize.b(b)))
  saveVideo({
    for (i in 0:nrow(input)) iterate.b(input, i)
  }, interval = 20/nrow(input), other.opts = vd.opts, video.name = '06b.mp4')
}

main()
