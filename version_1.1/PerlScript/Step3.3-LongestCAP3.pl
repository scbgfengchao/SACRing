#!/usr/bin/perl
use strict;
use warnings;

my (@arr,@brr,%hash,$len,$maxid,$max);
$max=99;

open(FH, "$ARGV[0]") || die($!);
open(OUT, ">$ARGV[0].tmp") || die($!);

<FH>;
print OUT ">Contig1\t";
while (<FH>) {
	chomp;
	if (/^>/) {
		print OUT "\n$_\t";
	}else{
		print OUT "$_";
	}
}
print OUT "\n";
close FH;
close OUT;

open(FH, "$ARGV[0].tmp") || die($!);
open(OUT, ">$ARGV[0].Longest") || die($!);
while (<FH>) {
	chomp;
	@arr = split("\t");
	$hash{$arr[0]} = $arr[1];
	$len = length($arr[1]);
	if ($len > $max) {
		$max = $len;
		$maxid = $arr[0];	
	}
}
@brr =split ("\\.",$ARGV[0]);
print OUT ">tag2_$brr[0]\n"."$hash{$maxid}\n";

close FH;
close OUT;
