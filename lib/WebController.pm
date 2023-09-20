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
        response_content => '',
    };
    bless $self, $class;
    return $self;
}

sub create_storage {
    my ($self) = @_;
    my $cgi = $self->{cgi};

    my $name = $cgi->param('name');
    my $capacity = $cgi->param('capacity');

    if ($name && $capacity) {
        my $storage_id = $self->{storage}->create($name, $capacity);
        $self->{response_content} = "Storage created successfully";
    } else {
        my @storage_list = $self->{storage}->read_all();

        my $template = Template->new();
        my $template_file = 'templates/create_storage.tmpl';

        my $template_data = {
            storage_list => \@storage_list,
        };

        my $output;

        $template->process($template_file, $template_data, \$output)
            || die "Template rendering error: " . $template->error();

        $self->{response_content} = $output;
    }
}

sub create_vm {
    my ($self) = @_;
    my $cgi = $self->{cgi};

    my $name = $cgi->param('name');
    my $os = $cgi->param('os');
    my $storage_id = $cgi->param('storage_id');

    if ($name && $os && $storage_id) {
        my $vm_id = $self->{vm}->create($name, $os, $storage_id);        
        $self->{response_content} = "Virtual machine created successfully";
    } else {
        my @storage_list = $self->{storage}->read_all();
        my @vm_list = $self->{vm}->read_all();

        my $template = Template->new();
        my $template_file = 'templates/create_vm.tmpl';

        my $template_data = {
            storage_list => \@storage_list,
            vm_list      => \@vm_list,
        };

        my $output;

        $template->process($template_file, $template_data, \$output)
            || die "Template rendering error: " . $template->error();

        $self->{response_content} = $output;
    }
}

sub update_storage {
    my ($self) = @_;
    my $cgi = $self->{cgi};

    my $storage_id = $cgi->param('storage_id');
    my $name = $cgi->param('name');
    my $capacity = $cgi->param('capacity');

    if ($storage_id && $name && $capacity) {
        $self->{storage}->update($storage_id, $name, $capacity);
        $self->{response_content} = "Storage updated successfully";
    } else {
        my @storage_list = $self->{storage}->read_all();

        my $template = Template->new();
        my $template_file = 'templates/update_storage.tmpl';

        my $template_data = {
            storage_list => \@storage_list,
        };

        my $output;

        $template->process($template_file, $template_data, \$output)
            || die "Template rendering error: " . $template->error();

        $self->{response_content} = $output;
    }
}

sub update_vm {
    my ($self) = @_;
    my $cgi = $self->{cgi};

    my $vm_id = $cgi->param('vm_id');
    my $name = $cgi->param('name');
    my $os = $cgi->param('os');
    my $storage_id = $cgi->param('storage_id');
    
    if ($vm_id && $name && $os && $storage_id) {
        $self->{vm}->update($vm_id, $name, $os, $storage_id);
        $self->{response_content} = "Virtual machine updated successfully";
    } else {
        my @storage_list = $self->{storage}->read_all();
        my @vm_list = $self->{vm}->read_all();

        my $template = Template->new();
        my $template_file = 'templates/update_vm.tmpl';

        my $template_data = {
            storage_list => \@storage_list,
            vm_list      => \@vm_list,
        };

        my $output;

        $template->process($template_file, $template_data, \$output)
            || die "Template rendering error: " . $template->error();

        $self->{response_content} = $output;
    }
}

sub delete_vm {
    my ($self) = @_;
    my $cgi = $self->{cgi};

    my $vm_id = $cgi->param('vm_id');

    $self->{vm}->delete($vm_id);
    $self->{response_content} = "Virtual machine deleted successfully";
}

sub display_objects {
    my ($self) = @_;
    my $path_info = $self->{cgi}->path_info();
    
    my @storage_list = $self->{storage}->read_all();
    my @vm_list = $self->{vm}->read_all();

    my $template = Template->new();
    my $template_file = 'templates/index_template.tmpl';

    my $template_data = {
        storage_list => \@storage_list,
        vm_list      => \@vm_list,
    };

    my $output;

    $template->process($template_file, $template_data, \$output)
        || die "Template rendering error: " . $template->error();

    $self->{response_content} = $output;
}

sub show_error_page {
    my ($self) = @_;
    
    my $template = Template->new();
    my $template_file = 'templates/error_template.tmpl';

    my $template_data = {
        error_message => "An error occurred.",
    };

    my $output;
    
    $template->process($template_file, $template_data, \$output)
        || die "Template rendering error: " . $template->error();

    $self->{response_content} = $output;
}

sub get_response_content {
    my ($self) = @_;

    return $self->{response_content};
}

1;