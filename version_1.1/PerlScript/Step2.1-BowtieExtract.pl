#!/usr/bin/perl
use strict;
use warnings;

my ($s1, $s2, @arr, @brr, %BTid1, %BTid2, %BTid3, $line1,$line2, $line3, $line4);
my $i = 0;

	$s1 = $ARGV[1];
	$s2 = reverse $s1;
	$s2 =~ s/A/1/g;
	$s2 =~ s/C/2/g;
	$s2 =~ s/T/A/g;
	$s2 =~ s/G/C/g;
	$s2 =~ s/1/T/g;
	$s2 =~ s/2/G/g;

open FH,"RAD_cp/$ARGV[0]_1.bowtie",or die $!;
while(<FH>){
	chomp;
	if(/Cp_nr/){
		@arr = split ("\t");
		@brr = split (/ /,$arr[0]);
		if ($arr[4]=~/^$s1/) {
			$BTid1{"@"."$brr[0]"} = $brr[0];
		}elsif ($arr[4]=~/$s2$/) {
			$BTid1{"@"."$brr[0]"} = $brr[0];
		}
	}
}
close FH;

open(FH, "RAD_cp/$ARGV[0]_2.bowtie") || die($!);
while(<FH>){
	chomp;
	if(/Cp_nr/){
		@arr = split ("\t");
		@brr = split (/ /,$arr[0]);
			if (exists $BTid1{"@"."$brr[0]"}) {
			$BTid2{"@"."$brr[0]"} = $brr[0];
		}
	}
}
close FH;

open(FH, "RAD_cp/$ARGV[0].bowtie2.sam") || die($!);
while(<FH>){
	chomp;
	if(/Cp_complete/){
		@arr = split ("\t");
		if (exists $BTid2{"@"."$arr[0]"}) {
		$BTid3{"@"."$arr[0]"} = $arr[0];
		}
	}
}
close FH;

open(FH, "FastqFile/$ARGV[0]_1.fq") || die($!);
open(OUT, ">RAD_cp/$ARGV[0]_cp_1.fq") || die($!);
while(<FH>){
	chomp;
	$i ++;
	if($i % 4== 1){
		$line1 = $_;
	    @arr = split " ";
	}elsif($i % 4== 2) {
		$line2 = $_;
	}elsif($i % 4== 3) {
		$line3 = $_;
	}else{
		$line4 = $_;
		if(exists $BTid3{$arr[0]}){
			print OUT "$arr[0]\n$line2\n$line3\n$line4\n";
		}
	}
}
close OUT;
close FH;

