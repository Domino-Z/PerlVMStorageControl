package WebController;

use strict;
use warnings;
use Template;

sub new {
    my ($class, $cgi, $storage, $vm) = @_;
    my $self = {
        cgi => $cgi,
        storage => $storage,
        vm => $vm,
    };
    bless $self, $class;
    return $self;
}

sub create_storage {
    my ($self) = @_;
    my $cgi = $self->{cgi};
    
    my $name = $cgi->{cgi}->param('name');
    my $capacity = $cgi->{cgi}->param('capacity');

    my $storage_id = $self->{storage}->create($name, $capacity);
    # TODO: Redirect to success or failure page
}

sub create_vm {
    my ($self) = @_;
    my $cgi = $self->{cgi};

    my $name = $cgi->{cgi}->param('name');
    my $os = $cgi->{cgi}->param('os');
    my $storage_id = $cgi->{cgi}->param('storage_id');

    my $vm_id = $self->{vm}->create($name, $os, $storage_id);
    # TODO: Redirect to success or failure page
}

sub update_storage {
    my ($self) = @_;
    my $cgi = $self->{cgi};

    my $storage_id = $cgi->{cgi}->param->('storage_id');
    my $name = $cgi->{cgi}->param->('name');
    my $capacity = $cgi->{cgi}->param->('capacity');

    $self->{storage}->update($storage_id, $name, $capacity);
    # TODO: Redirect to success or failure page
}

sub update_vm {
    my ($self) = @_;
    my $cgi = $self->{cgi};
    
    my $vm_id = $cgi->{cgi}->param->('vm_id');
    my $name = $cgi->{cgi}->param->('name');
    my $os = $cgi->{cgi}->param->('os');
    my $storage_id = $cgi->{cgi}->param->('storage_id');

    $self->{vm}->update($vm_id, $name, $os, $storage_id);
    # TODO: Redirect to success or failure page
}

sub delete_storage {
    my ($self) = @_;
    my $cgi = $self->{cgi};

    my $storage_id = $cgi->{cgi}->param->('storage_id');

    $self->{storage}->delete($storage_id);
}

sub delete_vm {
    my ($self) = @_;
    my $cgi = $self->{cgi};

    my $vm_id = $cgi->{cgi}->param->('vm_id');

    $self->{storage}->delete($vm_id);
}

sub display_objects {
    my ($self) = @_;
    
    my @storage_list = $self->{storage}->read_all();
    my @vm_list = $self->{vm}->read_all();

    # Template Toolkit
    my $template = Template->new();
    my $template_file = 'templates/index_template.tmpl';

    my $template_data = {
        storage_list => \@storage_list,
        vm_list      => \@vm_list,
    };

    my $output;

    $template->process($template_file, $template_data, \$output)
        || die "Template rendering error: " . $template->error();

    print "Content-Type: text/html\n\n";
    print $output;
}

sub show_error_page {
    my ($self) = @_;
    
    # Template Toolkit
    my $template = Template->new();
    my $template_file = 'templates/error_template.tmpl';

    my $template_data = {
        error_message => "An error occurred.",
    };

    my $output;
    
    $template->process($template_file, $template_data, \$output)
        || die "Template rendering error: " . $template->error();

    print "Content-Type: text/html\n\n";
    print $output;
}

sub get_response_content {
    my ($self) = @_;

    return $self->{response_content};
}

1;