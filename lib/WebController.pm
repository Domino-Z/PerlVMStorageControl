package WebController;

use strict;
use warnings;

sub new {
    my ($class, $cgi, $storage, $vm) = @_;
    my $self = {
        cgi     => $cgi,
        sotrage => $storage,
        vm      => $vm,
    };
    bless $self, $class;
    return $self;
}

sub create_storage {
    my ($self) = @_;
    
    my $name     = $self->{cgi}->param('name');
    my $capacity = $self->{cgi}->param('capacity');

    # TODO: input validation
    my $storage_id = $self->{storage}->create($name, $capacity);
    # TODO: Redirect to success or failure page
}

sub create_vm {

}

sub update_storage {

}

sub update_vm {

}

sub delete_storage {
    
}

sub delete_vm {

}

sub display_objects {

}

sub show_error_page {
    my ($self) = @_;
    
    # TODO:error_page
}

sub get_respose_content {
    my ($self) = @_;

    # TODO:HTTP_respose
}

1;