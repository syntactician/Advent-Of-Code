#!/usr/bin/env node
'use strict'

const fs = require('fs')

const parse = (str) => str
  .trim()
  .split('')
  .map((x) => ({
    '^': [0, 1],
    '>': [1, 0],
    'v': [0, -1],
    '<': [-1, 0]
  }[x]))

const sideA = (arr) => Object.keys(arr
    .reduce((r, c) => {
      for (let i = 0; i < 2; ++i) r.curr[i] += c[i]
      r[r.curr] = true
      return r
    }, { curr: [0, 0] }))
    .length - 1

const sideB = (arr) => Object.keys(arr
    .reduce((r, c, i) => {
      for (let j = 0; j < 2; ++j) r[i % 2][j] += c[j]
      r[r[i % 2]] = true
      return r
    }, { 0: [0, 0], 1: [0, 0] }))
    .length - 2

const main = () => {
  const contents = fs.readFileSync('../input/03.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
