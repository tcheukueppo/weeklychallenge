#!/usr/bin/env perl

use strict;
use warnings;

sub is_disarium ($) {
	my $f;
	my @digs = split //, $_[0];

	while ( my ($k, $v) = each @digs ) {
		$f += $v ** ( $k + 1 );
		last if $f > $_[0]
	}

	return $f == $_[0] ? 1 : 0;
}


sub find_disarium ($) {
	my $c = $_[0];
	my (%box, @r);

	%box = (
				1 => [ 1, 2, 4, 8, 3, 9, 5, 6, 7 ],
				2 => [ 16, 32, 64, 27, 81, 25, 36, 49 ],
				3 => [ 128, 256, 512, 243, 729, 125, 625, 216, 343 ],
				4 => [ 2187, 6561, 1024, 4096, 3125, 1296, 7776, 2401 ],
				5 => [ 19683, 16384, 65536, 15625, 78125, 46656, 16807, 32768, 59049 ],
				6 => [ 262144, 390625, 279936, 117649, 823543, 531441 ],
				7 => [ 1953125, 1679616, 5764801, 2097152, 4782969 ],
	       );

	OUTER: { 
		foreach (sort keys %box) {
			# Find all disarium numbers of length $_

			my @found = map {
				my $c = 0;
				my $end = s[(.)(?:.(?{$c++}))*][$1.'9'x$c]er;

				map { is_disarium $_ ? $_ : () } ($_ .. $end);
			} $box{$_}->@*;

			foreach my $f (@found) {
				push @r, $f unless grep { $_ == $f } @r;
				last OUTER if @r >= $c;
			}
		}
	}

	return @r;
}

$| = 1;

my @dis = find_disarium 18;
print "Disarium numbers: @dis\n";
