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


print $content;



#    $fh =~ s/\n{2,}/\n/g;
#    $fh =~ s#<\s*([^>]*)\s*>[\s\n]*<\s*/\s*\1\s*>##ig;
# print $data;

