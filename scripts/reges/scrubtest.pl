#!/usr/bin/perl -w
use HTML::Scrubber;
use strict;

my @allow = qw[ br hr b a ];

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
        '*'           => 1, # default rule, allow all attributes
        'href'        => qr{^(?:http|https|ftp)://}i,
        'src'         => qr{^(?:http|https|ftp)://}i,
#   If your perl doesn't have qr
#   just use a string with length greater than 1
        'cite'        => '(?i-xsm:^(?:http|https|ftp):)',
        'language'    => 0,
        'name'        => 1, # could be sneaky, but hey ;)
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
    process => 0,
);

require Data::Dumper,die Data::Dumper::Dumper($scrubber) if @ARGV;

my $it = q[
    <?php   echo(" EVIL EVIL EVIL "); ?>    <!-- asdf -->
    <hr>
    <I FAKE="attribute" > IN ITALICS WITH FAKE="attribute" </I><br>
    <B> IN BOLD </B><br>
    <A NAME="evil">
        <A HREF="javascript:alert('die die die');">HREF=JAVA &lt;!&gt;</A>
        <br>
        <A HREF="image/bigone.jpg" ONMOUSEOVER="alert('die die die');">
            <IMG SRC="image/smallone.jpg" ALT="ONMOUSEOVER JAVASCRIPT">
        </A>
    </A> <br>
];

print "#original text",$/, $it, $/;
print
    "#scrubbed text (default ",
    $scrubber->default(), # no arguments returns the current value
    " comment ",
    $scrubber->comment(),
    " process ",
    $scrubber->process(),
    " )",
    $/,
    $scrubber->scrub($it),
    $/;

$scrubber->default(1); # allow all tags by default
$scrubber->comment(0); # deny comments

print
    "#scrubbed text (default ",
    $scrubber->default(),
    " comment ",
    $scrubber->comment(),
    " process ",
    $scrubber->process(),
    " )",
    $/,
    $scrubber->scrub($it),
    $/;

$scrubber->process(1);        # allow process instructions (dangerous)
$default[0] = 1;              # allow all tags by default
$default[1]->{'*'} = 0;       # deny all attributes by default
$scrubber->default(@default); # set the default again

print
    "#scrubbed text (default ",
    $scrubber->default(),
    " comment ",
    $scrubber->comment(),
    " process ",
    $scrubber->process(),
    " )",
    $/,
    $scrubber->scrub($it),
    $/;
