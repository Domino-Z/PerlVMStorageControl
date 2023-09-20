package DB;

use strict;
use warnings;
use DBI;

sub new {
    my ($class, $dbh) = @_;
    my $self = {
        dbh => $dbh,
    };
    bless $self, $class;
    return $self;
}

sub execute_query {
    my ($self, $sql, @bind_params) = @_;
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute(@bind_params);
    if ($sth->errstr) {
        die "Database query failed: " . $sth->errstr;
    }
    return $sth;
}

sub disconnect {
    my ($self) = @_;
    $self->{dbh}->disconnect;
}

1;