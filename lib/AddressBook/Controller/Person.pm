package AddressBook::Controller::Person;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }
extends 'Catalyst::Controller::FormBuilder';

=head1 NAME

AddressBook::Controller::Person - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

#sub index :Path :Args(0) {
#    my ( $self, $c ) = @_;
#
#    $c->response->body('Matched AddressBook::Controller::Person in Person.');
#}

=head2 list

Lists pepole (persons)

=cut

sub list : Path : Args(0) {
    my ( $self, $c ) = @_;
    my $people = $c->model('AddressDB::Person');
    $c->stash->{people} = $people;
}

=head2 delete

Remove people

=cut

sub delete : Local {
    my ( $self, $c, $id ) = @_;
    my $person = $c->model('AddressDB::Person')->find( { id => $id } );
    $c->stash->{person} = $person;
    if ($person) {
        $c->flash->{message} = 'Deleted ' . $person->name;
        $person->delete;

    }
    else {
        $c->flash->{error} = "No person $id";

    }
    $c->response->redirect( $c->uri_for_action('person/list') );
    $c->detach();

}

=head2 edit

Edit people

=cut

sub edit : Local Form {
    my ( $self, $c, $id ) = @_;
    my $form = $self->formbuilder;
    my $person = $c->model('AddressDB::Person')->find_or_new( { id => $id } );
    if ( $form->submitted && $form->validate ) {

        # form was submitted and it validated
        $person->firstname( $form->field('firstname') );
        $person->lastname( $form->field('lastname') );
        $person->update_or_insert;
        $c->stash->{message} =
          ( $id > 0 ? 'Updated ' : 'Added ' ) . $person->name;
        $c->forward('list');
    }
    else {
        # first time through, or invalid form
        if ( !$id ) {
            $c->stash->{message} = 'Adding a new person';
        }
        $form->field(
            name  => 'firstname',
            value => $person->firstname
        );
        $form->field(
            name  => 'lastname',
            value => $person->lastname
        );
    }
}

=head2 add

add people

=cut

sub add : Local Form('/person/edit') {
    my ( $self, $c ) = @_;
    $c->go( 'edit', [] );

}

=encoding utf8

=head1 AUTHOR

Álvaro Castellano Vela, alvaro.castellano.vela@gmail.com,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify it under the same terms as Perl itself.

=cut

#Using forms, package cannot be immitable
#__PACKAGE__->meta->make_immutable;

1;
