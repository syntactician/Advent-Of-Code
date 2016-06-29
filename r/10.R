#!/usr/bin/env Rscript

library(magrittr)

look.say <- function(input) {
  r <- input %>% strsplit('') %>% unlist %>% rle
  rbind(as.character(r$lengths), r$values) %>% paste(collapse = '')
}

side.a <- function(input) {
  x <- input
  for(i in 1:40) {
    x <- look.say(x)
  }
  nchar(x)
}

side.b <- function(input) {
  x <- input
  for(i in 1:50) {
    x <- look.say(x)
  }
  nchar(x)
}

main <- function() {
    input <- '3113322113'
    cat(side.a(input), '\n')
    cat(side.b(input), '\n')
}

main()
