#!/usr/bin/perl -w

open(FILE, "GaGS-dates.xml");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$lk = "</extent>\n<date>";
$space =", ";
$dm = "</date>";
$content =~ s/(<extent>)(.+?)([\s])(.+?)(,[\s])(.+?)(\),)(.+?)(<\/extent>)/$1$2$3$4$5$6$7$8$lk$2$space$6$dm/sg;

print $content;
