package Session;

use Moose;

has 'authenticated' => (
  is  =>  'rw',
  isa =>  'Bool',
);

has 'secret_code' => (
  is  =>  'rw',
  isa =>  'Str',
);

sub Authenticate() {
  my $Session = shift;
  if( $Session->secret_code eq 'STEVE!' ) {
    $Session->authenticated(1);
    return $Session->authenticated;
  }
  return 0;
}

sub soSoz() {
     my $html  = "<h1>We so soz!!!</h1>";
     $html .= "<p>We can't let you see that unless you knows the codez</p>";
     $html .= "<p>kthxbai</p>";
     return $html;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
