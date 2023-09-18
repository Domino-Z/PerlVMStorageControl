#!/usr/bin/perl
use strict;
use warnings;
use DBI;
use CGI;

# use lib '../lib'; # Using this line of code will cause vscode to report an error, as @INC reading occurs in the interpreter
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

# print "Opened database successfully\n";

# Create a sotrage and vm object.
my $sotrage = Storage->new($dsn);
my $vm = VirtualMachine->new($dsn);

# Create a CGI object for HTTP request.
my $cgi = CGI->new();
my $path_info = $cgi->path_info();
my $contorller = WebController->new($cgi, $sotrage, $vm);

# routing
if ($path_info eq '/create_storage'){
    $contorller->create_storage();
}
elsif ($path_info eq '/create_vm') {
    $contorller->create_vm();
}
elsif ($path_info eq '/update_storage') {
    $contorller->update_storage();
}
elsif ($path_info eq '/delete_storage') {
    $contorller->delete_storage();
}
elsif ($path_info eq '/delete_vm') {
    $contorller->delete_vm();
}
elsif ($path_info eq '/display_objects') {
    $contorller->display_objects();
}
else {
    $contorller->show_error_page();
} 

print $cgi->header();
print $contorller->get_respose_content();