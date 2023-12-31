package VirtualMachine;

use strict;
use warnings;
use base qw(DB);

my $table_name = 'virtual_machine';

sub create {
    my ($self, $name, $os, $storage_id, $description) = @_;
    unless ($name && $os && $storage_id) {
        die "Name, OS, and storage ID are required for virtual machine creation.";
    }

    my $sql = "INSERT INTO $table_name (name, os, storage_id, description) VALUES (?, ?, ?, ?)";
    my $sth = $self->execute_query($sql, $name, $os, $storage_id, $description);

    my $vm_id = $self->{dbh}->last_insert_id(undef, undef, $table_name, undef);
    return $vm_id;
}

sub read {
    my ($self, $vm_id) = @_;
    unless ($vm_id) {
        die "VM ID is required for retrieving a virtual machine object.";
    }

    my $sql = "SELECT * FROM $table_name WHERE id = ?";
    my $sth = $self->execute_query($sql, $vm_id);

    my $vm_object = $sth->fetchrow_hashref();
    return $vm_object;
}

sub read_all {
    my ($self) = @_;

    my $sql = "SELECT * FROM $table_name";
    my $sth = $self->execute_query($sql);

    my @vm_list;
    while (my $row = $sth->fetchrow_hashref()) {
        push @vm_list, $row;
    }

    return @vm_list;
}

sub read_by_storage_id {
    my ($self, $storage_id) = @_;

    my $sql = "SELECT * FROM $table_name WHERE storage_id = ?";
    
    my $sth = $self->{dbh}->prepare($sql);
    $sth->execute($storage_id);
    
    my @vms = ();
    while (my $row = $sth->fetchrow_hashref) {
        push @vms, $row;
    }
    
    return @vms;
}

sub update {
    my ($self, $vm_id, $name, $os, $storage_id, $description) = @_;
    unless ($vm_id && $name && $os && $storage_id) {
        die "VM ID, name, OS, and storage ID are required for virtual machine update.";
    }

    my $sql = "UPDATE $table_name SET name = ?, os = ?, storage_id = ?, description = ? WHERE id = ?";
    my $sth = $self->execute_query($sql, $name, $os, $storage_id, $description, $vm_id);
}

sub delete {
    my ($self, $vm_id) = @_;
    unless ($vm_id) {
        die "VM ID is required for virtual machine deletion.";
    }

    my $sql = "DELETE FROM $table_name WHERE id = ?";
    my $sth = $self->execute_query($sql, $vm_id);
}

1;