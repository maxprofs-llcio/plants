package Acacia;

use MLDBM qw(DB_File Storable);
use Fcntl;

use Moose;

extends Plant;

has tryptamines => (
  is => 'rw',
  isa => 'Bool',
);

has dmt => (
  is => 'rq',
  isa => 'Bool',
);
