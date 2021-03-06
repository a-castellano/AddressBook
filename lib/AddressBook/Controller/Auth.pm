package AddressBook::Controller::Auth;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }
extends 'Catalyst::Controller::FormBuilder';

=head1 NAME

AddressBook::Controller::Auth - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub access_denied : Private {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'denied.tt2';

}

sub login : Global Form {
    my ( $self, $c ) = @_;
    my $form = $self->formbuilder;
    return unless $form->submitted && $form->validate;
    if (
        $c->authenticate(
            {
                username => $form->field('username'),
                password => $form->field('password')
            }
        )
      )
    {
        $c->flash->{message} = 'Logged in successfully.';
        $c->res->redirect( $c->uri_for('/') );
        $c->detach();

    }
    else {
        $c->stash->{error} = 'Login failed.';

    }

}

sub logout : Global {
    my ( $self, $c ) = @_;
    $c->logout;
    $c->flash->{message} = 'Logged out.';
    $c->res->redirect( $c->uri_for('/') );
}

=encoding utf8

=head1 AUTHOR

Álvaro Castellano Vela, alvaro.castellano.vela@gmail.com,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify it under the same terms as Perl itself.

=cut

1;
