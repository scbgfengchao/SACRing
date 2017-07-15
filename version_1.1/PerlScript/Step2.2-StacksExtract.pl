#!/usr/bin/perl
use strict;
# use warnings;

my @arr;
my ($line1,$line2, $line3, $line4, %stat);
my $i=0;

open FH,"RAD_cp/$ARGV[0]_cp.tags.tsv" || die $!;
while(<FH>){
	chomp;
	@arr = split ("\t");
	$stat{"@"."$arr[8]"} = $arr[8];
}
close FH;

open(FH, "RAD_cp/$ARGV[0]_cp_1.fq") || die($!);
open(OUT, ">RAD_cp/$ARGV[0].cp_1.fq") || die($!);
while(<FH>){
	chomp;
	$i ++;
	if ($i % 4== 1){
		$line1 = $_;
	    @arr = split " ";
	} elsif ($i % 4== 2) {
		$line2 = $_;
	} elsif ($i % 4== 3) {
		$line3 = $_;
	} else {
		$line4 = $_;
		if(exists $stat{$arr[0]}){
		print OUT "$arr[0]\n$line2\n$line3\n$line4\n";
			}
		}
	}
close OUT;
close FH;

open(FH, "FastqFile/$ARGV[0]_2.fq") || die($!);
open(OUT, ">RAD_cp/$ARGV[0].cp_2.fq") || die($!);
while(<FH>){
	chomp;
	$i ++;
	if ($i % 4== 1){
		$line1 = $_;
	    @arr = split " ";
	} elsif ($i % 4== 2) {
		$line2 = $_;
	} elsif ($i % 4== 3) {
		$line3 = $_;
	} else {
		$line4 = $_;
		if(exists $stat{$arr[0]}){
		print OUT "$arr[0]\n$line2\n$line3\n$line4\n";
		}
	}
}
close OUT;
close FH;
