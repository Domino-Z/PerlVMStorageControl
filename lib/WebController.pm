package WebController;

use strict;
use warnings;

sub new {
    my ($class, $cgi, $storage, $vm) = @_;
    my $self = {
        cgi => $cgi,
        sotrage => $storage,
        vm => $vm,
    };
    bless $self, $class;
    return $self;
}

sub create_storage {
    my ($self) = @_;
    
    my $name = $self->{cgi}->param('name');
    my $capacity = $self->{cgi}->param('capacity');

    # TODO: input validation
    my $storage_id = $self->{storage}->create($name, $capacity);
    # TODO: Redirect to success or failure page
}

sub create_vm {
    my ($self) = @_;

    my $name = $self->{cgi}->param('name');
    my $os = $self->{cgi}->param('os');
    my $sotrage_id = $self->{cgi}->param('storage_id');

    # TODO: input validation
    my $vm_id = $self->{vm}->create($name, $os, $sotrage_id);
    # TODO: Redirect to success or failure page
}

sub update_storage {
    my ($self) = @_;
    
    my $storage_id = $self->{cgi}->param->('storage_id');
    my $name = $self->{cgi}->param->('name');
    my $capacity = $self->{cgi}->param->('capacity');

    # TODO: input validation
    $self->{storage}->update($storage_id, $name, $capacity);
    # TODO: Redirect to success or failure page
}

sub update_vm {
    my ($self) = @_;
    
    my $vm_id = $self->{cgi}->param->('vm_id');
    my $name = $self->{cgi}->param->('name');
    my $os = $self->{cgi}->param->('os');
    my $storage_id = $self->{cgi}->param->('storage_id');

    # TODO: input validation
    $self->{vm}->update($vm_id, $name, $os, $storage_id);
    # TODO: Redirect to success or failure page
}

sub delete_storage {
    my ($self) = @_;

    my $storage_id = $self->{cgi}->param->('storage_id');

    $self->{storage}->delete($storage_id);
}

sub delete_vm {
    my ($self) = @_;

    my $vm_id = $self->{cgi}->param->('vm_id');

    $self->{storage}->delete($vm_id);
}

sub display_objects {
    my ($self) = @_;
    
    my @storage_list = $self->{storage}->read_all();
    my @vm_list = $self->{vm}->read_all();

    # TODO:using a template engine to render data into an HTML view


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