#!/usr/bin/env perl
use lib 'lib/';
use Mojolicious::Lite;
use Cannabis;
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
     $content->render(text=>"kthxbai");
   }
};

app->start;
