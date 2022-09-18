#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

while ( my $line = <DATA> ) {
	my @array = split m/, /, $line
}

my $expected = [2, 4];

is_deeply( $got, $expected, "");

done_testing(1);

__DATA__
5, 2, 9, 1, 7, 6
4, 2, 3, 1, 5, 0
