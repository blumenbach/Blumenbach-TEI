#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "../transform/BR5.html");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$ed = "</edition>\n";
$content =~ s/(<edition>)(.+?)(<)/$1$2$ed$3/sg;
$obj = "</object>\n";
$content =~ s/(<object>)(.+?)(<)/$1$2$obj$3/sg;
$bibl = "</bibl>\n";
$content =~ s/(<bibl>)(.+?)(<)/$1$2$bibl$3/sg;
$rel = "</relatedItem>\n";
$content =~ s/(<relatedItem>)(.+?)(<)/$1$2$rel$3/sg;
$aut = "</author>\n";
$content =~ s/(<author>.*)\s*(<)/$1$aut$2/g;
$dat = "</date>\n";
$content =~ s/(<date>.*)\s*(<)/$1$dat$2/g;
$tit = "</title>\n";
$content =~ s/(<title>.*)\s*(<)/$1$tit$2/g;
$alt = "</altdate>\n";
$content =~ s/(<altdate>)(.+?)(<)/$1$2$alt$3/sg;
$rcv = "</receiver>\n";
$content =~ s/(<receiver>.*)\s*(<)/$1$rcv$2/g;
$rub = "</Rubriken>\n";
$content =~ s/(<Rubriken>)(.+?)(<)/$1$2$rub$3/sg;
$zus = "</Zusatzdaten>\n";
$content =~ s/(<Zusatzdaten>)(.+?)(<)/$1$2$zus$3/sg;
$zds = "</ZusatzDaten>\n";
$content =~ s/(<ZusatzDaten>)(.+?)(<)/$1$2$zds$3/sg;
$reg = "</RegNr>\n";
$content =~ s/(<RegNr>)\s(\w+)\s*(<)/$1$2$reg$3/g;
$sco = "</biblScope>\n";
$content =~ s/(<biblScope>)(.+?)(<)/$1$2$sco$3/sg;
$ltz = "</Lit_in_Zusatzdaten>\n";
$content =~ s/(<Lit_in_Zusatzdaten>.*)\s*(<)/$1$ltz$2/g;
$spa = "</span>\n";
$content =~ s/\s*(<span>)(.+?)(<)/$1$2$spa$3/sg;
$not = "</note>\n";
$content =~ s/\s*(<note>)(.+?)(<)/$1$2$not$3/sg;
$rec = "</record>\n\n<record>\n<RegNr>";
$content =~ s/(<RegNr>)(\w)/$rec$2/g;

print $content;



#    $fh =~ s/\n{2,}/\n/g;
#    $fh =~ s#<\s*([^>]*)\s*>[\s\n]*<\s*/\s*\1\s*>##ig;
# print $data;

