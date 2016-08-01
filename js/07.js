#!/usr/bin/env node
'use strict'

// props to /u/a-t-k for their excellent solution
// i would have spont years on this without their post

const fs = require('fs')

const parse = (str) => str
  .trim()
  .split('\n')

const ops = {
  AND: '&',
  OR: '|',
  RSHIFT: '>>',
  LSHIFT: '<<',
  NOT: '~'
}

const sideA = (arr) => {
  let wires = {}

  wires.run = (wire) => {
    if (typeof wires[wire] === 'function') {
      wires[wire] = wires[wire].call()
    }
    return wires[wire]
  }

  for (let i = 0; i < arr.length; ++i) {
    const instr = arr[i].split(/ -> /)

    wires[instr[1]] = new Function('return ' + instr[0]
        .replace(/(AND|OR|RSHIFT|LSHIFT|NOT)/, (op) => (ops[op]))
        .replace(/([a-z]+)/g, "this.run('$1')"))
      .bind(wires)
  }
  return wires.a()
}

const sideB = (arr, b) => {
  let wires = {}

  wires.run = (wire) => {
    if (typeof wires[wire] === 'function') {
      wires[wire] = wires[wire].call()
    }
    return wires[wire]
  }

  for (let i = 0; i < arr.length; ++i) {
    const instr = arr[i].split(/ -> /)

    wires[instr[1]] = new Function('return ' + instr[0]
        .replace(/(AND|OR|RSHIFT|LSHIFT|NOT)/, (op) => (ops[op]))
        .replace(/([a-z]+)/g, "this.run('$1')"))
      .bind(wires)
  }

  wires.b = () => b
  return wires.a()
}

const main = () => {
  const contents = fs.readFileSync('../input/07.txt', 'utf8')
  const input = parse(contents)
  const a = sideA(input)
  const b = sideB(input, a)
  console.log(a)
  console.log(b)
}

main()
