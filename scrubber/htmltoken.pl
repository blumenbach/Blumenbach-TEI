  use HTML::TokeParser;
     open(my $fh, "<:utf8", "Briefregesten_2.html") || die "Can't open 'Briefregesten_2.html': $!";
     my $p = HTML::TokeParser->new( $fh );

  while (my $token = $p->get_tag("td" ,"span", "a")) {
      my $tag = $token->[0];
      my $class = $token->[1]{class};
      my $url = $token->[1]{href};
      my $text = $p->get_trimmed_text("/td", "/span", "/a");
      if ($text){
        if ($url) {
            print "$tag $url:\t$text\n";
        } elsif ($class) {
            print "$tag $class:\t$text\n";
        }
      }
  }