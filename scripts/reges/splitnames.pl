#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "BR13.xml");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

#$content =~ s/(<author>)(.+?),\s(.+?)(<\/author>)/$1$sr$2$sr1$fn$3$fn1$4/sg;
#$content =~ s/(<receiver>)(.+?),\s(.+?)(<\/receiver>)/$1$sr$2$sr1$fn$3$fn1$4/sg;
$content =~ s/(<relatedItem>)(.+?)[\r\n](<)/$1$2$3/sg;

print $content;