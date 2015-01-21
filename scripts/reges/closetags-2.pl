#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "../transform/BR6.html");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$plc = "<place>";
$endplc = "</place>";
$match = "\n<altdate>";
$content =~ s/(<date>)(.*)($match)/$plc$2$endplc$3/g;
$plc = "<place>";
$endplc = "</place>";
$match = "\nspan";
$content =~ s/(<date>)(.*)($match)/$plc$2$endplc$3/g;
$ref = "\n<ref target=\"http";
$endref = "\"></ref>\n";
$content =~ s/(<http)(.+?)(>)/$ref$2$endref/g;
$anc = "</link>\n";
$content =~ s/(<link>.*)\s*(<)/$1$anc$2/g;
$dp = "</place>\n";
$content =~ s/(<\/date><\/place>)(.+?)(<)/$dp$2$3/sg;
$an = "</anchor>\n";
$content =~ s/(<anchor>)(.+?)(<)/$1$2$an$3/sg;
$content =~ s/(<td>)//sg;
$ald = "<altdate>";
$aldend = "</altdate>\n";
$content =~ s/(span class="AlternatDatum">)(.+?)(<)/$ald$2$aldend$3/sg;
$alt = "</altdate>\n";
$content =~ s/(julian. Kal.: )(.+?)(])/$1$2$3$alt/sg;
$content =~ s/($alt)\s*[\n]($alt)/$1/sg;
$plc = "<place>";
$endplc = "</place>";
#$match = "<altdate>";
#


$content =~ s/(<date>)(.+?)($match(?!$endplc))/$plc$2$endplc$3/sg;


print $content;



#    $fh =~ s/\n{2,}/\n/g;
#    $fh =~ s#<\s*([^>]*)\s*>[\s\n]*<\s*/\s*\1\s*>##ig;
# print $data;

