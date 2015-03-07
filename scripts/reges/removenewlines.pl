#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "../transform/BR8.html");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$content =~ s/(span class=\"AlternatDatum\">)//mgi;
$content =~ s/(<altdate>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(<Rubriken>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(<Zusatzdaten>)(.+?)[\r\n](<)/$1$2$3/sg;
$content =~ s/(<ZusatzDaten>)(.+?)[\r\n](<)/$1$2$3/sg;
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
$content =~ s/(\/td>)//mgi;
$quot ="\"";
$content =~ s/(.pdf)(.+?)(http:)(.+?)(>)/$1$2$quot$5/mgi;
$endref = "\"></ref>\n<ref target=\"";
$content =~ s/(Bibliographie.html)(.+?)(http:)/$1$2$endref$3/mgi;
$content =~ s/(<note>)[\r\n](.+?)/$1$2/sg;
$nb="<notbefore>";
$nbend = "</notbefore>";
$content =~ s/(<altdate> nach)(.+?)(<\/altdate>)/$nb$2$nbend/sg;
$na="<notafter>";
$naend = "</notafter>";
$content =~ s/(<altdate> vor)(.+?)(<\/altdate>)/$na$2$naend/sg;
$content =~ s/(<relatedItem>)(.+?)[\r\n](.+?)(<)/$1$3$4/sg;
$endrelitem = "</relatedItem>";
$content =~ s/(<\/relatedItem><span>)(.+?)(<\/span>)/$2$endrelitem/sg;
$endbibl = "</bibl>";
$content =~ s/(<\/bibl><span>)(.+?)(<\/span>)/$2$endbibl/sg;
$endedition = "</edition>";
$content =~ s/(<\/edition><span>)(.+?)(<\/span>)/$2$endedition/sg;
$content =~ s/(<receiver>)(<span>)(.+?)(<\/span>)/$1$3/sg;
$endnote = "</note>";
$content =~ s/(<\/note><span>)(.+?)(<\/span>)/$2$endnote/sg;
$content =~ s/(<altdate> \[= julian. Kal.:)(\s[a-z])(.+?)(\]<\/altdate>)//sig;
$juldate = "<julian>";
$julenddate = "</julian>";
$content =~ s/(<altdate> \[= julian. Kal.:)(.+?)(\]<\/altdate>)/$juldate$2$julenddate/sg;
$plc = "\n<place>";
$endplc = "</place>";
$date = "<date>";
$enddate ="</date>";
$content =~ s/(<place>)(.+?)(\d)(\s)(.+?)(<\/place>)/$date$2$3$enddate$plc$5$endplc/g;
$content =~ s/(>)[\s](\w)/$1$2/g;
$plc = "\n<place>";
$endplc = "</place>";
$date = "<date>";
$enddate ="</date>";
$content =~ s/(<date>)(.+?)(\d)(\s)(.+?)(<\/date>)/$date$2$3$enddate$plc$5$endplc/g;
$content =~ s/(>)[\s](\w)/$1$2/g;
$content =~ s/(<place>)([\s\d])(.+?)(<\/place)/$date$2$3$enddate/g;
$content =~ s/(\[)([\s\d])(.+?)(\])/$2$3/g;
$altdate ="<altdate>";
$content =~ s/(<altdate>ca.)(\s)/$altdate/g;
$altdate ="<altdate>";
$content =~ s/(<altdate>)(\s)/$altdate/g;
$content =~ s/(Ü)/ü/g;




print $content;



#    $fh =~ s/\n{2,}/\n/g;
#    $fh =~ s#<\s*([^>]*)\s*>[\s\n]*<\s*/\s*\1\s*>##ig;
# print $data;

