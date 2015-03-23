#!/usr/bin/perl -w


open(FILE, "../../transform/Bibliographie/2-PeriodicalWorks/4-Veröffentlichungen in weiteren gelehrten Zeitschriften 757-999.xml");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$op = "(";
$cp = ")";
$content =~ s/(<)([\d]*)(>)/$op$2$cp/sg;
$ht = "http";
$content =~ s/(<http)(.+?)(>)/$ht$2/sg;
$sp = "</BiblNr>\n";
$sp1 = "</biblStruct>\n\n<biblStruct>\n<BiblNr>";
$content =~ s/(<BiblNr>)[\s]*(.+?)[\r\n\s\t]*(<)/$sp1$2$sp$3/sg;
$cd = "</catDesc>\n";
$content =~ s/(<catDesc>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$cd$3/sg;
$t = "</title>\n";
$t1 = "<title>";
$content =~ s/(<eintrag>)[\s]*(.+?)[[\r\n\s\t]*(<)/$t1$2$t$3/sg;
$s = "</source>\n";
$content =~ s/(<source>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$s$3/sg;
$pp = "</pubPlace>\n";
$content =~ s/(<pubPlace>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$pp$3/sg;
$pb = "</publisher>\n";
$content =~ s/(<publisher>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$pb$3/sg;
$d = "</date>\n";
$content =~ s/(<date>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$d$3/sg;
$ex = "</biblScope>\n";
$ex1 = "<biblScope>";
$content =~ s/(<title>)[\s]*(.+?)[\r\n\s\t]*(<)/$ex1$2$ex$3/sg;
$dm = "</dimensions>\n";
$content =~ s/(<dimensions>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$dm$3/sg;
$rp = "</note>\n";
$rp1 = "<note>";
$content =~ s/(<sourceDesc>)[\s]*(.+?)[\r\n\s\t]*(<)/$rp1$2$rp$3/sg;
$lk = "</link>\n";
$content =~ s/(<link>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$lk$3/sg;
$rf = "</reference>\n";
$content =~ s/(<reference>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$rf$3/sg;
$ci = "</citedRange>\n";
$content =~ s/(<citedRange>)[\s]*(.+?)[\r\n\s\t]*(<)/$1$2$ci$3/sg;
$sro = "<title type=\"main\" level=\"j\">";
$src = "</title>\n";
$content =~ s/(<seriesStmt>)[\s]*(.+?)[\r\n\s\t]*(<)/$sro$2$src$3/sg;
$ed = "</edition>\n";
$ed1 = "<edition>";
$content =~ s/(<editionStmt>)[\s]*(.+?)[\r\n\s\t]*(<)/$ed1$2$ed$3/sg;



print $content;
