use XML::LibXML qw( );

sub parse_list {
   my ($node) = @_;
   return [
      map parse_field($_),
       $node->findnodes('span')
   ];
}

sub parse_field {
   my ($node) = @_;
   my @children = $node->findnodes('*');
   return $node->textContent() if !@children;
   return parse_list($children[0]) if $children[0]->nodeName() eq 'td';
   return {
      map { $_->getAttribute('class') => parse_field($_) }
       @children
   };
}

{
  open my $fh, '<', 'Briefregesten_2.html';
  binmode $fh;
  my $doc = XML::LibXML->load_html(IO => $fh);

   my @rows =
   map parse_field($_),
   $doc->findnodes('/html/body//table/tr');

   for my $rec (@rows){
     my ($key, $value);
     while (($key, $value) = each %{$rec}){
       print qq{$key -> $value\n};
     }
   }
}