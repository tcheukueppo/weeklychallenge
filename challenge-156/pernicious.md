I opt for a very simple approach, from the given definition we can deduce the following properties:

a) 2^n + 1 is always pernicious for all positive integer n and has 2 ones.

b) 2^n - 1 is pernicious if and only if n is prime and has n ones.

With these two properties, we can avoid the computation of the number of ones.

### Prerequisite

Default base in perl is `e` but we need to compute in base `2`.

1. Calculate logarithm in base `2`.

```perl
sub log_base2 {
	my $n = shift;
	log($n) / log(2)
}
```

2. Check if `$number` is prime.

If they exist no divisors of `$number` between `2` and `sqrt($number)`, then `$number` is prime.

```perl
sub is_prime {
	my ($number, $prime) = (shift, 1);

	$prime = 0 if ($number == 1);
	if ($number > 3) {
		foreach my $i (2..sqrt $number) {
			if ($number % $i == 0) {
				$prime = 0;
				last;
			}
		}
	}
	return $prime;
}
```

### Pernicious.pl

```perl
#!/usr/bin/env perl

use strict;
use warnings;

### HELPER
# Find log of $n base 2.
sub log_base2 {
	my $n = shift;
	log($n) / log(2)
}

### HELPER
# Check if $number is prime (1: success, 0: failure).
sub is_prime {
	my ($number, $prime) = (shift, 1);

	$prime = 0 if ($number == 1);
	if ($number > 3) {
		foreach my $i (2..sqrt $number) {
			if ($number % $i == 0) {
				$prime = 0;
				last;
			}
		}
	}
	return $prime;
}

### MAIN
# List the first $limit penicious numbers.
sub penicious {
	my ($v, $limit) = (3, shift);
	my @found = ();

	while (@found != $limit) {
		my ($fpower, $spower) = (log_base2($v + 1), log_base2($v - 1));
		if ($spower =~ /^\d+$/) {
			push @found, $v;
		} elsif ($fpower =~ /^\d+$/ and is_prime $fpower) {
			push @found, $v;
		} else {
			my ($ones, $val) = (0, sprintf '%b', $v);
			foreach (split '', $val) {
				$ones++ if ($_ eq '1');
			}
			push @found, $v if (is_prime $ones);
		}
		$v++;
	}
	print join ', ', @found, "\n";
}

penicious 10;
```






