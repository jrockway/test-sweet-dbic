package t::lib::Schema::Result::Foo;
use strict;
use warnings;
use base 'DBIx::Class';

__PACKAGE__->load_components('Core');
__PACKAGE__->table('foo');
__PACKAGE__->add_columns(
    id => {
        data_type   => 'INTEGER',
        is_nullable => 0,
    },
    number => {
        data_type   => 'INTEGER',
        is_nullable => 0,
    },
);

__PACKAGE__->set_primary_key('id');


