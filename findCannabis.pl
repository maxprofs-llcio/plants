#!/usr/bin/perl -w

use lib 'lib/';
use MLDBM qw(DB_File Storable);
use Fcntl;
use Moose;
use Plant::Cannabis;
use Console;

my $dataFile = 'data/Cannabis.bdb';
my %search;
my $dbm = tie %search, 'MLDBM', $dataFile or die $!;
undef $dbm;

my $console = Console->new();

my $cannabis = Cannabis->new(%{$search{$console->getValue('search')}}); 

if( defined $cannabis->name ) {
  $cannabis->printStrainDescription;
} else {
  print "no strain like that in db. maybe add it?\n";
}
