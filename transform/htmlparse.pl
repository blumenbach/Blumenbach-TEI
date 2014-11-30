#!/usr/bin/perl -w

# This program will print out all <a href=".."> links in a
# document together with the text that goes with it.
#
# See also HTML::LinkExtor

use HTML::Parser;

my $p = HTML::Parser->new(api_version => 3,
                    start_h => [\&start_handler, "self,tagname,attr"],
                    report_tags => [qw(td span)],
    );

 open(my $fh, "<:utf8", "Briefregesten.html") || die;
 $p->parse_file($fh);

sub start_handler {
    my($self, $tag, $attr) = @_;
    $self->handler(start => \&td_start_handler, "self,tagname,attr" );
    $self->handler(start => \&span_start_handler, "self,tagname,attr");
}

sub td_start_handler
{
    my($self, $tag, $attr) = @_;
    return unless $tag eq "td";
    return unless exists $attr->{class};
    print "<TD> $attr->{class}\n";
    $self->handler(text  => [], '@{dtext}' );
    $self->handler(end   => \&td_end_handler, "self,tagname");
}

sub td_end_handler
{
    my($self, $tag) = @_;
    my $text = join("", @{$self->handler("text")});
    $text =~ s/^\s+//;
    $text =~ s/\s+$//;
    $text =~ s/\s+/ /g;
    print "$text\n";
    $self->handler("text", undef);
    $self->handler("start", \&td_start_handler);
    $self->handler("end", undef);
}

sub span_start_handler
{
    my($self, $tag, $attr) = @_;
    return unless $tag eq "span";
    return unless exists $attr->{class};
    print "SPAN $attr->{class}\n";
    $self->handler(text  => [], '@{dtext}' );
    $self->handler(end   => \&span_end_handler, "self,tagname");
}

sub span_end_handler
{
    my($self, $tag) = @_;
    my $text = join("", @{$self->handler("text")});
    $text =~ s/^\s+//;
    $text =~ s/\s+$//;
    $text =~ s/\s+/ /g;
    print "$text\n";

    $self->handler("text", undef);
    $self->handler("start", \&span_start_handler);
    $self->handler("end", undef);
}