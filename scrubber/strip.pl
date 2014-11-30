#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};

open(FILE, "Briefregesten_2.html");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$content =~ s/$empty_tags//mgi;
$content =~s/\n{2,}/\n/g;
$content =~ s/$empty_tags//mgi;
$content =~s/&nbsp;//g;
$content =~s/\n{2,}/\n/g;

print $content;



#    $fh =~ s/\n{2,}/\n/g;
#    $fh =~ s#<\s*([^>]*)\s*>[\s\n]*<\s*/\s*\1\s*>##ig;
# print $data;

