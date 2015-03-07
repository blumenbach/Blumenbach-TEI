#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "new.xml");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$lk = "</extent>\n<dimensions>";
$dm = "</dimensions>";
$content =~ s/(<extent>)(.+?)(;)(.+?)(<\/extent>)/$1$2$lk$4$dm/sg;
$content =~ s/(>)(?![\n])([\s])(.+?)/$1$3/sg;

print $content;
