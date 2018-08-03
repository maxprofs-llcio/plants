#!/usr/bin/perl -w

use lib 'lib/';
use MLDBM qw(DB_File Storable);
use Fcntl;
use Moose;
use Cannabis;
use Utils;

my $dataFile = 'data/Cannabis.bdb';
my %list;
my $dbm = tie %list, 'MLDBM', $dataFile or die $!;
undef $dbm;

my $strainCount = keys %list;

print "
STRAIN DATABASE
---------------
$strainCount strains in database

";

foreach my $key (keys %list) {
  my $cannabis = Cannabis->new(%{$list{$key}});
  if( defined $cannabis->name ) {
    $cannabis->printStrainDescription;

    # my $meta = $cannabis->meta();
    #
    # for my $attribute ( $meta->get_all_attributes ) {
    #   print $attribute->name(), "\n";
    # }
    #
    # for my $method ($meta->get_all_methods) {
    #   print $method->name(), "\n";
    # }
  }
  else {
    # silently cleaning up (it's ok)
    delete $list{$key};
  }
}

print "

.oO( Peace out yo )


";
