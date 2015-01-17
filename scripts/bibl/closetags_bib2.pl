#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "../../transform/Bibliographie/1-IndependentWorks/2-Handbuch der Naturgeschichte 21-51.xml");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$op = "(";
$cp = ")";
$content =~ s/(<)([\d]*)(>)/$op$2$cp/sg;
$ht = "http";
$content =~ s/(<http)(.+?)(>)/$ht$2/sg;
$sp = "</BiblNr>\n";
$sp1 = "<biblStruct>\n<BiblNr>";
$content =~ s/(<BiblNr>)[\s]*(.+?)[\r\n\s\t]*(<)/$sp1$2$sp$3/sg;
$cd = "</catDesc>\n";
$content =~ s/(<catDesc>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$cd$3/sg;
$t = "</title>\n";
$content =~ s/(<title>)[\s]*(.+?)[[\r\n\s\t]*(<)/$1$2$t$3/sg;
$s = "</source>\n";
$content =~ s/(<source>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$s$3/sg;
$pp = "</pubPlace>\n";
$content =~ s/(<pubPlace>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$pp$3/sg;
$pb = "</publisher>\n";
$content =~ s/(<publisher>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$pb$3/sg;
$d = "</date>\n";
$content =~ s/(<date>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$d$3/sg;
$ex = "</extent>\n";
$content =~ s/(<extent>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$ex$3/sg;
$dm = "</dimensions>\n";
$content =~ s/(<dimensions>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$dm$3/sg;
$nt = "</note>\n";
$content =~ s/(<note>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$nt$3/sg;
$rp = "</repository>\n\n";
$rp1 = "<repository>";
$content =~ s/(<sourceDesc>)[\s]*(.+?)[\r\n\s\t]*(<)/$rp1$2$rp$3/sg;
$id = "</idno>\n";
$content =~ s/(<idno>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$id$3/sg;
$lk = "</link>\n";
$content =~ s/(<link>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$lk$3/sg;
$rf = "</reference>\n";
$content =~ s/(<reference>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$rf$3/sg;
$bi = "</biblScope>\n";
$content =~ s/(<biblScope>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$bi$3/sg;
$ci = "</citedRange>\n";
$content =~ s/(<citedRange>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$ci$3/sg;
$sro = "<monogr><title type=\"main\" level=\"j\">";
$src = "</title>\n";
$content =~ s/(<seriesStmt>)[\s]*(.+?)[\r\n\s\t]*(<)/$sro$2$src$3/sg;
$ed = "</edition>\n";
$ed1 = "<edition>";
$content =~ s/(<editionStmt>)[\s]*(.+?)[\r\n\s\t]*(<)/$ed1$2$ed$3/sg;



print $content;