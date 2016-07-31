#!/usr/bin/env node
'use strict'

const _ = require('underscore')
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

const sideA = (arr) => _.chain(arr)
  .reduce((r, c) => {
    for (let i = 0; i < 2; ++i) r.curr[i] += c[i]
    r[r.curr] = true
    return r
  }, { curr: [0, 0] })
  .reject((x) => typeof x === 'object')
  .size()
  .value()

const sideB = (arr) => _.chain(arr)
  .reduce((r, c, i) => {
    for (let j = 0; j < 2; ++j) r[i % 2][j] += c[j]
    r[r[i % 2]] = true
    return r
  }, { 0: [0, 0], 1: [0, 0] })
  .reject((x) => typeof x === 'object')
  .size()
  .value()

const main = () => {
  const contents = fs.readFileSync('../input/03.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
