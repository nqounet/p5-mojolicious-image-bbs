package MyApp::Model::Entry;
use Mojo::Base -base;
use Path::Tiny qw(path);
use Mojo::JSON qw(decode_json encode_json);

has [qw(app)];
has datafile => sub {
    my $self = shift;
    my $file = path($self->app->data_dir, 'data.json');
    unless ($file->is_file) {
        $file->parent->mkpath;
        $file->spew('[]');
    }
    return $file;
};

sub save {
    my $self = shift;

    my $entries  = shift;
    my $datafile = $self->datafile;
    my $json     = encode_json($entries);
    $datafile->spew($json);
    return;
}

sub load {
    my $self = shift;

    my $datafile = $self->datafile;
    my $json     = $datafile->slurp;
    my $entries  = decode_json($json);
    return $entries;
}

sub add {
    my $self = shift;

    my $entry   = shift;
    my $entries = $self->load;
    unshift @{$entries}, $entry;
    $self->save($entries);
}

1;
