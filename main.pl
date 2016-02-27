#!/usr/bin/env perl
use Mojolicious::Lite;

plugin Mount => +{'/uploader/' => 'script/my_app'};

app->start;
