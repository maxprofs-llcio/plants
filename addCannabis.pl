#!/usr/bin/perl -w

use lib 'lib/';
use Moose;
use Cannabis;
use Utils;

my $cannabis = Cannabis->new(
  name        => $utils->getValue('name'),
  description => $utils->getValue('description'),
  thcValue    => $utils->getValue('thcValue'),
  cbdValue    => $utils->getValue('cbdValue'),
  thcvValue   => $utils->getValue('thcvValue'),
  isStable    => $utils->getValue('isStable'),
);

$cannabis->saveRecord;
$cannabis->printStrainDescription;
