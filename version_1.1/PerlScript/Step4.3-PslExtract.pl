#!/usr/bin/perl
use strict;
use warnings;

my (@arr,$min,$max,$min2);

if ($ARGV[2] ge $ARGV[3]) {
	$max = $ARGV[2];
	$min = $ARGV[3];
}else{
	$min = $ARGV[2];
	$max = $ARGV[3];
}
	$min2 = $min-10;

open(FH, "$ARGV[0]") || die($!);
open(OUT, ">$ARGV[1]") || die($!);

<FH>;<FH>;<FH>;<FH>;<FH>;
while (<FH>) {
	chomp;
	@arr = split ("\t");
	if ($arr[0]>$min2) {
		print OUT "$arr[15]\t$arr[16]\t$arr[9]\t$arr[10]\n";
	}
}
close FH;
close OUT;
