use MooseX::Declare;

class t::Example {
    with 'Test::Sweet::DBIC' => { schema => 't::lib::Schema' };
    use Test::Sweet;
    use Test::More;
    use Test::Exception;

    has '+schema' => ( handles => ['resultset'] );

    test can_connect {
        ok $_[0]->schema, 'have schema';
    }

    test can_insert {
        my $self = shift;
        my $row;
        lives_ok {
            $row = $self->resultset('Foo')->create({ number => 42 });
        } 'creating number 42 lives';

        is $row->id, 1, 'id is 1';
        is $row->number, 42, 'number is 42';
    }

    test can_select {
        my $self = shift;
        my $rs = $self->resultset('Foo')->search({ number => 42 });
        is $rs->count, 1, 'got 1 record';
        my $row = $rs->next;
        is $row->id, 1, 'got id of 1';
        is $row->number, 42, 'got number 42';
    }
}
