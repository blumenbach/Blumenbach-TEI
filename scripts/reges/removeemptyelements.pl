#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "BR11.xml");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$content =~ s/(>)(?![\n])([\s])(.+?)/$1$3/sg;
$content =~ s/(<note><\/note>)//mgi;
$content =~ s/(<object><\/object>)//sg;
$content =~ s/(<relatedItem><\/relatedItem>)//mgi;
$content =~ s/(<bibl> <\/bibl>)//mgi;
$content =~ s/(<bibl><\/bibl>)//mgi;
$content =~ s/(<Zusatzdaten> <\/Zusatzdaten>)//mgi;
$content =~ s/(<edition><\/edition>)//mgi;
$content =~ s/\n\n//mgi;
$rd = "</record>\n\n";
$content =~ s/(<\/record>)(.+?)/$rd$2/mgi;


print $content;