#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

# USAGE: perl allocation_to_samplesheet.pl <allocation.tsv> <barcode.tsv> [header.tsv] >samplesheet.tsv

$Data::Dumper::Sortkeys = 1;

my @letters = ("A","B","C","D","E","F","G","H","I");
my $col = 1;
my $row = 1;
my $plate = 0;
my %sample;
my @forward;
my %seqs;

open IN, "<$ARGV[1]" or die "$!";
while(<IN>){
    chomp;
    my ($sid, $seq) = split(/,/);
    $seqs{$sid} = $seq;
}
close IN or die "$!";

if($ARGV[2]){
open IN, "<$ARGV[2]" or die "$!";
while(<IN>){
    print;
}
close IN or die "$!";

}

open IN, "<$ARGV[0]" or die "$!";
# Discard first line:
<IN>;
while(<IN>){
    chop;
    my @row = split(/,/);
    # Not a header row (first and tenth cell contain reverse primers)
    if($row[0]){
	my $rev = $row[0];
	my $col = 1;
	my $plateadd = 0;
	for(my $c=1; $c<17; $c++){
	    if($c==9){
		$rev = $row[$c];
		$col = 1;
		$plate += 2;
	    }
	    else{
		$row[$c] = "" unless(defined $row[$c]);
		$sample{$plate}{$letters[$col-1]}{$row} = [$row[$c], $forward[$c], $rev];
		$col++;
	    }
	}
	$row++;
	$plate -= 2;
    }
    # Header row (contains forward primers as colnames)
    else{
	@forward = @row;
	$row = 1;
	$plate++;
    }
}
close IN or die "$!";

for(my $p=1; $p<5; $p++){
    foreach my $r (sort keys %{$sample{$p}}){
	foreach my $c (sort {$a <=> $b} keys %{$sample{$p}{$r}}){
	    my ($id, $f, $re) = @{$sample{$p}{$r}{$c}};
	    print "$id,$id,$p,$c$r,$re,$seqs{$re},$f,$seqs{$f},project,description\n";
	}
    }
}

# print Dumper(\%sample);
