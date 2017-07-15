#!/usr/bin/perl
use strict;
use warnings;

my ($line1,$line2,$id,$id1,$id2,@arr,@brr,%hash,$i,$overlap);

open(FH, "$ARGV[0]") || die($!);
open(OUT, ">$ARGV[0].tmp") || die($!);
$i =0;
while (<FH>) {
	chomp;
	$i++;
	if ($i eq 1) {
		print OUT "$_\n";
	}else{
		if (/^>/) {
			print OUT "\n$_\n";
		}else{
			print OUT "$_";
		}
	}
}
print OUT "\n";
close FH;
close OUT;

$i=0;
open(FH, "$ARGV[0].tmp") || die($!);
while(<FH>){
	chomp;
	$i ++;
	if ($i % 2 == 1) {
		$line1 = $_;
	}else{
		$line2 = $_;
		$hash{$line1} = $line2;
	}	
}
close FH;

$i=0;
open(FH, "$ARGV[1]") || die($!);
while (<FH>) {
	chomp;
	$i++;
	if ($i < 2) {
		@arr = split "\t";
	}else{
		@brr = @arr;
		@arr = split "\t";
		$overlap = $brr[1]-$arr[0];
		if ($overlap > 0) {
			$id1 = ">"."$brr[2]";
			$id2 = ">"."$arr[2]";
			$line1 = substr ($hash{$id1},-$overlap);
			$line2 = substr ($hash{$id2},0,$overlap);
			if ($line1 eq $line2) {
				$line1 = substr($hash{$id1},0,$brr[1]-$arr[1]);
				$hash{$id2} = "$line1"."$hash{$id2}";
				delete ($hash{$id1});
			}
		}
	}
}
close FH;

open(FH, "$ARGV[1]") || die($!);
open(OUT, ">$ARGV[2]") || die($!);
while (<FH>) {
	chomp;
	@arr = split "\t";
	$id = ">"."$arr[2]";
	if (exists $hash{$id}) {
		print OUT "$id"."\n"."$hash{$id}"."\n";
	}
}
close FH;
close OUT;
