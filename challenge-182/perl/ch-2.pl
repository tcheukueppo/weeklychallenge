#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);

use Test::More;

my %paths;

while ( my $path = <DATA> ) {
    my $i = 1;
    $i++, $paths{$1}++ while $path =~ m| ( ( /[^/]* ){ $i } ) (?-1){2} |x;
}

is(
    (
        sort    { $b->[1] <=> $a->[1] || length $b->[0] cmp length $a->[0] }
            map { [ $_, $paths{$_} ] }
            keys %paths
    )[0]->[0],
    "/a/b/c",
	"is it the deepest path to the directory that contain all `x.pl's?"
);

done_testing( 1 );

__DATA__
/a/b/c/1/x.pl
/a/b/c/d/e/2/x.pl
/a/b/c/d/3/x.pl
/a/b/c/4/x.pl
/a/b/c/d/5/x.pl
