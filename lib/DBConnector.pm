package DBConnector;

use strict;
use warnings;
use DBI;

sub connect_to_database {
    my $dbh = DBI->connect(
        "dbh:Pg:dbname=postgress;host=127.0.0.1",
        "program",
        "program",
        { RaiseError => 1, AutoCommit => 1 }
    ) or die "Can't connect to the database: $DBI::errstr";
    return $dbh;
}

sub disconnect_from_database {
    my ($dbh) = @_;
    $dbh->disconnect;
}