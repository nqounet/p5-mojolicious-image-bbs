#!/usr/bin/env perl
use Mojolicious::Lite;

plugin Mount => +{'/uploader/' => 'script/my_app'};

get '/' => 'index';

app->start;
__DATA__
@@ index.html.ep
<!DOCTYPE html>
<html>
<head><title>大きなシステム</title></head>
<body>

...
<h1><a href="/uploader/">画像掲示板</a></h1>
...

</body>
</html>
