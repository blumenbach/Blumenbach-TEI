#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "../transform/BR5.html");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$ed = "</edition>\n";
$content =~ s/(<edition>.*)\s*(<)/$1$ed$2/g;
$obj = "</object>\n";
$content =~ s/(<object>.*)\s*(<)/$1$obj$2/g;
$bibl = "</bibl>\n";
$content =~ s/(<bibl>.*)\s*(<)/$1$bibl$2/g;
$rel = "</relatedItem>\n";
$content =~ s/(<relatedItem>.*)\s*(<)/$1$rel$2/g;
$aut = "</author>\n";
$content =~ s/(<author>.*)\s*(<)/$1$aut$2/g;
$dat = "</date>\n";
$content =~ s/(<date>.*)\s*(<)/$1$dat$2/g;
$tit = "</title>\n";
$content =~ s/(<title>.*)\s*(<)/$1$tit$2/g;
$alt = "</altdate>\n";
$content =~ s/(<altdate>.*)\s*(<)/$1$alt$2/g;
$rcv = "</receiver>\n";
$content =~ s/(<receiver>.*)\s*(<)/$1$rcv$2/g;
$rub = "</Rubriken>\n";
$content =~ s/(<Rubriken>.*)\s*(<)/$1$rub$2/g;
$zus = "</Zusatzdaten>\n";
$content =~ s/(<Zusatzdaten>.*)\s*(<)/$1$zus$2/g;
$zds = "</ZusatzDaten>\n";
$content =~ s/(<ZusatzDaten>.*)\s*(<)/$1$zds$2/g;
$not = "</note>\n";
$content =~ s/(<note>.*)\s*(<)/$1$not$2/g;
$anc = "</link>\n";
$content =~ s/(<link>.*)\s*(<(?!http))/$1$anc$2/g;
$anc = "</anchor>\n";
$content =~ s/(<anchor>.*)\s*(<)/$1$anc$2/g;
$reg = "</RegNr>\n";
$content =~ s/(<RegNr>)\s(\w+)\s*(<)/$1$2$reg$3/g;
$sco = "</biblScope>\n";
$content =~ s/(<biblScope>.*)\s*(<)/$1$sco$2/g;
$ltz = "</Lit_in_Zusatzdaten>\n";
$content =~ s/(<Lit_in_Zusatzdaten>.*)\s*(<)/$1$ltz$2/g;
$rec = "</record>\n\n<record>\n<RegNr>";
$content =~ s/(<RegNr>)(\w)/$rec$2/g;

print $content;



#    $fh =~ s/\n{2,}/\n/g;
#    $fh =~ s#<\s*([^>]*)\s*>[\s\n]*<\s*/\s*\1\s*>##ig;
# print $data;

