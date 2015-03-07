#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "101-110.xml");
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
$rp = "</repository>\n<idno>";
$id = "</idno>";
$content =~ s/(<repository>)(.+?)(:)(.+?)(<\/repository>)/$1$2$rp$4$id/sg;

print $content;
