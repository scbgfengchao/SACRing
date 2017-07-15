#!/usr/bin/perl
use strict;
use warnings;

my (%hash,%hash1,%hash2,@arr,$key,$str,$n,$opt,$len,$len2);

$opt=$ARGV[1];
$len=$ARGV[2];
$len2=$len-$opt;

open FH,"RAD_cp/$ARGV[0]_cp.tags.tsv",or die $!;
open OUT,">RAD_tag/$ARGV[0].RAD.tags",or die $!;
while(<FH>){
	chomp;
	if(/Cp_nr/){
		@arr = split ("\t");
		if ($arr[5] eq "+") {
			print OUT "$arr[4]"."\t"."$arr[5]"."\t"."$arr[9]"."\t"."$arr[2]"."\n";
		}else{
			$arr[4] = $arr[4]-$opt;
			$n = reverse($arr[9]);
			$n =~ s/A/1/g;
			$n =~s/T/A/g;
			$n =~s/1/T/g;
			$n =~s/G/2/g;
			$n =~s/C/G/g;
			$n =~s/2/C/g;
			print OUT "$arr[4]"."\t"."$arr[5]"."\t"."$n"."\t"."$arr[2]"."\n";
		}
	}
}
close FH;
close OUT;

open(FH, "RAD_tag/$ARGV[0].RAD.tags") or die;
open(OUT, ">RAD_tag/$ARGV[0].tag1.fa") or die;
while (<FH>) {
	chomp;
	@arr = split ("\t");
	if (exists $hash{$arr[0]}){
		$str = substr($arr[2],0,$len2);
		$hash{$arr[0]} = "$str"."$hash{$arr[0]}";
		$hash1{$arr[0]}= "$hash1{$arr[0]}"."_$arr[3]";
		$hash2{$arr[0]}="P";
	}else{
		$hash{$arr[0]} = $arr[2];
		$hash1{$arr[0]}= $arr[3];
		$hash2{$arr[0]}= $arr[1];
	}
}
foreach $key (keys %hash){
    print OUT ">tag1".".$key.$hash2{$key}"."_$hash1{$key}"."\n"."$hash{$key}"."\n";
}
close FH;
close OUT;

