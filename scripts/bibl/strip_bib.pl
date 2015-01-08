#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "../transform/Blumenbach_Bibliographie_2.html");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$content =~ s/$empty_tags//mgi;
$content =~s/&nbsp;//g;
#$content =~s/<table>//g;
#$content =~s/<\/table>//g;
#$content =~s/\n{2,}/\n/g;
#$prefix = "<td><span class=\"undef\">";
#$content =~ s/\s*(<td>)(\w)/$prefix$2/g;
#$prefix = "<td><span class=\"undef\">";
$content =~ s/\R//g;
#$a = "</div><div id=";
#$content =~ s/\s*(<a id=)/$a/g;
#$td= "<td>";
#$content =~ s/\s*(<td class=\"AlternatDatum\">)/$td/g;
#$eck = "</td><td>";
#$content =~ s/\s*(<span class=\"Eckdaten\">)/$eck$1/g;
#$content =~ s/\s*(<span class=\"Eckdaten\"><)//g;
#$reg = "<td><span class=\"Rubriken\">";
#$content =~ s/\s*(<td class=\"Rubriken\">)/$reg/g;
#$alt = "</td><td>";
#$content =~ s/\s*(<span class=\"AlternatDatum\">)/$alt$1/g;
#$table = "</span></td></tr><table>";
#$content =~ s/\s*(<table>)/$table$1/g;
#$brief = "<tr>";
#$content =~ s/\s*(<td><span class=\"Briefinhalt\">)/$brief$1/g;
#$content =~ s/$empty_tags//mgi;
$content =~s/\n{2,}/\n/g;

print $content;



#    $fh =~ s/\n{2,}/\n/g;
#    $fh =~ s#<\s*([^>]*)\s*>[\s\n]*<\s*/\s*\1\s*>##ig;
# print $data;

