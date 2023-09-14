package Storage;

use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = {
        name => shift,
        capacity => shift,
    };
    bless $self, $class;
    return $self;
}

sub get_name {
    my ($self) = @_;
    return $self->{name};
}

1;