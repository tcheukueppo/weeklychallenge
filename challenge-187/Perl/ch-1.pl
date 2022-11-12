#!/usr/bin/env perl

use strict;
use warnings;

use DateTime;
use List::Util qw( min max );
use feature    qw(say);

use Test::More;

# Boils down to a simple calculation of the intersection between two
# intervals [x,y] and [n,m] which is [max(x,n), min(y,m)].

sub intersections {
    my $result;
    my $intervals = [
        { Foo => [ qw(12-01 20-01) ], Bar => [ qw(15-01 18-01) ] },
        { Foo => [ qw(02-03 12-03) ], Bar => [ qw(13-03 14-03) ] },
        { Foo => [ qw(02-03 12-03) ], Bar => [ qw(11-03 15-03) ] },
        { Foo => [ qw(30-03 05-04) ], Bar => [ qw(28-03 02-04) ] },
    ];

    sub cal_ndays {
        state $date = DateTime->new( year => 1900 + ( localtime )[ 5 ] );
        my ( $day, $month ) = split m/-/, $_[ 0 ];

        return $date->set( month => $month, day => $day )->jd;
    }

    # Find domain of intersection between the two intervals
    foreach my $interval ( @$intervals ) {
        my ( $fstart, $fend, $bstart, $bend ) = map { cal_ndays( $_ ) } map { @$_ } $interval->@{qw/Foo Bar/};
        push @$result, min( $fend, $bend ) - max( $fstart, $bstart ) + 1;
    }

    return $result;
}

my $expected = [ qw(4 0 2 4) ];

is_deeply( intersections(), $expected, 'Are the intersections correct?' );

done_testing( 1 );
