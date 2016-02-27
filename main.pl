#!/usr/bin/env perl
use Mojolicious::Lite;

plugin Mount => +{'/uploader/' => 'script/my_app'};

get '/' => 'index';

app->start;
__DATA__
@@ index.html.ep
% title '大きなシステム';
<!DOCTYPE html>
<html>
<head><title><%= title %></title></head>
<body>

...
<h1><%= link_to '画像掲示板' => '/uploader/' %></h1>
...

</body>
</html>
