#!/usr/bin/env node
'use strict'

const fs = require('fs')

const parse = (str) => str.split('\n')

const sideA = (arr) => arr.filter((str) => {
  const vowels = /(.*[aeiou]){3}/
  const substrings = /(ab|cd|pq|xy)/
  const doubleLetter = /(.)\1/

  return str.match(vowels) && !str.match(substrings) && str.match(doubleLetter)
}).length

// function sideB (arr) {
const sideB = (arr) => arr.filter((str) => {
  const pair = /(..).*\1/
  const repeater = /(.).\1/

  return str.match(pair) && str.match(repeater)
}).length

const main = () => {
  const contents = fs.readFileSync('../5.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
  return
}

main()
