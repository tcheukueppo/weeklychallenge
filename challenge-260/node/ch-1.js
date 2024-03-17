#!/usr/bin/env node

let is_uniq = (ints) => {
   let oc = new Map()

   ints.forEach((i) => oc.get(i) === undefined ? oc.set(i, 1) : oc.set(i, oc.get(i) + 1))
   return oc.size === (new Set([...oc.values()])).size
}

console.log(is_uniq([1, 2, 2, 1, 1, 3]))
console.log(is_uniq([1, 2, 3]))
console.log(is_uniq([-2, 0, 1, -2, 1, 1, 0, 1, -2, 9]))
