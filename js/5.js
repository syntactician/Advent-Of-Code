#!/usr/bin/env node

'use strict'

const Promise = require('bluebird')
const fs = Promise.promisifyAll(require('fs'))

function preprocess (str) {
  return str.split('\n')
}

function sideA (arr) {
  const vowels = /(.*[aeiou]){3}/
  const substrings = /(ab|cd|pq|xy)/
  const doubleLetter = /(.)\1/

  function isNice (str) {
    return str.match(vowels) && !str.match(substrings) && str.match(doubleLetter)
  }

  return arr.filter(isNice).length
}

function sideB (arr) {
  const pair = /(..).*\1/
  const repeater = /(.).\1/

  function isNice (str) {
    return str.match(pair) && str.match(repeater)
  }

  return arr.filter(isNice).length
}

function main () {
  fs.readFileAsync('../5.txt', 'utf8').then(function (contents) {
    const strings = preprocess(contents)
    console.log(sideA(strings))
    console.log(sideB(strings))
  }).catch(function (e) {
    console.error(e.stack)
  })
}

main()
