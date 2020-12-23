#!/usr/bin/env perl
use 5.020;
use Mojolicious::Lite -signatures;
use Mojo::Pg;

plugin 'Config';

app->secrets(app->config->{secrets}) if defined app->config->{secrets};

my $pg_url = app->config->{pg} // die "No pg connection URL configured";
my $migrations_file = app->home->child('rgcdb.sql');
my $pg;
helper pg => sub { $pg //= Mojo::Pg->new($pg_url)->tap(sub { $_->migrations->from_file($migrations_file)->migrate }) };

get '/';

app->start;
