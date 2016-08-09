#!/usr/bin/env node
'use strict'

const Combinatorics = require('js-combinatorics')
const fs = require('fs')

const parse = (str) => str
  .trim()
  .split('\n')
  .map((x) => x.split(/ to | = /))
  .reduce((x, y) => {
    for (let j = 0; j < 2; ++j) {
      if (!x.hasOwnProperty(y[j])) {
        x[y[j]] = {}
      }
      x[y[j]][y[Math.abs(j - 1)]] = parseInt(y[2], 10)
    }
    return x
  }, {})

const solve = (obj) => {
  const cities = Object.keys(obj)
  const paths = Combinatorics.permutation(cities)

  let least = Number.MAX_VALUE
  let longest = Number.MIN_VALUE

  for (let i = 0; i < paths.length; ++i) {
    const path = paths.next()
    let d = 0

    for (let j = 0; j < path.length - 1; ++j) {
      d += obj[path[j]][path[j + 1]]
    }

    if (d < least) least = d
    if (d > longest) longest = d
  }

  return [least, longest]
}

const main = () => {
  const contents = fs.readFileSync('../input/09.txt', 'utf8')
  const input = parse(contents)
  const [a, b] = solve(input)
  console.log(a)
  console.log(b)
}

main()
