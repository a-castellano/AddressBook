use strict;
use warnings;
use Test::More;

use Catalyst::Test 'AddressBook';
use AddressBook::Controller::Auth;

ok( request('/login')->is_success, 'Request should succeed' );
done_testing();
