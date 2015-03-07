#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "BR15.xml");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);
$space = " ";
$content =~ s/([a-z])([A-Z])/$1$space$2/sg;
$regnr = "<RegNr>";
$content =~ s/(<Reg Nr>)/$regnr/sg;
$regnr1 = "</RegNr>";
$content =~ s/(<\/Reg Nr>)/$regnr1/sg;
$bibscope = "<biblScope>";
$content =~ s/(<bibl Scope>)/$bibscope/sg;
$bibscope1 = "</biblScope>";
$content =~ s/(<\/bibl Scope>)/$bibscope1/sg;
$relitem = "<relatedItem>";
$content =~ s/(<related Item>)/$relitem/sg;
$relitem1 = "</relatedItem>";
$content =~ s/(<\/related Item>)/$relitem1/sg;

print $content;