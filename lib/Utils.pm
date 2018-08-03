package Utils;

use Moose;

##
# If value was provided as a paramter use it otherwise prompt for the value
sub getValue {
  my $value = $_[0];
  foreach my $arg (@ARGV) {
    if( $arg =~ m/$value/ ) {
      (undef, $value) = split(/=/, $arg);
      chomp $value;
      return $value;
    }
  }
  print "$value : ";
  $value = <STDIN>;
  chomp $value;
  return $value;
}
1;
