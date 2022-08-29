#!/usr/bin/env node

'use strict';

function find_index(string) {
	let u_index;

	const uniq = string.split('').find(
		(chr, index) => {
			u_index = string.indexOf(chr);
			return u_index === string.lastIndexOf(chr) ? true : false;
		}
	);

	return uniq ? [ uniq, u_index ] : [];
}

[
	"Perl Perl Perl",
	"Perl Weekly Challenge",
	"Long Live Perl",
	"This is Hyper Perly",
	"I Love Perl",
].forEach( (i) => console.log(find_index(i)) );


