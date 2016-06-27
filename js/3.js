#!/usr/bin/env node

'use strict'

const Promise = require('bluebird')
const fs = Promise.promisifyAll(require('fs'))

function preprocess (str) {
  return str.split('').map(function (x) {
    switch (x) {
      case '^':
        return [0, 1]
      case '>':
        return [1, 0]
      case 'v':
        return [0, -1]
      case '<':
        return [-1, 0]
      default:
        return [0, 0]
    }
  })
}

function sideA (arr) {
  let positions = {'0,0': 1}

  for (let i = 0, position = [0, 0]; i < arr.length; ++i) {
    position[0] += arr[i][0]
    position[1] += arr[i][1]

    positions[position] = 1 + (positions[position] || 0)
  }
  return Object.keys(positions).length
}

function sideB (arr) {
  let positions = {'0,0': 1}

  let anthroPosition = [0, 0]
  let roboPosition = [0, 0]

  for (let i = 0; i < arr.length; ++i) {
    if (i % 2) {
      roboPosition[0] += arr[i][0]
      roboPosition[1] += arr[i][1]

      positions[roboPosition] = 1 + (positions[roboPosition] || 0)
    } else {
      anthroPosition[0] += arr[i][0]
      anthroPosition[1] += arr[i][1]

      positions[anthroPosition] = 1 + (positions[anthroPosition] || 0)
    }
  }
  return Object.keys(positions).length
}

function main () {
  fs.readFileAsync('../3.txt', 'utf8').then(function (contents) {
    const moves = preprocess(contents)
    console.log(sideA(moves))
    console.log(sideB(moves))
  }).catch(function (e) {
    console.error(e.stack)
  })
}

main()
