#!/usr/bin/env node

'use strict'

const Promise = require('bluebird')
const fs = Promise.promisifyAll(require('fs'))

function preprocess (str) {
  let arr = str.split('\n')
    .map((x) => x
      .split('x')
      .map(x => parseInt(x, 10))
      .sort((y, z) => y - z))
  // trailing newline
  arr.pop()
  return arr
}

function sideA (arr) {
  function wrap (d) {
    return 3 * d[0] * d[1] + 2 * d[1] * d[2] + 2 * d[2] * d[0]
  }
  return arr.reduce((x, y) => wrap(y) + x, 0)
}

function sideB (arr) {
  function tie (d) {
    return d.reduce((x, y) => x * y, 1) + 2 * (d[0] + d[1])
  }
  return arr.reduce((x, y) => x + tie(y), 0)
}

function main () {
  fs.readFileAsync('../2.txt', 'utf8').then(function (contents) {
    const dims = preprocess(contents)
    console.log(sideA(dims))
    console.log(sideB(dims))
  }).catch(function (e) {
    console.error(e.stack)
  })
}

main()
