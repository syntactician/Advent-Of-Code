#!/usr/bin/env Rscript

parse <- function(contents) {
  parseLine <- function(line) {
    words <- unlist(strsplit(line, ' '))

    if (words[1] == 'turn') {
      instruction <- paste(words[1], words[2], sep = '')
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

side.a <- function(input) {
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
  sum(lights)
}

side.b <- function(input) {
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
  sum(lights)
}

main <- function() {
    contents <- readLines('../6.txt')
    input <- parse(contents)
    cat(side.a(input), '\n')
    cat(side.b(input), '\n')
}

main()
