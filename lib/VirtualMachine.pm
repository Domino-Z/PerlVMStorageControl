package VirtualMachine;

use strict;
use warnings;
use DBI;

my $table_name = 'virtual_machine';

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
    unless ($name && $os && $storage_id) {
        die "Name, OS, and storage ID are required for virtual machine creation.";
    }

    my $sql = "INSERT INTO $table_name (name, os, storage_id) VALUES (?, ?, ?)";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($name, $os, $storage_id) || die "VM creation failed: " . $sth->errstr;

    my $vm_id = $self->{dbh}->last_insert_id(undef, undef, $table_name, undef);
    return $vm_id;
}

sub read {
    my ($self, $vm_id) = @_;
    unless ($vm_id) {
        die "VM ID is required for retrieving a virtual machine object.";
    }

    my $sql = "SELECT * FROM $table_name WHERE id = ?";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($vm_id) || die "VM retrieval by ID failed: " . $sth->errstr;

    my $vm_object = $sth->fetchrow_hashref();
    return $vm_object;
}

sub read_all {
    my ($self) = @_;

    my $sql = "SELECT id, name, os, storage_id FROM $table_name";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute() || die "VM retrieval failed: " . $sth->errstr;

    my @vm_list;
    while (my $row = $sth->fetchrow_hashref()) {
        push @vm_list, $row;
    }

    return @vm_list;
}

sub update {
    my ($self, $vm_id, $name, $os, $storage_id) = @_;

    unless ($vm_id && $name && $os && $storage_id) {
        die "VM ID, name, OS, and storage ID are required for virtual machine update.";
    }

    my $sql = "UPDATE $table_name SET name = ?, os = ?, storage_id = ? WHERE id = ?";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($name, $os, $storage_id, $vm_id) || die "VM update failed: " . $sth->errstr;
}

sub delete {
    my ($self, $vm_id) = @_;
    unless ($vm_id) {
        die "VM ID is required for virtual machine deletion.";
    }

    my $sql = "DELETE FROM $table_name WHERE id = ?";
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($vm_id) || die "VM deletion failed: " . $sth->errstr;
}

1;