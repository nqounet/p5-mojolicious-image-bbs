package MyApp;
use Mojo::Base 'Mojolicious';

has upload_dir => sub { shift->home . '/var/upload' };
has data_dir   => sub { shift->home . '/var/data' };

sub startup {
    my $app = shift;

    push @{$app->static->paths}, $app->upload_dir;

    my $r = $app->routes;

    $r->get('/')->to('index#get');
    $r->post('/')->to('index#post');
}

1;
