#!/usr/bin/env node
'use strict'

const fs = require('fs')

const parse = (str) => str
  .trim()
  .split('\n')

const sideA = (arr) => arr
  .reduce((sum, str) => sum + str.length - eval(str).length, 0)

const sideB = (arr) => arr
  .reduce((sum, str) => sum + JSON.stringify(str).length - str.length, 0)

const main = () => {
  const contents = fs.readFileSync('../input/08.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
