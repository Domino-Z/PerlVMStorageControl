package VirtualMachine;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {
        primary_key => undef,
        name => shift,
        operating_system => shift,
        storage => undef,
        checksum => undef,
        create_at => undef,
        update_at => undef,
    };
    bless $self, $class;
    return $self;
}

sub set_primary_key {
    my ($self, $primary_key) = @_;
    $self->{primary_key} = $primary_key;
}

sub get_primary_key {
    my ($self) = @_;
    return $self->{primary_key};
}

sub set_name {
    my ($self, $name) = @_;
    $self->{name} = $name;
}

sub get_name {
    my ($self) = @_;
    return $self->{name};
}

sub set_operating_system {
    my ($self, $operating_system) = @_;
    $self->{operating_system} = $operating_system;
}

sub get_operating_system {
    my ($self) = @_;
    return $self->{operating_system};
}

sub set_storage {
    my ($self, $storage) = @_;
    $self->{storage} = $storage;
}

sub get_storage {
    my ($self) = @_;
    return $self->{storage}
}

sub set_checksum {
    my ($self, $checksum) = @_;
    $self->{checksum} = $checksum;
}

sub get_checksum {
    my ($self) = @_;
    return $self->{checksum};
}

sub set_created_at {
    my ($self, $created_at) = @_;
    $self->{created_at} = $created_at;
}

sub get_created_at {
    my ($self) = @_;
    return $self->{created_at};
}

sub set_updated_at {
    my ($self, $updated_at) = @_;
    $self->{updated_at} = $updated_at;
}

sub get_updated_at {
    my ($self) = @_;
    return $self->{updated_at}
}

1;