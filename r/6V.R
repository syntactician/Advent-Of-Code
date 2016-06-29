#!/usr/bin/env Rscript

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
    scale_fill_manual(values = c('#C21717', '#3C8D0D')) +
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
    scale_fill_gradient(low = '#C21717', high = '#3C8D0D') +
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
    contents <- readLines('../6.txt')
    input <- parse(contents)

    a <- mutate.a(input)
    suppressMessages(ggsave('6a.png', visualize.a(a)))

    b <- mutate.b(input)
    suppressMessages(ggsave('6b.png', visualize.b(b)))
}

main()
