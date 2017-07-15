#!/usr/bin/perl
use strict;
use warnings;

my ($line1,$line2,@arr,%hash,$id,$len,$seq,$i,$min,$max,$min2);
$i=0;

if ($ARGV[3] ge $ARGV[4]) {
	$max = $ARGV[3];
	$min = $ARGV[4];
}else{
	$min = $ARGV[3];
	$max = $ARGV[4];
}
	$min2 = $min-10;

open(FH, "$ARGV[0]") || die($!);
open(FH1, "$ARGV[1]") || die($!);
open(OUT, ">$ARGV[2]") || die($!);
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

<FH1>;<FH1>;<FH1>;<FH1>;<FH1>;
while (<FH1>) {
	chomp;
	@arr = split ("\t");
	if ($arr[0]>$min2) {
		$id = ">"."$arr[9]";
		$len = $arr[12]-$arr[11];
		$_ = substr($hash{$id},$arr[11],$len);
		if ($arr[8] eq "+") {
			print OUT "$id\n"."$_\n";
		}else{
			s/A/1/g;
			s/T/A/g;
			s/1/T/g;
			s/G/2/g;
			s/C/G/g;
			s/2/C/g;
			my $seq = reverse;
			print OUT "$id\n"."$seq\n";
		}
	}
}
close FH1;
close OUT;
