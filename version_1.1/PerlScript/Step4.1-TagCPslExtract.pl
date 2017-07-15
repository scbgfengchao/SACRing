#!/usr/bin/perl
use strict;
use warnings;

my (@arr,@brr,@crr,$site,$min,$min2,$max);
open(FH, "$ARGV[0]") || die($!);
open(OUT, ">$ARGV[1]") || die($!);

if ($ARGV[2] ge $ARGV[3]) {
	$max = $ARGV[2];
	$min = $ARGV[3];
}else{
	$min = $ARGV[2];
	$max = $ARGV[3];
}
	$min2 = $min-10;

<FH>;<FH>;<FH>;<FH>;<FH>;
while (<FH>) {
	chomp;
	@arr = split ("\t");
	@brr = split (/_/,$arr[9]);
	if ($arr[0] > $min2) {
		if ($arr[9] =~ /^tag1/){
			if ($arr[10] <= $max){
			print OUT "$brr[1]\t$arr[15]\t$arr[16]\t$arr[9]\t$arr[10]\n";
			}else{
			print OUT "$brr[1]\t$arr[15]\t$arr[16]\t$arr[9]\t$arr[10]\n";
			print OUT "$brr[2]\t$arr[15]\t$arr[16]\t$arr[9]\t$arr[10]\n";
			}
		}else{
			if ($arr[17] == 1) {
				print OUT "$brr[1]\t$arr[15]\t$arr[16]\t$arr[9]\t$arr[10]\n";
			}else{
				@crr=split(",",$arr[18]);
				if ($crr[0] > $max) {
					$site=$arr[15]+$arr[10];
					print OUT "$brr[1]\t$arr[15]\t$site\t$arr[9]\t$arr[10]\n";
				}else{
					$site=$arr[16]-$arr[10];
					print OUT "$brr[1]\t$site\t$arr[16]\t$arr[9]\t$arr[10]\n";
				}
			}
		}
	}
}
close FH;
close OUT;
