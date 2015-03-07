#!/usr/bin/perl -w
use v5.10;
use HTML::Scrubber;
use strict;

my $holdTerminator = $/;
undef $/;
my $buf = <STDIN>;
$/ = $holdTerminator;
my @lines = split /$holdTerminator/, $buf;
$buf = "init";
$buf = join $holdTerminator, @lines;

my @allow = qw[ hr html head body b td a div title span tr ];

my @rules = (
   script => 0,
   img => {
       src => qr{^(?!http://)}i, # only relative image links allowed
       alt => 1,                 # alt attribute allowed
       '*' => 0,                 # deny all other attributes
   },
);

my @default = (
   0   =>    # default rule, deny all tags
  {
        '*'           => 0, # default rule, allow all attributes
        'href'        => qr{^(?:http|https|ftp)://}i,
        'src'         => qr{^(?:http|https|ftp)://}i,
        'cite'        => '(?i-xsm:^(?:http|https|ftp):)',
        'language'    => 0,
        'name'        => 1, # could be sneaky, but hey ;)
        'class'       => 1,
        'style'       => qr{^(?:font-style:)}i,
        'id'          => 1,
        'onblur'      => 0,
        'onchange'    => 0,
        'onclick'     => 0,
        'ondblclick'  => 0,
        'onerror'     => 0,
        'onfocus'     => 0,
        'onkeydown'   => 0,
        'onkeypress'  => 0,
        'onkeyup'     => 0,
        'onload'      => 0,
        'onmousedown' => 0,
        'onmousemove' => 0,
        'onmouseout'  => 0,
        'onmouseover' => 0,
        'onmouseup'   => 0,
        'onreset'     => 0,
        'onselect'    => 0,
        'onsubmit'    => 0,
        'onunload'    => 0,
        'src'         => 0,
        'type'        => 0,
    }
);


my $scrubber = HTML::Scrubber->new();
   $scrubber->allow( @allow );
   $scrubber->rules( @rules ); # key/value pairs
   $scrubber->default( @default );
   $scrubber->comment(1); # 1 allow, 0 deny

## preferred way to create the same object
$scrubber = HTML::Scrubber->new(
    allow   => \@allow,
    rules   => \@rules,
    default => \@default,
    comment => 1,
    process => 1,
);

require Data::Dumper,die Data::Dumper::Dumper($scrubber) if @ARGV;

print
$scrubber->default(0),
$scrubber->comment(),
$scrubber->process(),
$/,
$scrubber->scrub($buf),
$/;
