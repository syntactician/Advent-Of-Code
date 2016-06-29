#!/usr/bin/env node
'use strict'

const fs = require('fs')

const parse = (str) => str.split('\n')
  .filter(x => x.length > 0)
  .map((str) => {
    const parts = str.match(/(.*) (\d+),(\d+) through (\d+),(\d+)/)
    return {
      action: parts[1],
      start: {
        x: Math.min(parts[2], parts[4]),
        y: Math.min(parts[3], parts[5])
      },
      end: {
        x: Math.max(parts[2], parts[4]),
        y: Math.max(parts[3], parts[5])
      }
    }
  })

const sideA = (arr) => {
  const followInstruction = (grid, instruction) => {
    for (let x = instruction.start.x; x <= instruction.end.x; ++x) {
      for (let y = instruction.start.y; y <= instruction.end.y; ++y) {
        if (grid[x] === undefined) grid[x] = []
        // if (grid[x][y] === undefined) grid[x][y] = false
        switch (instruction.action) {
          case 'turn on':
            grid[x][y] = true
            break
          case 'turn off':
            grid[x][y] = false
            break
          case 'toggle':
            grid[x][y] = grid[x][y] ? !grid[x][y] : true
            break
        }
      }
    }
    return grid
  }

  return arr.reduce(followInstruction, [])
    .reduce((count, row) => count + row.filter(x => x).length, 0)
}

const sideB = (arr) => {
  const followInstruction = (grid, instruction) => {
    for (let x = instruction.start.x; x <= instruction.end.x; ++x) {
      for (let y = instruction.start.y; y <= instruction.end.y; ++y) {
        if (grid[x] === undefined) grid[x] = []
        if (grid[x][y] === undefined) grid[x][y] = 0
        switch (instruction.action) {
          case 'turn on':
            grid[x][y] = grid[x][y] + 1
            break
          case 'turn off':
            grid[x][y] = grid[x][y] > 0 ? grid[x][y] - 1 : 0
            break
          case 'toggle':
            grid[x][y] = grid[x][y] + 2
            break
        }
      }
    }
    return grid
  }

  return arr.reduce(followInstruction, [])
    .reduce((sum, row) => sum + row.reduce((a, b) => a + (b || 0)), 0)
}

const main = () => {
  const contents = fs.readFileSync('../6.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
