#!/usr/bin/perl
use strict;
use warnings;
use CGI;

# use lib qw(lib);
use FindBin;
use lib "$FindBin::RealBin/../lib";
use Storage;
use VirtualMachine;
use WebController;

my $db_type = 'Pg';
my $db_name = 'VMStorageControl';
my $db_user = 'program';
my $db_pass = 'program';
my $db_host = 'localhost';
my $db_port = '5432';

my $dsn = "DBI:$db_type:dbname=$db_name;host=$db_host;port=$db_port";
my $dbh = DBI->connect($dsn, $db_user, $db_pass, { PrintError => 0, RaiseError => 1 });

# Create a storage and vm object.
my $storage = Storage->new($dbh);
my $vm = VirtualMachine->new($dbh);

# Create a CGI object for HTTP request.
my $cgi = CGI->new();
my $path_info = $cgi->path_info();
my $controller = WebController->new($cgi, $storage, $vm);

my %route_map = (
    '/storage_list'   => 'storage_list',
    '/vm_list'        => 'vm_list',
    '/create_storage' => 'create_storage',
    '/create_vm'      => 'create_vm',
    '/update_storage' => 'update_storage',
    '/update_vm'      => 'update_vm',
    '/delete_storage' => 'delete_storage',
    '/delete_vm'      => 'delete_vm',
    '/'               => 'display_objects',
);

my $controller_method = $route_map{$path_info};
if ($controller_method) {
    $controller->$controller_method;
} else {
    $controller->show_error_page("Page not found");
}

my $response_content = $controller->get_response_content;

print $cgi->header;
print $response_content;