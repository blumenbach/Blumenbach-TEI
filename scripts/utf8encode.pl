#!/usr/bin/perl -w

use Encode;

#my $infile = "Blumenbach_Bibliographie.html";
#my $outfile = "BBB.html";

open(INPUT,  "<:encoding(ISO-8859-1)", "Blumenbach_Bibliographie.html") || die;
open(OUTPUT, ">:utf8", "BBB.html") || die;
while (<INPUT>) {
#    $e->from_to($_, "ISO-8859-1", "UTF-8", 1);  # switch encoding
    print OUTPUT;   # emit raw (but properly encoded) data
}
close(INPUT)   || die;
close(OUTPUT)  || die;