#!/usr/bin/env node
'use strict'

const fs = require('fs')

const rle = (str) => str
  .replace(/(.)\1*/g, (seq, pl) => seq.length.toString() + pl)

const sideA = (str) => {
  let x = str
  for (let i = 0; i < 40; ++i) {
    x = rle(x)
  }
  return x.length
}

const sideB = (str) => {
  let x = str
  for (let i = 0; i < 50; ++i) {
    x = rle(x)
  }
  return x.length
}

const main = () => {
  const input = fs.readFileSync('../input/10.txt', 'utf8').trim()
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
