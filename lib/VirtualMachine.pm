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

}

sub read {
    my 
}

sub update {

}

sub delete {
    
}

1;