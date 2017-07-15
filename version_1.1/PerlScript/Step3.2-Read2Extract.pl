#!/usr/bin/perl
use strict;
use warnings;

my ($line1,$line2,%hash);
my $i=0;

open(FH, "$ARGV[0]") || die($!);
open(FH1, "$ARGV[1]") || die($!);
open(OUT, ">$ARGV[2]") || die($!);

while(<FH>){
	chomp;
	$i ++;
	if ($i % 4 == 1) {
		s/@//;
		$line1 = $_;
	}elsif ($i % 4 == 2){
		$line2 = $_;
		$hash{$line1} = $line2;
	}
}
close FH;

<FH1>;<FH1>;
while (<FH1>) {
	chomp;
	print OUT ">$_\n"."$hash{$_}\n";
}
close FH1;
close OUT;
