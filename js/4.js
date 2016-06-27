#!/usr/bin/env node

'use strict'

const Promise = require('bluebird')
// const hash = Promise.promisify(require('md5'))
const hash = require('md5')
const fs = Promise.promisifyAll(require('fs'))

function preprocess (str) {
  return str.slice(0, -1)
}

function mine (vein, test) {
  const length = test.length

  function sift (x) {
    return hash(x).slice(0, length)
  }
  let i = 0

  for (let ore = sift(vein); ore != test; ore = sift(vein + i), ++i)
    continue
  return i - 1
}

function sideA (str) {
  return mine(str, '00000')
}

function sideB (str) {
  return mine(str, '000000')
}

function main () {
  fs.readFileAsync('../4.txt', 'utf8').then(function (contents) {
    const vein = preprocess(contents)
    console.log(sideA(vein))
    console.log(sideB(vein))
  }).catch(function (e) {
    console.error(e.stack)
  })
}

main()

// hash('test').then(function (digest) {
//   console.log(digest)
// }).catch(function (e) {
//   console.error(e.stack)
// })
