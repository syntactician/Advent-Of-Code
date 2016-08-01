#!/usr/bin/env node
'use strict'

const fs = require('fs')

const parse = (str) => str
  .trim()
  .split('\n')
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

const sideA = (arr) => arr
  .reduce((r, c) => {
    for (let x = c.start.x; x <= c.end.x; ++x) {
      for (let y = c.start.y; y <= c.end.y; ++y) {
        if (r[x] === undefined) r[x] = []
        if (r[x][y] === undefined) r[x][y] = false
        switch (c.action) {
          case 'turn on':
            r[x][y] = true
            break
          case 'turn off':
            r[x][y] = false
            break
          case 'toggle':
            r[x][y] = !r[x][y]
            break
        }
      }
    }
    return r
  }, [])
  .reduce((r, c) => r + c.filter((x) => x).length, 0)

const sideB = (arr) => arr
  .reduce((r, c) => {
    for (let x = c.start.x; x <= c.end.x; ++x) {
      for (let y = c.start.y; y <= c.end.y; ++y) {
        if (r[x] === undefined) r[x] = []
        if (r[x][y] === undefined) r[x][y] = 0
        switch (c.action) {
          case 'turn on':
            r[x][y] = r[x][y] + 1
            break
          case 'turn off':
            r[x][y] = r[x][y] > 0 ? r[x][y] - 1 : 0
            break
          case 'toggle':
            r[x][y] = r[x][y] + 2
            break
        }
      }
    }
    return r
  }, [])
  .reduce((r, c) => r + c.reduce((x, y) => x + (y || 0)), 0)

const main = () => {
  const contents = fs.readFileSync('../input/06.txt', 'utf8')
  const input = parse(contents)
  console.log(sideA(input))
  console.log(sideB(input))
}

main()
