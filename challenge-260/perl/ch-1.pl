#!/usr/bin/env perl

use strict;
use warnings;
use v5.36;

use List::Util qw( uniq );
use Test::More;

sub is_uniq (@ints) {
   my %occ;
   $occ{$_}++ foreach @ints;
   return int(values %occ == uniq values %occ);
}

is(is_uniq(1,2,2,1,1,3), 1, "occurrences uniq?");
is(is_uniq(1,2,3), 0, "ocurrences uniq?");
is(is_uniq(-2,0,1,-2,1,1,0,1,-2,9), 1, "occurrences uniq?");

done_testing(3);
