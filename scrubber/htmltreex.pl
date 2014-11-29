  #!/usr/bin/perl -w

  use v5.10;
  use HTML::TreeBuilder::XPath;

  my $tree= HTML::TreeBuilder::XPath->new;
#   open(my $fh, "<:utf8", "Briefregesten_2.html") || die;
#   encode_utf_8($fh);
   $tree->parse_file("Briefregesten_2.html");

 foreach my $e ( $tree->findnodes('/html/body//table/tr') ) {
        foreach my $td ( $e->findnodes('./td') ) {
            if ($td) {
                foreach my $span ( $td->findvalues('./span') ) {
                    if ($span) {
                        print "Span: $span\n";
                    }
                }
                unless ( $td->exists('./span') ) {
                    foreach my $tdval ( $td->findnodes_as_strings('.') ) {
                        if ($tdval) {
                         print "TD: $tdval\n";
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

sub verbose() {
    foreach my $e ( $tree->findnodes('/html/body//table/tr') ) {

        my $reg = $e->findvalue('./td/span[@class="RegNr"]');
        if ($reg) {
            print "RegNr: $reg\n";
        }

        foreach my $alt_date ( $e->findvalues('./td/span[@class="AlternatDatum"]') ) {
            if ($alt_date) {
               print "AlternatDatum: $alt_date\n";
            }
        }

        foreach my $eck ( $e->findvalues('./td/span[@class="Eckdaten"]') ) {
            if ($eck) {
                print "Eckdaten: $eck\n";
            }
        }

        foreach my $rub ( $e->findvalues('./td/span[@class="Rubriken"]') ) {
            if ($rub) {
                print "Rubriken: $rub\n";
            }
        }

        foreach my $kop ( $e->findvalues('./td/span[@class="KopfRegest Briefinhalt"]') ) {
            if ($kop) {
                print "KopfRegest Briefinhalt: $kop\n";
            }
        }

        foreach my $bri ( $e->findvalues('./td/span[@class="Briefinhalt"]') ) {
            if ($bri) {
                print "Briefinhalt: $bri\n";
            }
        }

        foreach my $zus ( $e->findvalues('./td/span[@class="ZusatzDaten"]') ) {
            if ($zus) {
                print "ZusatzDaten: $zus\n";
            }
        }
    }
}

  #my $nb=$tree->findvalue( '/html/body//table/tr/td/span[@class="RegNr"]');
  #print $nb;
  $tree->delete; # to avoid memory leaks, if you parse many HTML documents 