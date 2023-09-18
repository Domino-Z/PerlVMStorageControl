package WebController;

use strict;
use warnings;
use FindBin;
use Template;

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

    my $template_data = {
        storage_list => \@storage_list,
        vm_list      => \@vm_list,
    };

    my $output;
    $self->_render_template('index_template.tmpl', $template_data, \$output);
    
    $self->{response_content} = $output;

}

sub show_error_page {
    my ($self) = @_;
    
    my $output;
    $self->_render_template('error_template.tmpl', {}, \$output);

    $self->{response_content} = $output;
}

sub get_response_content {
    my ($self) = @_;

    return $self->{response_content};
}

sub _render_template {
    my ($self, $template_name, $template_data, $output_ref) = @_;
    
    my $template = Template->new({
        INCLUDE_PATH => "$FindBin::RealBin/../templates",
    });
    
    $template->process($template_name, $template_data, $output_ref) || die $template->error();
}


1;