#!/usr/bin/perl -w

use lib 'lib/';
use MLDBM qw(DB_File Storable);
use Fcntl;
use Moose;
use Cannabis;
use Utils;

my $dataFile = 'data/Cannabis.bdb';
my %search;
my $dbm = tie %search, 'MLDBM', $dataFile or die $!;
undef $dbm;

my $cannabis = Cannabis->new(%{$search{$utils->getValue('search')}}); # What!?! I'm a magician i know....

if( defined $cannabis->name ) {
  $cannabis->printStrainDescription;
} else {
  print "no strain like that in db. maybe add it?\n";
}
