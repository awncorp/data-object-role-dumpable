package Data::Object::Role::Dumpable;

use 5.014;

use strict;
use warnings;
use routines;

use Moo::Role;

# VERSION

# METHODS

method dump() {
  require Data::Dumper;
  require Data::Object::Utility;

  no warnings 'once';

  local $Data::Dumper::Indent = 0;
  local $Data::Dumper::Purity = 0;
  local $Data::Dumper::Quotekeys = 0;
  local $Data::Dumper::Deepcopy = 1;
  local $Data::Dumper::Deparse = 1;
  local $Data::Dumper::Sortkeys = 1;
  local $Data::Dumper::Terse = 1;
  local $Data::Dumper::Useqq = 1;

  my $data = Data::Dumper::Dumper($self);

  $data =~ s/^"|"$//g;

  return $data;
}

method pretty_dump() {
  require Data::Dumper;
  require Data::Object::Utility;

  no warnings 'once';

  local $Data::Dumper::Indent = 2;
  local $Data::Dumper::Trailingcomma = 0;
  local $Data::Dumper::Purity = 0;
  local $Data::Dumper::Pad = '';
  local $Data::Dumper::Varname = 'VAR';
  local $Data::Dumper::Useqq = 0;
  local $Data::Dumper::Terse = 1;
  local $Data::Dumper::Freezer = '';
  local $Data::Dumper::Toaster = '';
  local $Data::Dumper::Deepcopy = 1;
  local $Data::Dumper::Quotekeys = 0;
  local $Data::Dumper::Bless = 'bless';
  local $Data::Dumper::Pair = ' => ';
  local $Data::Dumper::Maxdepth = 0;
  local $Data::Dumper::Maxrecurse = 1000;
  local $Data::Dumper::Useperl = 0;
  local $Data::Dumper::Sortkeys = 1;
  local $Data::Dumper::Deparse = 1;
  local $Data::Dumper::Sparseseen = 0;

  my $data = Data::Dumper::Dumper($self);

  $data =~ s/^'|'$//g;

  chomp $data;

  return $data;
}

method pretty_print(@args) {

  return $self->printer(map &pretty_dump($_), $self, @args);
}

method pretty_say(@args) {

  return $self->printer(map +(&pretty_dump($_), "\n"), $self, @args);
}

method print(@args) {

  return $self->printer(map &dump($_), $self, @args);
}

method printer(@args) {

  return CORE::print(@args);
}

method say(@args) {

  return $self->printer(map +(&dump($_), "\n"), $self, @args);
}

1;
