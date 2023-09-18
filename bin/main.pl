#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use CGI;

use lib qw(lib);

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
my $storage = Storage->new($dsn);
my $vm = VirtualMachine->new($dsn);

# Create a CGI object for HTTP request.
my $cgi = CGI->new();
my $path_info = $cgi->path_info();
my $controller = WebController->new($cgi, $storage, $vm);

# routing
if ($path_info eq '/create_storage') {
    $controller->create_storage();
}
elsif ($path_info eq '/create_vm') {
    $controller->create_vm();
}
elsif ($path_info eq '/update_storage') {
    $controller->update_storage();
}
elsif ($path_info eq '/update_vm') {
    $controller->update_vm();
}
elsif ($path_info eq '/delete_storage') {
    $controller->delete_storage();
}
elsif ($path_info eq '/delete_vm') {
    $controller->delete_vm();
}
elsif ($path_info eq '/display_objects') {
    $controller->display_objects();
}
else {
    $controller->show_error_page();
}

print $cgi->header();
print $controller->get_response_content();