  #!/usr/bin/perl -w

  use v5.10;
  use HTML::TreeBuilder::XPath;

  my $tree= HTML::TreeBuilder::XPath->new;
#   open(my $fh, "<:utf8", "Briefregesten_2.html") || die;
#   encode_utf_8($fh);
   $tree->parse_file("BR11.html");

foreach my $div ($tree->findnodes('/html/body/div') ) {
    if ( $div->exists('./@id') ) {
        my $id = $div->findvalue('./@id');
        print "<anchor> $id\n" ;
    }
 foreach my $e ( $div->findnodes('.//tr') ) {
        foreach my $td ( $e->findnodes('./td') ) {
            if ($td) {
                 foreach my $span ( $td->findvalues('./span') ) {
                    if ($span) {
                        if ( $td->findvalues('./span[@class="Eckdaten"]') ) {
                            print "<Eckdaten> $span\n";
                        } elsif ( $td->findvalues('./span[@class="KopfRegest Briefinhalt"]') ) {
                            print "<KopfRegest Briefinhalt> $span\n";
                        } elsif ( $td->findvalues('./span[@class="Briefinhalt"]') ) {
                            print "<Briefinhalt> $span\n";
                        } elsif ( $td->findvalues('./span[@class="Lit_in_Zusatzdaten"]') ) {
                            print "<Lit_in_Zusatzdaten> $span\n";
                        } elsif ( $td->findvalues('./span[@class="ZusatzDaten"]') ) {
                            print "<Zusatzdaten> $span\n";
                        } elsif ( $td->findvalues('./span[@class="Rubriken"]') ) {
                            print "<Rubriken> $span\n";
                        } elsif ( $td->findvalues('./span[@class="RegNr"]') ) {
                            print "<RegNr> $span\n";
                        } else {
                            print "<span> $span\n";
                        }
                    }
                 }

                if ( $td->exists('./span/a') ) {
                    my $url = $td->findvalue('./span/a/@href');
                    my $a = $td->findvalue('./span/a');
                    print "<link> $a <$url>\n";
                } elsif ( $td->exists('./a') ) {
                    my $url = $td->findvalue('./a/@href');
                    my $a = $td->findvalue('./a');
                    print "<link> $a <$url>\n";
                }

                if (not ( $td->exists('./span') ) )  {
                    foreach my $tdval ( $td->findnodes_as_strings('.') ) {
                        if ($tdval) {
                            if (not ( $td->exists('../td[@class="Rubriken"]') ) ) {
                                print "<td> $tdval\n";
                            } else {
                                print "<Rubriken> $tdval\n";
                            }
                        }
                    }
                }
            }
        }
 }
}
sub encode_utf_8 {
    my $string = @_;

    my $utf8_encoded = '';
    eval {
        $utf8_encoded = Encode::encode('UTF-8', $string, Encode::FB_CROAK);
    };
    if ($@) {
        # sanitize malformed UTF-8
        $utf8_encoded = '';
        my @chars = split(//, $string);
        foreach my $char (@chars) {
            my $utf_8_char = eval { Encode::encode('UTF-8', $char, Encode::FB_CROAK) }
                or next;
            $utf8_encoded .= $utf_8_char;
        }
    }
    return $utf8_encoded;
}

  $tree->delete; # to avoid memory leaks, if you parse many HTML documents 