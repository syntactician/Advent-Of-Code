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

const sideA = (arr) => {
  let p = [0, 0]
  let positions = {'0,0': 1}

  for (let i = 0; i < arr.length; ++i) {
    for (let j = 0; j < 2; ++j) p[j] += arr[i][j]
    positions[p] = true
  }
  return Object.keys(positions).length
}

const sideB = (arr) => {
  let p = [[0, 0], [0, 0]]
  let positions = {'0,0': 1}

  for (let i = 0; i < arr.length; ++i) {
    for (let j = 0; j < 2; ++j) p[i % 2][j] += arr[i][j]
    positions[p[i % 2]] = true
  }
  return Object.keys(positions).length
}

const main = () => {
  const contents = fs.readFileSync('../input/03.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
  return
}

main()
