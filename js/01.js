#!/usr/bin/env node
'use strict'

const fs = require('fs')

const parse = (str) => str
  .trim()
  .split('')
  .map((c) => c === '(' ? 1 : -1)

const sideA = (arr) => arr
  .reduce((a, b) => a + b)

const sideB = (arr) => arr
  .reduce((r, c, i) => {
    r.push((r[i - 1] || 0) + c)
    return r
  }, [])
  .indexOf(-1)

const main = () => {
  const contents = fs.readFileSync('../input/01.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
  return
}

main()
