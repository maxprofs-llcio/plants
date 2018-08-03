#!/usr/bin/perl -w

use lib 'lib/';
use Moose;
use Plant::Cannabis;
use Console;

my $console = Console->new();

my $cannabis = Cannabis->new(
  name        => $console->getValue('name'),
  description => $console->getValue('description'),
  thcValue    => $console->getValue('thcValue'),
  cbdValue    => $console->getValue('cbdValue'),
  thcvValue   => $console->getValue('thcvValue'),
  isStable    => $console->getValue('isStable'),
);

$cannabis->saveRecord;
$cannabis->printStrainDescription;
