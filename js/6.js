#!/usr/bin/env node

'use strict'

const fs = require('fs')

function parse (str) {
  return str.split('\n')
    .filter(x => x.length > 0)
    .map(function (y) {
      const parse = y.match(/(.*) (\d+),(\d+) through (\d+),(\d+)/)
      return {
        action: parse[1],
        start: {
          x: Math.min(parse[2], parse[4]),
          y: Math.min(parse[3], parse[5])
        },
        end: {
          x: Math.max(parse[2], parse[4]),
          y: Math.max(parse[3], parse[5])
        }
      }
    })
}

function sideA (arr) {
  function followInstruction (yard, instruction) {
    for (let x = instruction.start.x; x <= instruction.end.x; ++x) {
      for (let y = instruction.start.y; y <= instruction.end.y; ++y) {
        if (yard[x] === undefined) yard[x] = []
        if (yard[x][y] === undefined) yard[x][y] = false
        switch (instruction.action) {
          case 'turn on':
            yard[x][y] = true
            break
          case 'turn off':
            yard[x][y] = false
            break
          case 'toggle':
            yard[x][y] = !yard[x][y]
            break
        }
      }
    }
    return yard
  }

  return arr.reduce(followInstruction, [])
    .reduce((count, row) => count + row.filter(z => z).length, 0)
}

function sideB (arr) {
  function followInstruction (yard, instruction) {
    for (let x = instruction.start.x; x <= instruction.end.x; ++x) {
      for (let y = instruction.start.y; y <= instruction.end.y; ++y) {
        if (yard[x] === undefined) yard[x] = []
        if (yard[x][y] === undefined) yard[x][y] = 0
        switch (instruction.action) {
          case 'turn on':
            yard[x][y] = yard[x][y] + 1
            break
          case 'turn off':
            yard[x][y] = yard[x][y] > 0 ? yard[x][y] - 1 : 0
            break
          case 'toggle':
            yard[x][y] = yard[x][y] + 2
            break
        }
      }
    }
    return yard
  }

  return arr.reduce(followInstruction, [])
    .reduce((count, row) => count + row.reduce((a, b) => a + (b || 0)), 0)
}

function main () {
  const contents = fs.readFileSync('../6.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
