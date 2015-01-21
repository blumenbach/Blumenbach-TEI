#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "BR10.xml");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$ref = "<ref type=\"pdf\" target=\"http://webdoc";
$content =~ s/(<ref target=\"http:\/\/webdoc)(.*?)(>)/$ref$2$3/msg;

print $content;