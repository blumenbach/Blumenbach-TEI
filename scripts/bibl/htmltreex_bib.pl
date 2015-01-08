  #!/usr/bin/perl -w

  use v5.10;
  use HTML::TreeBuilder::XPath;

  my $tree= HTML::TreeBuilder::XPath->new;
   $tree->parse_file("../transform/BBL1.html");

foreach my $div ($tree->findnodes('/html/body//tr') ) {
      foreach my $td ( $div->findnodes('./td') ) {

          foreach my $id ( $td->findvalue('./a/@name') ) {
                if ($id) {
                    print "<anchor> $id\n" ;
                }
          }

          foreach my $sp ( $td->findvalue('./span/a/@name') ) {
                if ($sp) {
                    print "<span> $sp\n" ;
                }
          }

          foreach my $et ( $td->findvalues('./span[@class="Eintrag"]') ) {
                if ($et) {
                    print "<eintrag> $et\n" ;
                }
          }
          foreach my $km ( $td->findvalues('./span[@class="Kommentar"]') ) {
                if ($km) {
                    print "<komment> $km\n" ;
                }
          }

          foreach my $a ( $td->findnodes('./a') ) {
                 my $url = $a->findvalue('./@href');
                 my $a = $a->findvalue('.');
                 print "<link> $a <$url>\n";
          }
      }
}

$tree->delete;