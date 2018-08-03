package Plant;

use Moose;

has 'name' => (
  is => 'rw',
  isa => 'Str',
);

has 'description' => (
  is => 'rw',
  isa => 'Str',
);

no Moose;
__PACKAGE__->meta->make_immutable;
1;
