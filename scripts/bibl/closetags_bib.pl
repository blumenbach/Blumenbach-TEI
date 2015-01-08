#!/usr/bin/perl -w

my $empty_tags = qr{<(tr|br|td)>\s*</\1>};


open(FILE, "../../transform/Bibliographie/BBL_c2.html");
@lines = <FILE>;
close(FILE);

$content = join('', @lines);

$sp = "\n<BiblNr>";
$content =~ s/(<span>)(.+?)(<)/$sp$2$3/sg;
$pb = "\n<publicationStmt>";
$content =~ s/(<eintrag>)(.+?)( )(.+?)(<)/$1$2$pb$4$5/sg;
$au = "\n<author>";
$content =~ s/(<eintrag>)(.+?)( \/ )(.+?)(<)/$1$2$au$4$5/sg;
$ed = "<editionStmt>";
$content =~ s/(<publicationStmt>)(.+?)(.  )(.+?)(<)/$ed$2$pb$4$5/sg;
$content =~ s/(<publicationStmt>)(.+?)(.)(.+?)(<)/$ed$2$pb$4$5/sg;
$content =~ s/(<editionStmt>)(.+?)(. )(.+?)(<)/$ed$2$pb$4$5/sg;
$ex = "\n<extent>";
$content =~ s/(<publicationStmt>)(.+?)(. )(.+?)(<)/$pb$2$ex$4$5/sg;
$ex = "\n<extent>";
$content =~ s/(<extent>)(.+?)(. )(.+?)(<)/$ex$2$ex$4$5/sg;
$pbl = "\n<publisher>";
$pbp = "\n<pubPlace>";
$content =~ s/(<publicationStmt>)(.+?)(:)(.+?)(<)/$pbp$2$pbl$4$5/sg;
$d = "\n<date>";
$content =~ s/(<publisher>)(.+?)(,)(.+?)(<)/$1$2$d$4$5/sg;
$ref = "\n<reference>";
$content =~ s/(\[->)(.+?)(].)/$ref$2/sg;
$el = "\n<element>";
$content =~ s/(  )(.+?)(<)/$el$2$3/sg;
$no = "<note>";
$content =~ s/(<komment>)(.+?)([\r\n])(<BiblNr>)/$no$2$3$4/sg;
$sd = "<sourceDesc>";
$content =~ s/(<komment>)(.+?)(<)/$sd$2$3/sg;
$ti = "<title>";
$content =~ s/(<eintrag>)(.+?)(<)/$ti$2$3/sg;

print $content;