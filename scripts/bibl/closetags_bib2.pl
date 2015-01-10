#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "../../transform/Bibliographie/1-IndependentWorks/1-De Generis Humani Varietate 1-20.xml");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$sp = "</BiblNr>\n";
$content =~ s/(<BiblNr>)(.+?)[\r\n](<)/$1$2$sp$3/sg;
$cd = "</catDesc>\n";
$content =~ s/(<catDesc>)(.+?)[\r\n](<)/$1$2$cd$3/sg;
$t = "</title>\n";
$content =~ s/(<title )(.+?)[\r\n](<)/$1$2$t$3/sg;
$s = "</source>\n";
$content =~ s/(<source>)(.+?)[\r\n](<)/$1$2$s$3/sg;
$pp = "</pubPlace>\n";
$content =~ s/(<pubPlace>)(.+?)[\r\n](<)/$1$2$pp$3/sg;
$pb = "</publisher>\n";
$content =~ s/(<publisher>)(.+?)[\r\n](<)/$1$2$pb$3/sg;
$d = "</date>\n";
$content =~ s/(<date>)(.+?)[\r\n](<)/$1$2$d$3/sg;
$ex = "</extent>\n";
$content =~ s/(<extent>)(.+?)[\r\n](<)/$1$2$ex$3/sg;
$dm = "</dimensions>\n";
$content =~ s/(<dimensions>)(.+?)[\r\n](<)/$1$2$dm$3/sg;
$nt = "</note>\n";
$content =~ s/(<note>)(.+?)[\r\n](<)/$1$2$nt$3/sg;
$rp = "</repository>\n";
$content =~ s/(<repository>)(.+?)[\r\n](<)/$1$2$rp$3/sg;
$id = "</idno>\n";
$content =~ s/(<idno)(.+?)[\r\n](<)/$1$2$id$3/sg;
$lk = "</link>\n";
$content =~ s/(<link>)(.+?)(>)[\r\n](<)/$1$2$3$lk$4/sg;

print $content;