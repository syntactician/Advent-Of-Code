#!/usr/bin/env node
'use strict'

const fs = require('fs')

const iterateStr = (str) => (parseInt(str, 36) + 1)
  .toString(36)
  .replace(/[01]/g, 'a')

const nextPass = (str) => {
  const hasStraight = (p) => {
    const nextC = (c) => String.fromCharCode(c.charCodeAt() + 1)

    for (let i = p.length; i > 1; --i) {
      if ((p[i]) === nextC(p[i - 1]) && p[i - 1] === nextC(p[i - 2])) {
        return true
      }
    }
    return false
  }

  const hasBadChar = (pass) => Boolean(pass.match(/[ilo]/))

  const hasDoubleChar = (pass) => pass.match(/(.)\1/) &&
    pass.match(/(.)\1/g).length > 1

  const isValid = (pass) => hasStraight(pass) &&
    !hasBadChar(pass) &&
    hasDoubleChar(pass)

  let pass = str
  if (isValid(pass)) pass = iterateStr(pass)
  while (!isValid(pass)) pass = iterateStr(pass)
  return pass
}

const main = () => {
  const input = fs.readFileSync('../input/11.txt', 'utf8').trim()
  const a = nextPass(input)
  const b = nextPass(a)
  console.log(a)
  console.log(b)
}

main()
