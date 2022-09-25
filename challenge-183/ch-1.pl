#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw(smartmatch);
use feature      qw(say);

use Test::More;

my @uniq;
my @list = ( [ 1, 2 ], [ 3, 4 ], [ 5, 6 ], [ 1, 2 ] );

# Man..... you gotta use `for(|each)'!!! :)
map { my $aref = $_; push @uniq, $aref unless grep { @$aref ~~ @$_ } @uniq } @list;

is_deeply( [@uniq], [ [ 1, 2 ], [ 3, 4, ], [ 5, 6 ] ] );

done_testing( 1 );
