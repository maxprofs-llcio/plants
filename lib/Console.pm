package Console;

use Moose;

##
# If value was provided as a paramter use it otherwise prompt for the value
sub getValue {
  my $self = shift;
  my $value = shift;
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

no Moose;
__PACKAGE__->meta->make_immutable;
1;
