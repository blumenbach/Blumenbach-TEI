#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "../transform/BR8.html");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$content =~ s/(<altdate>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(<Rubriken>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(<Zusatzdaten>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(<ZusatzDaten>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(<relatedItem>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(<bibl>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(<biblScope>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(<object>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(<edition>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(<note>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(<span>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(<anchor>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(Überl.:)[\r\n](.+?)/$2/sg;
$content =~ s/(Ed.:)[\r\n](.+?)/$2/sg;
$content =~ s/(Dr.:)[\r\n](.+?)/$2/sg;
$content =~ s/(Obj.:)[\r\n](.+?)/$2/sg;
$content =~ s/(Dr.:|Werke:| Anm.:| Obj.:|Überl.:|Ed.:)//mgi;



print $content;



#    $fh =~ s/\n{2,}/\n/g;
#    $fh =~ s#<\s*([^>]*)\s*>[\s\n]*<\s*/\s*\1\s*>##ig;
# print $data;

