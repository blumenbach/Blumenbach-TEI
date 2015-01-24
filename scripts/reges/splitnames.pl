#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "../../Blumenbach/Briefregesten.html");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);
$emp = "<emph>";
$emp1 = "</emph>";

$content =~ s/(<author>)(.+?),\s(.+?)(<\/author>)/$1$sr$2$sr1$fn$3$fn1$4/sg;
$content =~ s/(<receiver>)(.+?),\s(.+?)(<\/receiver>)/$1$sr$2$sr1$fn$3$fn1$4/sg;

print $content;