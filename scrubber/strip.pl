#!/usr/bin/perl -w
open OUT, ">fixed" or die "Couldn't open fixed: $!";
open IN, "<junk" or die "Couldn't open junk: $!";
{
    local $/ = undef;
    ($_ = <IN>) =~ s/\n{2,}/\n/g;
    print OUT;
}
close IN;
close OUT