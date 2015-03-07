#!/usr/bin/perl -w

my @exts = qw(.txt .zip);

open(FILE, "1-61-valid.xml");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$refpdf = "<link type=\"pdf\">";
$content =~ s/(<link>)(!^http:\/\/)([^\/?]+)?(\/(?:[^\/?]+\/)*)?([^.\/?][^\/?]+?)?(\.pdf)?(<\/link>)?/$refpdf$2$3$4$5$6/sg;

print $content;