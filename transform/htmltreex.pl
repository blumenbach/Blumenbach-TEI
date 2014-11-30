  #!/usr/bin/perl -w

# todo: <table> -> </span></td></tr><table>
# todo: <a id= -> <div id =
# todo: <td class="Rubriken"> -> <td><span class="Rubriken">
# todo: </tr> -> </span></tr>

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
                                print "<date> $span\n";
                            } elsif ( $td->findvalues('./span[@class="KopfRegest Briefinhalt"]') ) {
                                print "<KopfRegest Briefinhalt> $span\n";
                            } elsif ( $td->findvalues('./span[@class="Briefinhalt"]') ) {
                                print "<title> $span\n";
                            } elsif ( $td->findvalues('./span[@class="Lit_in_Zusatzdaten"]') ) {
                                print "<Lit_in_Zusatzdaten> $span\n";
                            } elsif ( $td->findvalues('./span[@class="ZusatzDaten"]') ) {
                                print "<Zusatzdaten> $span\n";
                            } elsif ( $td->findvalues('./span[@class="Rubriken"]') ) {
                                if ($span eq "A:") {
                                    print "<author>";
                                } elsif ($span eq "E:") {
                                    print "<receiver>";
                                } elsif ($span eq "Überl.:") {
                                    print "<biblScope> $span";
                                } elsif ($span eq "Dr.:") {
                                    print "<bibl> $span\n";
                                } elsif ($span eq "Werke:") {
                                    print "<relatedItem> $span\n";
                                } elsif ($span eq "Ed.:") {
                                    print "<edition> $span\n";
                                } elsif ($span eq "Obj.:") {
                                    print "<object> $span\n";
                                } elsif ($span eq "Anm.:") {
                                    print "<note> $span\n";
                                } else {
                                    print "<Rubriken> $span\n";
                                }
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
                        foreach my $tdval ( $td->findvalues('.') ) {
                            if ($tdval) {
                                if ( $td->findvalues('../td[@class="Rubriken"]') )  {
                                    if ($tdval eq "A:") {
                                        print "<author>";
                                    } elsif ($tdval eq "E:") {
                                        print "<receiver>";
                                    } elsif ($tdval eq "Ed.:") {
                                        print "<edition> $tdval\n";
                                    } elsif ($tdval eq "Überl.:") {
                                        print "<receiver> $tdval\n";
                                    } elsif ($tdval eq "Werke:") {
                                        print "<edition> $tdval\n";
                                    } else {
                                        print "<Rubriken> $tdval\n";
                                    }
                                } elsif ( $td->findvalues('../td[@class="ZusatzDaten"]') )  {
                                    print "<ZusatzDaten> $tdval\n";
                                } else {
                                    print "<td> $tdval\n";
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