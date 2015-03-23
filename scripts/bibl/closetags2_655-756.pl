#!/usr/bin/perl -w


open(FILE, "new.xml");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$b = "</title>\n";
$b1 = "<title type=\"main\" level=\"a\">Überschrift:";
$content =~ s/(<biblScope>Überschrift:)[\s]*(.+?)(<\/biblScope>)/$b1$2$b/sg;
$t1 = "<title type=\"main\" level=\"a\">Überschrift:";
$content =~ s/(<title>Überschrift:)[\s]*(.+?)[[\r\n\s\t]*(<)/$t1$2$3/sg;


print $content;
