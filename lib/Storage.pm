package Storage;

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

sub create {
    my ($self, $name, $capacity) = @_;
    my $sql = "INSERT INTO storage (name, capacity) VALUES (?, ?)";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($name, $capacity);
    return $self->{dbh}->last_insert_id(undef, undef, 'storage', undef);
}

sub read {
    my ($self, $id) = @_;
    my $sql = "SELECT * FROM sotrage WHERE id = ?";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($id);
    return $self->fetchrow_hashref();
}

sub read_all {
    my ($self, $id) = @_;
    my $sql = "SELECT * FROM sotrage";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute();
    return $self->fetchrow_hashref();
}

sub update {
    my ($self, $id, $name, $capacity) = @_;
    my $sql = "UPDATE storage SET name = ?, capacity = ? WHERE id = ?";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($name, $capacity, $id);
    return 1;

}

sub delete {
    my ($self, $id) = @_;
    my $sql = "DELETE FROM storage WHERE id = ?";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($id);
    return 1;
}

1;