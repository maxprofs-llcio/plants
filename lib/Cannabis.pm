package Cannabis;

use MLDBM qw(DB_File Storable);
use Fcntl;

use Moose;

extends 'Plant';

has 'thcValue' => (
  is => 'rw',
  isa => 'Int',
);

has 'cbdValue' => (
  is => 'rw',
  isa => 'Int',
);

has 'thcvValue' => (
  is => 'rw',
  isa => 'Int',
);

has 'isStable' => (
  is => 'rw',
  isa => 'Bool',
);

##
# calculates and returns the ratio of cannabanoids in a listed strain
sub getRatio {
  my $cannabis = shift;
  return $cannabis->thcValue . ":" . $cannabis->cbdValue . ":" . $cannabis->thcvValue;
}

##
# print a strain desription
sub printStrainDescription {
  my $cannabis = shift;
  print
  "\n*" . $cannabis->name . "*\n\n" .
  $cannabis->name . " is " .
  $cannabis->description . ".\nIt has a ratio of " .
  $cannabis->getRatio . " THC to CBD to THCV.
";
  if( $cannabis->isStable ) {
    print "It is a stable strain. Seeds are true to type.";
  }
}

##
# return a strain description.
sub getStrainDescription {
  my $cannabis = shift;
  my $blah =
  $cannabis->name . " is " .
  $cannabis->description . ".\nIt has a ratio of " .
  $cannabis->getRatio . " THC to CBD to THCV.
";
  if( $cannabis->isStable ) {
    $blah .= "It is a stable strain. Seeds are true to type.";
  }
  return $blah;
}

sub saveRecord {
  my $cannabis = shift;
  my %record;
  my $dataFile = qq|data/Cannabis.bdb|;
  my $dbm = tie %record, 'MLDBM', $dataFile or die $!;
  $record{$cannabis->name} = $cannabis;
  undef $dbm;
  untie %record;
}

sub getCannabis {
  my $dataFile = 'data/Cannabis.bdb';
  my %list;
  my $dbm = tie %list, 'MLDBM', $dataFile or die $!;
  undef $dbm;
  return %list;
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;
