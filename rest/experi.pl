#!/usr/bin/env perl
use lib 'lib/';
use Mojolicious::Lite;
use Plant::Cannabis;
use MLDBM qw(DB_File Storable);
use Session;

get '/' => sub {
  my $content = shift;
  $content->render(text=>"Bohar?");
};

get '/list' => sub {
  my $content = shift;
  my $Session = Session->new(
    authenticated => 0,
    secret_code => $content->param('secret_code'),
  );

  $Session->Authenticate();
  if ($Session->authenticated) {
    my %list = Cannabis::getCannabis();
    my %shortList;
    foreach my $key (keys %list) {
       my $cannabis = Cannabis->new(%{$list{$key}});
       $shortList{$cannabis->name}{'description'} = $cannabis->description;
       $shortList{$cannabis->name}{'thc:cbd:thcv'} = $cannabis->getRatio;
    }
    $content->render(json => \%shortList);
   } else {
     my $html  = "<h1>We so soz!!!</h1>";
     $html .= "<p>We can't let you see that unless you knows the codez</p>";
     $html .= "<p>kthxbai</p>";
     $content->render(text => $html);
   }
};

get '/search' => sub {
  my $content = shift;
  my $dataFile = 'data/Cannabis.bdb';
  my %search;
  my $dbm = tie %search, 'MLDBM', $dataFile or die $!;
  undef $dbm;

  my $Session = Session->new(
    authenticated => 0,
    secret_code => $content->param('secret_code'),
  );

  $Session->Authenticate();

  if($Session->authenticated) {
    if($content->param('name')) {
      my $cannabis = Cannabis->new(%{$search{$content->param('name')}});
      ##
      # use object introspection to render json of search results
      my %shortList;
      my $meta = $cannabis->meta();
      for my $attribute ($meta->get_all_attributes ) {
        $shortList{$content->param('name')}{$attribute->name()} = $cannabis->{$attribute->name()};
      }
      $content->render(json => \%shortList);
    } else {
      $content->render(text => $Session->soSoz() );
    }
  } else {
    $content->render(text => $Session->soSoz() );
  }
};

app->start;
