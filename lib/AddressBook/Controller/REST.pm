package AddressBook::Controller::REST;
use strict;
use warnings;
use JSON;
use base qw(Catalyst::Controller::REST);

#__PACKAGE__->config->{serialize}{default} = 'JSON';
__PACKAGE__->config( default => 'application/json' );
__PACKAGE__->config(
    json_options => { relaxed => 1 }

);

sub begin : ActionClass('Deserialize') {
    my ( $self, $c ) = @_;
    my $username = $c->req->header('X-Username');
    my $password = $c->req->header('X-Password');

    # require either logged in user, or correct user+pass in headers
    if ( $c->user ) {

        # login failed
        $c->res->status(403);    # forbidden
        $c->res->body("You are not authorized to use the REST API.");
        $c->detach;
    }
}

sub single_user : Path('/userrest') : Args(0) : ActionClass('REST') {
    my ( $self, $c ) = @_;
    $c->stash->{'user'} = 1;
}

sub single_user_GET {
    my ( $self, $c ) = @_;
    return $self->status_ok(
        $c,
        entity => {
            radiohead => "Is a good band!",

        },
    );
}

#        $c->stash->{'user'} =  $c->model('AddressDBI')->count_users();
#
#}

1;
