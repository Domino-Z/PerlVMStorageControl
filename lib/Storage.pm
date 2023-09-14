package Storage;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {
        primary_key => undef,
        name => shift,
        capacity => shift,
        created_at => undef,
        updated_at => undef,
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

sub set_capacity {
    my ($self, $capacity) = @_;
    $self->{capacity} = $capacity;
}

sub get_capacity {
    my ($self) = @_;
    return $self->{capacity};
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