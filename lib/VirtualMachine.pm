package VirtualMachine;

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
    my ($self, $name, $os, $storage_id) = @_;
    my $sql = "INSERT INTO virtual_machine (name, os, storage_id) VALUES(?, ?, ?)";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($name, $os, $storage_id);
    return $self->{dbh}->last_insert_id()
}

sub read {
    my ($self, $id) = @_;
    my $sql = "SELECT * FROM virtual_machine WHERE id = ?";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($id);
    return $self->fetchrow_hashref();
}

sub read_all {
    my ($self, $id) = @_;
    my $sql = "SELECT * FROM virtual_machine";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute();
    return $self->fetchrow_hashref();
}

sub update {
    my ($self, $id, $name, $os, $storage_id) = @_;
    my $sql = "UPDATE virtual_machine SET name = ?, os = ?,storage_id = ? WHERE id = ?";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($name, $os, $storage_id, $id);
    return 1;
}

sub delete {
    my ($self, $id) = @_;
    my $sql = "DELETE FROM virtual_machine WHERE id =?";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($id);
    return 1;
}

1;