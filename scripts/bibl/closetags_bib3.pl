#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "21closed.xml");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$lk = "</link>\n";
$content =~ s/(<link>)(.+?)(?<!<\/link>)(\n)/$1$2$lk/sg;
$content =~ s/(<link>)[\s]*(.+?)/$1$2/sg;
$content =~ s/(<note>)[\s]*(.+?)/$1$2/sg;
$nt = "</note>\n";
$content =~ s/(<note>)(.+?)(?<!<\/note>)(\n)/$1$2$nt$3/sg;
$content =~ s/(>)(<\/.+?>)/$1/sg;

print $content;