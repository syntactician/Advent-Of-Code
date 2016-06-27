#!/usr/bin/env node

'use strict'

const Promise = require('bluebird')
const fs = Promise.promisifyAll(require('fs'))

function preprocess (str) {
  return str.split('')
    .map((c) => c === '(' ? 1 : c === ')' ? -1 : 0)
}

function sideA (arr) {
  return arr.reduce((a, b) => a + b)
}

function sideB (arr) {
  let floor = 0
  for (let i = 0; i < arr.length; ++i) {
    if (floor < 0) {
      return i
    }
    floor += arr[i]
  }
}

function main () {
  fs.readFileAsync('1.txt', 'utf8').then(function (contents) {
    const flights = preprocess(contents)
    sideA(flights)
    sideB(flights)
  }).catch(function (e) {
    console.error(e.stack)
  })
}
}

main()
