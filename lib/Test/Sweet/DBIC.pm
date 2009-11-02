use MooseX::Declare;

role Test::Sweet::DBIC (Str|ClassName :$schema) {
    use DBICx::TestDatabase;
    use Moose::Util::TypeConstraints;

    class_type $schema;

    has 'schema' => (
        traits     => ['NoGetopt'],
        is         => 'ro',
        isa        => $schema,
        lazy_build => 1,
    );

    has 'real_database' => (
        is            => 'ro',
        isa           => 'Str',
        required      => 0,
        documentation => 'If specified, use a the database at this DSN instead of a test database.',
        predicate     => 'has_real_database',
    );

    method _build_schema {
        if(!$self->has_real_database){
            return DBICx::TestDatabase->connect($schema);
        }
        else {
            Class::MOP::load_class($schema);
            return $schema->connect($self->real_database);
        }
    }

}
