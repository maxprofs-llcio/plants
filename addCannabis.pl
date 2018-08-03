#!/usr/bin/perl -w

use lib 'lib/';
use Moose;
use Cannabis;
use Utils;

my $cannabis = Cannabis->new(
  name        => &Utils::getValue('name'),
  description => &Utils::getValue('description'),
  thcValue    => &Utils::getValue('thcValue'),
  cbdValue    => &Utils::getValue('cbdValue'),
  thcvValue   => &Utils::getValue('thcvValue'),
  isStable    => &Utils::getValue('isStable'),
);

$cannabis->saveRecord;
$cannabis->printStrainDescription;
