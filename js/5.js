#!/usr/bin/env node

'use strict'

const fs = require('fs')

function parse (str) {
  return str.split('\n')
}

function sideA (arr) {
  const vowels = /(.*[aeiou]){3}/
  const substrings = /(ab|cd|pq|xy)/
  const doubleLetter = /(.)\1/

  function isNice (str) {
    return str.match(vowels) && !str.match(substrings) && str.match(doubleLetter)
  }

  return arr.filter(isNice).length
}

function sideB (arr) {
  const pair = /(..).*\1/
  const repeater = /(.).\1/

  function isNice (str) {
    return str.match(pair) && str.match(repeater)
  }

  return arr.filter(isNice).length
}

function main () {
  const contents = fs.readFileSync('../5.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
