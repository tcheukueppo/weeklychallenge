#!/usr/bin/env node

'use strict';

function trim_array(aray, i) {
	return aray.filter( (item) => item > i );
}

[
	{ a: [ 1, 4, 2, 3, 5 ], i: 3 },
	{ a: [ 9, 0, 6, 2, 3, 8, 5 ], i: 4 },
].forEach( (item) => console.log(trim_array(item.a, item.i)) );
