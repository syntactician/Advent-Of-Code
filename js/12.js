#!/usr/bin/env node
'use strict'

const fs = require('fs')

const parse = JSON.parse

const sideA = (obj) => {
  const sumNums = (x, y) => typeof (y) === 'object'
    ? Array.isArray(y)
      ? x + y.reduce(sumNums, 0)
      : x + sideA(y)
    : typeof (y) === 'number'
      ? x + y
      : x

  return Object.keys(obj)
    .map((x) => obj[x])
    .reduce(sumNums, 0)
}

const sideB = (obj) => {
  const objToArray = (x) => Object.keys(x)
    .map((y) => x[y])

  const sumNums = (x, y) => typeof (y) === 'object'
    ? Array.isArray(y)
      ? x + y.reduce(sumNums, 0)
      : objToArray(y).every((z) => z !== 'red')
        ? x + sideB(y)
        : x
    : typeof (y) === 'number'
      ? x + y
      : x

  const arr = objToArray(obj)

  return arr.every((x) => x !== 'red')
    ? arr.reduce(sumNums, 0)
    : 0
}

const main = () => {
  const contents = fs.readFileSync('../12.json', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
