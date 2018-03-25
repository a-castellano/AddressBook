#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

=head1 NAME
import_csv.pl - imports CSV files into the address book
=head1 FORMAT
The data should be in CSV format with the following fields:
firstname, lastname, address location, address, phone, email
=cut

use Cwd 'abs_path';
use Text::CSV_XS;

use FindBin qw($Bin);
use Path::Class;
use lib dir( $Bin, '..', 'lib' )->stringify;

use AddressBook::Schema::AddressDB;
use Config::JFDI;
use strict;

my $filename = file( $Bin, '..', 'addressbook.conf' )->stringify;

#my $abs_path = abs_path( $filename ) ;
my $config = Config::JFDI->new( path => $filename );
my $dsn = $config->get->{'Model::AddressDB'};

print "$dsn\n";

#return 1;

#my $schema = AddressBook::Schema::AddressDB->connect($dsn)
#  or die "Failed to connect to database at $dsn";
#
#while ( my $line = <> ) {
#    eval {
#        my $csv = Text::CSV_XS->new();
#        $csv->parse($line) or die "Invalid data";
#        my ( $first, $last, $location, $address, $phone, $email ) =
#          $csv->fields();
#        my $person = $schema->resultset('Person')->find_or_create(
#            {
#                firstname => $first,
#                lastname  => $last,
#            }
#        );
#        $schema->resultset('Address')->create(
#            {
#                person   => $person,
#                location => $location,
#                postal   => $address,
#                phone    => $phone,
#                email    => $email,
#            }
#        );
#        print "Added @{[$person->name]}'s $location address.\n";
#    };
#    if ($@) {
#        warn "Problem adding address: $@";
#    }
#}
