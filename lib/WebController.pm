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
# enum
my @valid_os_types = qw(Windows Linux);

sub create_storage {
    my ($self) = @_;
    my $cgi = $self->{cgi};

    my $name = $cgi->param('name');
    my $capacity = $cgi->param('capacity');

    if ($name && $capacity) {
        if ($capacity !~ /^\d+$/ || $capacity <= 0) {
            $self->{response_content} = "Capacity should be a positive integer.";
            return;
        }
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
    my $description = $cgi->param('description');

    if ($name && $os && $storage_id) {
        unless (grep { $_ eq $os } @valid_os_types) {
            $self->{response_content} = "Invalid OS type: $os";
            return;
        }
        my $vm_id = $self->{vm}->create($name, $os, $storage_id, $description);
        $self->{response_content} = "Virtual machine created successfully";
    } else {
        my @storage_list = $self->{storage}->read_all();
        
        my $storage_options = '';
        foreach my $storage (@storage_list) {
            my $storage_id = $storage->{id};
            my $storage_name = $storage->{name};
            $storage_options .= qq{<option value="$storage_id">$storage_name</option>};
        }

        my $template = Template->new();
        my $template_file = 'templates/create_vm.tmpl';

        my $template_data = {
            storage_options => $storage_options,
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

    if ($cgi->request_method() eq 'POST') {
        my $name = $cgi->param('name');
        my $capacity = $cgi->param('capacity');

        if ($capacity !~ /^\d+$/ || $capacity <= 0) {
            $self->{response_content} = "Capacity should be a positive integer.";
            return;
        }
        if ($name && $capacity) {
            $self->{storage}->update($storage_id, $name, $capacity);
            $self->{response_content} = "Storage updated successfully";
        } else {
            $self->{response_content} = "Please provide all required information.";
        }
    } else {
        my $storage = $self->{storage}->read($storage_id);

        if ($storage) {
            my $template = Template->new();
            my $template_file = 'templates/update_storage.tmpl';

            my $template_data = {
                storage => $storage,
            };

            my $output;

            $template->process($template_file, $template_data, \$output)
                || die "Template rendering error: " . $template->error();

            $self->{response_content} = $output;
        } else {
            $self->{response_content} = "Storage not found or an error occurred.";
        }
    }
}

sub update_vm {
    my ($self) = @_;
    my $cgi = $self->{cgi};

    my $vm_id = $cgi->param('vm_id');

    if ($cgi->request_method() eq 'POST') {
        my $name = $cgi->param('name');
        my $os = $cgi->param('os');
        my $storage_id = $cgi->param('storage_id');
        my $description = $cgi->param('description');

        if ($name && $os && $storage_id && $description) {
            unless (grep { $_ eq $os } @valid_os_types) {
                $self->{response_content} = "Invalid OS type: $os";
                return;
            }
            $self->{vm}->update($vm_id, $name, $os, $storage_id, $description);
            $self->{response_content} = "Virtual machine updated successfully";
        } else {
            $self->{response_content} = "Please provide all required information.";
        }
    } else {
        my $vm = $self->{vm}->read($vm_id);
        my @storage_list = $self->{storage}->read_all();

        if ($vm) {
            my $template = Template->new();
            my $template_file = 'templates/update_vm.tmpl';

            my $template_data = {
                vm => $vm,
                storage_list => \@storage_list,
            };

            my $output;

            $template->process($template_file, $template_data, \$output)
                || die "Template rendering error: " . $template->error();

            $self->{response_content} = $output;
        } else {
            $self->{response_content} = "Virtual machine not found or an error occurred.";
        }
    }
}

sub delete_vm {
    my ($self) = @_;
    my $cgi = $self->{cgi};

    my $vm_id = $cgi->param('vm_id');

    $self->{vm}->delete($vm_id);
    $self->{response_content} = "Virtual machine deleted successfully";
}

sub delete_storage {
    my ($self) = @_;
    my $cgi = $self->{cgi};

    my $storage_id = $cgi->param('storage_id');
    my @vm_list = $self->{vm}->read_all();
    my @associated_vms = grep { $_->{storage_id} == $storage_id } @vm_list;

    if (@associated_vms) {
        $self->{response_content} = "Cannot delete this storage as it is linked to one or more VMs.";
    } else {
        $self->{storage}->delete($storage_id); 
        $self->{response_content} = "Storage deleted successfully";
    }
}

sub storage_list {
    my ($self) = @_;
    my @storage_list = $self->{storage}->read_all();
    
    my $template = Template->new();
    my $template_file = 'templates/storage_list.tmpl';

    my $template_data = {
        storage_list => \@storage_list,
    };

    my $output;
    
    $template->process($template_file, $template_data, \$output)
        || die "Template rendering error: " . $template->error();

    $self->{response_content} = $output;
}

sub vm_list {
    my ($self) = @_;

    my @vm_list = $self->{vm}->read_all();

    for my $vm (@vm_list) {
        my $storage = $self->{storage}->read($vm->{storage_id});
        $vm->{storage_id} = $storage->{id};
        $vm->{storage_name} = $storage->{name};
    }

    my $template = Template->new();
    my $template_file = 'templates/vm_list.tmpl';
    my $template_data = {
        vm_list => \@vm_list,
    };

    my $output;
    $template->process($template_file, $template_data, \$output)
        || die "Template rendering error: " . $template->error();

    $self->{response_content} = $output;
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

    for my $vm (@vm_list) {
        my $storage = $self->{storage}->read($vm->{storage_id});
        $vm->{storage_id} = $storage->{id};
        $vm->{storage_name} = $storage->{name};
    }

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