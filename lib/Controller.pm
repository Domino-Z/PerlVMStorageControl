package Controller;

use strict;
use warnings;

sub create_storage {
    my ($dbh, $name, $capacity) = @_;
        primary_key => undef,
        name => shift,
        capacity => shift,
        created_at => undef,
        updated_at => undef,
    my $storage = Storage->new($name, $capacity);
    $storage->save_to_database($dbh);
}

sub get_storage {
    my ($dbh, $primary_key) = @_;
    my $storage = Storage->load_from_database($dbh, $primary_key);
    return $storage;
}

1;