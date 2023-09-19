package Storage;

use strict;
use warnings;
use base qw(DB);

my $table_name = 'storage';

sub create {
    my ($self, $name, $capacity) = @_;
    unless ($name && $capacity) {
        die "Name and capacity are required for storage creation.";
    }

    my $sql = "INSERT INTO $table_name (name, capacity) VALUES (?, ?)";
    my $sth = $self->execute_query($sql, $name, $capacity);

    my $storage_id = $self->{dbh}->last_insert_id(undef, undef, $table_name, undef);
    return $storage_id;
}

sub read {
    my ($self, $storage_id) = @_;
    unless ($storage_id) {
        die "Storage ID is required for retrieving a storage object.";
    }

    my $sql = "SELECT * FROM $table_name WHERE id = ?";
    my $sth = $self->execute_query($sql, $storage_id);

    my $storage_object = $sth->fetchrow_hashref();
    return $storage_object;
}

sub read_all {
    my ($self) = @_;

    my $sql = "SELECT * FROM $table_name";
    my $sth = $self->execute_query($sql);

    my @storage_list;
    while (my $row = $sth->fetchrow_hashref()) {
        push @storage_list, $row;
    }

    return @storage_list;
}

sub update {
    my ($self, $storage_id, $name, $capacity) = @_;
    unless ($storage_id && $name && $capacity) {
        die "Storage ID, name, and capacity are required for storage update.";
    }

    my $sql = "UPDATE $table_name SET name = ?, capacity = ? WHERE id = ?";
    my $sth = $self->execute_query($sql, $name, $capacity, $storage_id);
}

sub delete {
    my ($self, $storage_id) = @_;
    unless ($storage_id) {
        die "Storage ID is required for storage deletion.";
    }

    my $sql = "DELETE FROM $table_name WHERE id = ?";
    my $sth = $self->execute_query($sql, $storage_id);
}

1;