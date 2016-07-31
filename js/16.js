#!/usr/bin/env node
'use strict'

const fs = require('fs')

const clue = {
  akitas: 0,
  cars: 2,
  cats: 7,
  children: 3,
  goldfish: 5,
  perfumes: 1,
  pomeranians: 3,
  samoyeds: 2,
  trees: 3,
  vizslas: 0
}

const parse = (str) => str
  .trim()
  .split('\n')
  .map((x) => {
    const c = x.match(/(\d+|\w+(?=:))/g)
    let r = {'n': c[0]}
    for (let i = 1; i < c.length; i += 2) {
      r[c[i]] = parseInt(c[i + 1], 10)
    }
    return r
  })

const sideA = (arr) => arr
  .filter((x) => Object.keys(x)
    .every((y) => y === 'n'
      ? true
      : x[y] === clue[y]))
  .map((x) => x.n)
  .toString()

const sideB = (arr) => arr
  .filter((x) => Object.keys(x)
    .every((y) => y === 'n'
      ? true
      : y === 'cats' || y === 'trees'
        ? x[y] > clue[y]
        : y === 'pomeranians' || y === 'goldfish'
          ? x[y] < clue[y]
          : x[y] === clue[y]))
  .map((x) => x.n)
  .toString()

const main = () => {
  const contents = fs.readFileSync('../input/16.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
