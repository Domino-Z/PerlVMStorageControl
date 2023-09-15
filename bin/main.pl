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

my $dsn = "DBI:$db_type:dbname=$db_name";
my $dbh = DBI->connect($dsn, $db_user, $db_pass, { PrintError => 0, RaiseError => 1 });

my $sotrage = Storage->new($dsn);
my $vm = VirtualMachine->new($dsn);

my $cgi = CGI->new();
my $path_info = $cgi->path_info();
my $contorller = WebController->new($cgi, $sotrage, $vm);

