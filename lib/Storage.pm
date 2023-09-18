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
    unless ($name && $capacity) {
        die "Name and capacity are required for storage creation.";
    }

    my $sql = "INSERT INTO storage (name, capacity) VALUES (?, ?)";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($name, $capacity) || die "Storage creation failed: " . $sth->errstr;

    my $storage_id = $self->{dbh}->last_insert_id(undef, undef, 'storage', undef);
    return $storage_id;
}

sub read {
    my ($self, $storage_id) = @_;
    unless ($storage_id) {
        die "Storage ID is required for retrieving a storage object.";
    }

    my $sql = "SELECT * FROM storage WHERE id = ?";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($storage_id) || die "Storage retrieval by ID failed: " . $sth->errstr;

    my $storage_object = $sth->fetchrow_hashref();
    return $storage_object;
}

sub read_all {
    my ($self) = @_;

    my $sql = "SELECT * FROM storage";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute() || die "Storage retrieval failed: " . $sth->errstr;

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

    my $sql = "UPDATE storage SET name = ?, capacity = ? WHERE id = ?";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($name, $capacity, $storage_id) || die "Storage update failed: " . $sth->errstr;
}

sub delete {
    my ($self, $storage_id) = @_;
    unless ($storage_id) {
        die "Storage ID is required for storage deletion.";
    }

    my $sql = "DELETE FROM storage WHERE id = ?";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($storage_id) || die "Storage deletion failed: " . $sth->errstr;
}

1;