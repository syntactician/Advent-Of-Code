#!/usr/bin/env node
'use strict'

const md5 = require('md5')
const fs = require('fs')

const mine = (input, test) => {
  const hash = (str) => md5(str).slice(0, test.length)

  let i = 0
  while (hash(input + i) !== test) ++i
  return i
}

const sideA = (str) => mine(str, '00000')

const sideB = (str) => mine(str, '000000')

const main = () => {
  const input = fs.readFileSync('../input/04.txt', 'utf8').trim()
  console.log(sideA(input))
  console.log(sideB(input))
  return
}

main()
