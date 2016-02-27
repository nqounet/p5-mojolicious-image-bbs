package MyApp::Controller::Index;
use Mojo::Base 'Mojolicious::Controller';
use MyApp::Model::Entry;
use Mojo::Util ();
use Path::Tiny qw(path);

has model => sub { MyApp::Model::Entry->new(app => shift->app) };

sub _render {
    my $self = shift;

    $self->layout('default');
    $self->title('画像掲示板');
    my $model   = $self->model;
    my $entries = $model->load;
    $self->render(
        entries  => $entries,
        template => 'index/get',
        error    => '',
        @_
    );
}

# GET /
sub get { shift->_render }

# POST /
sub post {
    my $self = shift;

    my $subject     = $self->param('subject');
    my $description = $self->param('description');
    my $file        = $self->param('file');
    unless ($file->filename) {
        return $self->_render(
            template => 'index/get',
            error    => '画像ファイルがありません'
        );
    }

    my $prefix = Mojo::Util::md5_sum(Mojo::Util::steady_time());
    my $path = path($self->app->upload_dir, 'images', $prefix, $file->filename);
    $path->parent->mkpath;
    $file->move_to($path);
    my $src   = $path->relative($self->app->upload_dir)->absolute('/');
    my $entry = +{
        subject     => $subject,
        src         => $src->stringify,
        description => $description,
    };
    my $model = $self->model;
    $model->add($entry);
    return $self->redirect_to('/');
}

1;
__END__
