#!/usr/bin/env node
'use strict'

const Combinatorics = require('js-combinatorics')
const fs = require('fs')

const parse = (str) => str
  .split('\n')
  .filter((x) => x.length > 0)
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

const sideA = (obj) => {
  const cities = Object.keys(obj)
  const paths = Combinatorics.permutation(cities)

  let least = Number.MAX_VALUE

  for (let i = 0; i < paths.length; ++i) {
    const path = paths.next()
    let d = 0

    for (let j = 0; j < path.length - 1; ++j) {
      d += obj[path[j]][path[j + 1]]
    }

    if (d < least) least = d
  }

  return least
}

const sideB = (obj) => {
  const cities = Object.keys(obj)
  const paths = Combinatorics.permutation(cities)

  let longest = Number.MIN_VALUE

  for (let i = 0; i < paths.length; ++i) {
    const path = paths.next()
    let d = 0

    for (let j = 0; j < path.length - 1; ++j) {
      d += obj[path[j]][path[j + 1]]
    }

    if (d > longest) longest = d
  }

  return longest
}

const main = () => {
  const contents = fs.readFileSync('../input/09.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
