#!/usr/bin/env node

'use strict'

const fs = require('fs')

function parse (str) {
  return str.split('')
    .map((c) => c === '(' ? 1 : c === ')' ? -1 : 0)
}

function sideA (arr) {
  return arr.reduce((a, b) => a + b)
}

function sideB (arr) {
  let floor = 0
  for (let i = 0; i < arr.length; ++i) {
    if (floor < 0) {
      return i
    }
    floor += arr[i]
  }
}

function main () {
  const contents = fs.readFileSync('../1.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
