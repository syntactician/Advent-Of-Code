#!/usr/bin/env node

'use strict'

const hash = require('md5')
const fs = require('fs')

function parse (str) {
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
  const contents = fs.readFileSync('../4.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
