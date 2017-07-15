#!/usr/bin/perl
use strict;
use warnings;
## This perl script could be used to analyze the boundaries of LSC, SSC and IR, respectively, and the result was stored in RegionBoundary.txt.
## Only a single Ref sequences can be analyzed in InputFile.

my $seq = "";
my $i = 0;
my ($LSC,$SSC,$IRb,$IRa,$Other,@Other,@Other2,$s1,$s2,$tmp,@seq,$j,$len1,$len2,$len3);

open FH,"$ARGV[0]",or die $!;
open OUT1,">RefFile/RegionBoundary.txt",or die $!;
open OUT2,">RefFile/Cp_complete.fa",or die $!;
open OUT3,">RefFile/Cp_nr.fa",or die $!;

while(<FH>){
	chomp;
	if (/>/) {
		if ($i eq 0) {
			print OUT1 "$_\n";
			print OUT2 ">Cp_complete\n";
			print OUT3 ">Cp_nr\n";
			$i ++;
		}else{
			last;
		}
	}else{
		$seq = "$seq"."$_";
	}
}
print OUT2 "$seq\n";

close FH;
close OUT2;

$s1 = substr ($seq,-20000);
$tmp = &RC;
if ($seq =~ /$tmp/) {
}else{
	print "\n!!Error:Your Ref seems error in IR region or (There is  no IR repeates in your Ref!)\n\n\n";
}
@seq = split (/$tmp/,$seq);
$LSC = $seq[0];
$Other = $tmp.$seq[1];

for ($j=10000;$j<=100000;$j++) {
	$s1 = substr ($seq,-$j);
	$tmp = &RC;
	if ($Other =~ /$tmp/) {
		$IRa = $s1;
		$IRb = $tmp;
	}else{
		last;
	}
}
@Other = split ($IRb,$Other);
@Other2 = split ($IRa,$Other[1]);
$SSC = $Other2[0];

print OUT3 "$LSC"."$IRb"."$SSC";
$len1 = length($LSC);
$len2 = length($SSC);
$len3 = length($IRb);
print OUT1 "LSC_Length\t".$len1."\n"."$LSC"."\n";
print OUT1 "IRb_Length\t".$len3."\n"."$IRb"."\n";
print OUT1 "SSC_Length\t".$len2."\n"."$SSC"."\n";
print OUT1 "IRa_Length\t".$len3."\n"."$IRa"."\n";

close OUT1;
close OUT3;

sub RC {
	$s2 = reverse $s1;
	$s2 =~ s/A/1/g;
	$s2 =~ s/C/2/g;
	$s2 =~ s/T/A/g;
	$s2 =~ s/G/C/g;
	$s2 =~ s/1/T/g;
	$s2 =~ s/2/G/g;
	$s2;
}