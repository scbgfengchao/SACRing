#!/usr/bin/perl
use strict;
use warnings;

my ($line1,$line2,@arr,$id,%hash,$i,$start,$end,$len,$title);

open(FH, "$ARGV[0]") || die($!);
$i=0;
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

open(FH, "$ARGV[1]") || die($!);
open(OUT, ">$ARGV[2]") || die($!);
open(OUT1, ">$ARGV[3]") || die($!);
open(OUT2, ">$ARGV[2].Stat") || die($!);

$title=$ARGV[4];
$title=~s/\.\///;
$i=0;
while (<FH>) {
	chomp;
	$i++;
	@arr = split ("\t");
	$id = ">"."$arr[2]";
	print OUT ">CpContigs_$i"."__$title\n"."$hash{$id}\n";
	print OUT2 "$arr[0]\t$arr[1]\tCpContigs_$i"."__$title\t$arr[3]\n";
	if ($i==1) {
		$end = $arr[1];
		print OUT1 ">sub-super-marker__$title\n";
		print OUT1 "$hash{$id}";
	}else{
		$start=$arr[0];
		$len=$start-$end;
		$end=$arr[1];
		if ($len > 0) {
			print OUT1 "-" x "$len";
			print OUT1 "$hash{$id}";
		}else{
			print OUT1 "-";
			print OUT1 "$hash{$id}";
		}
	}
}
close FH;
close OUT;
close OUT1;
close OUT2;