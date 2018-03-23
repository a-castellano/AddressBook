package AddressBook::Model::AddressDB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'AddressBook::Schema::AddressDB',

    connect_info => {
        dsn      => 'dbi:SQLite:tmp/database',
        user     => '',
        password => '',
    }
);

=head1 NAME

AddressBook::Model::AddressDB - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<AddressBook>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<AddressBook::Schema::AddressDB>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.65

=head1 AUTHOR

Álvaro Castellano Vela, alvaro.castellano.vela@gmail.com,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

1;
