#!/usr/bin/env node
'use strict'

const _ = require('underscore')
const fs = require('fs')

const sideA = (obj) => _.chain(obj)
  .reduce((x, y) => typeof y === 'object'
    ? x + sideA(y)
    : typeof y === 'number'
      ? x + y
      : x
    , 0)
  .value()

const sideB = (obj) => _.chain(obj)
  .reduce((x, y) => typeof y === 'object'
    ? Array.isArray(y)
      ? x + sideB(y)
      : _.every(y, (x) => x !== 'red')
        ? x + sideB(y)
        : x
    : typeof y === 'number'
      ? x + y
      : x
    , 0)
  .value()

const main = () => {
  const contents = fs.readFileSync('../input/12.json', 'utf8')
  const input = JSON.parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
