#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "BR12.xml");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);
$sr = "<surname>";
$sr1 = "</surname>";
$fn = "<forename>";
$fn1 = "</forename>";

$content =~ s/(<author>)(.+?),\s(.+?)(<\/author>)/$1$sr$2$sr1$fn$3$fn1$4/sg;
$content =~ s/(<receiver>)(.+?),\s(.+?)(<\/receiver>)/$1$sr$2$sr1$fn$3$fn1$4/sg;

print $content;