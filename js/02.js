#!/usr/bin/env node
'use strict'

const fs = require('fs')

const parse = (str) => str.split('\n')
  .filter(w => w.length > 0)
  .map((x) => x
    .split('x')
    .map(x => parseInt(x, 10))
    .sort((y, z) => y - z))

const sideA = (arr) => {
  const wrap = (d) => 3 * d[0] * d[1] + 2 * d[1] * d[2] + 2 * d[2] * d[0]
  return arr.reduce((x, y) => x + wrap(y), 0)
}

const sideB = (arr) => {
  const tie = (d) => 2 * (d[0] + d[1]) + d.reduce((x, y) => x * y, 1)
  return arr.reduce((x, y) => x + tie(y), 0)
}
const main = () => {
  const contents = fs.readFileSync('../input/02.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
  return
}

main()
