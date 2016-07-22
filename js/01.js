#!/usr/bin/env node
'use strict'

const fs = require('fs')

const parse = (str) => str.split('')
  .map((c) => c === '(' ? 1 : c === ')' ? -1 : 0)

const sideA = (arr) => arr.reduce((a, b) => a + b)

const sideB = (arr) => {
  for (let floor = 0, i = 0; i < arr.length; floor += arr[i], ++i) {
    if (floor < 0) {
      return i
    }
  }
}

const main = () => {
  const contents = fs.readFileSync('../input/01.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
  return
}

main()
