#!/usr/bin/env node
'use strict'

const fs = require('fs')

const parse = (str) => str
  .trim()
  .split('\n')
  .map((x) => x
    .split('x')
    .map(x => parseInt(x, 10))
    .sort((x, y) => x - y))

const sideA = (arr) => arr
  .reduce((x, y) => x +
    3 * y[0] * y[1] +
    2 * y[1] * y[2] +
    2 * y[2] * y[0]
    , 0)

const sideB = (arr) => arr
  .reduce((x, y) => x +
    2 * (y[0] + y[1]) +
    y.reduce((x, y) => x * y, 1)
    , 0)

const main = () => {
  const contents = fs.readFileSync('../input/02.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
