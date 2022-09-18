#!/usr/bin/env perl

# pwc-175 - kueppo

use strict;
use warnings;

use Test::More;

sub isa_leap_year {
	return 1 if $year % 400 == 0;
	return 0 if $year % 100 == 0;
	return 1 if $year % 4   == 0;
}

sub overall_shift {
	my $year      = $_[0];
	my $the_shift = $year;

	$the_shift += isa_leap_year $_ ? 1 : 0 foreach (2 .. $year);

	return $the_shift;
}

sub last_sundays {
	my $year  = $_[0];
	my $shift = overall_shift $year;
	my @days  = qw(Mon Tue Wed Thr Fri Sat Sun);
	my @yone  = (
		[6, 31],
		[2, isa_leap_year $year ? 29 : 28],
		[2, 31],
		[5, 30],
		[7, 31],
		[3, 30],
		[5, 31],
		[1, 31],
		[4, 30],
		[6, 31],
		[2, 30],
		[4, 31],
	);

	foreach my $month (keys @yone) {
		my $sun;

		# First day of the previous year ($year - 1)
		$day = $yone[$month][0] + $shift;
		if ($day > 7) {
			$day = $shift - (7 - $yone[$month][0]);
			$day -= 7 while $day > 7;
		}

		# Find last sunday of $_
		$sun = $yone[$month][1] - (7 - $day);
		$sun += 7 while $sun + 7 < $yone[$month];
		$sun = ++$month . q{-} . $sun;

		push @suns, qq{$year-$sun};
	}

	return @suns;
}

## testing

__END__
