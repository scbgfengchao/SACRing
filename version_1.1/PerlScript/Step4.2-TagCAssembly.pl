#!/usr/bin/perl
use strict;
#use warnings;

my ($line1,$line2,$id1,$id2,@arr,@brr,@arr0,@brr0,@crr,%hash,$i,$overlap);
$i = 0;

open(FH, "$ARGV[0]") || die($!);
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
open(OUT, ">$ARGV[2].C") || die($!);
open(OUT1, ">$ARGV[2].S") || die($!);

$i=0;
while (<FH>) {
	chomp;
	$i ++;
	if ($i % 2 == 1) {
		@arr = split ("\t");
		@arr0 = split ("\\.",$arr[3]);
	}else{
		@brr = split ("\t");
		@brr0 = split ("\\.",$brr[3]);
		$id1=">"."$arr[3]";
		$id2=">"."$brr[3]";
		$overlap = $arr[2]-$brr[1];
		if ($overlap>0) {
			$line1 = substr ($hash{$id1},-$overlap);
			$line2 = substr ($hash{$id2},0,$overlap);
			if ($line1 eq $line2) {
				$line1 = substr($hash{$id1},0,$arr[4]-$overlap);
				print OUT ">$arr0[1]$arr0[2]$brr0[1]$brr0[2]"."_$arr[0]C\n"."$line1"."$hash{$id2}"."\n";
			}else{
			print OUT1 ">$arr[3]\n"."$hash{$id1}\n".">$brr[3]\n"."$hash{$id2}\n";
			}
		}else{
			print OUT1 ">$arr[3]\n"."$hash{$id1}\n".">$brr[3]\n"."$hash{$id2}\n";
		}
	}	
}
close FH;
close OUT;
close OUT1;

open(FH, "$ARGV[2].C") || die($!);
open(OUT, ">$ARGV[2].tmp") || die($!);
while (<FH>) {
	chomp;
	if (/^>/) {
		print OUT "$_\t";
	}else{
		print OUT "$_\n";
	}
}
close FH;
close OUT;

my (@tag,@tag1,%tag,$overlap2,@tag2,$title);

open(FH, "$ARGV[2].tmp") || die($!);
open(OUT, ">$ARGV[3]") || die($!);
$title=$ARGV[4];
$title=~s/\.\///;
while (<FH>) {
	chomp;
	@tag = split ("\t");
	@tag1 = split ("_",$tag[0]);
	if (exists $tag{$tag1[0]}) {
		$overlap2 = substr ($tag{$tag1[0]},0,100);
		@tag2=split(/$overlap2/,$tag[1]);
		print OUT "$tag1[0]__$title\n";
		print OUT "$tag2[0]"."$tag{$tag1[0]}\n";
	}else{
		$tag{$tag1[0]}=$tag[1];
	}
}
close FH;
close OUT;

