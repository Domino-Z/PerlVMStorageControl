#!/usr/bin/perl
use DBI;
my $db_host = 'localhost';
my $db_user = 'program';
my $db_pass = 'program';
my $db_name = 'VMStorageControl';
my $db = "dbi:pg:dbname=${db_name};host=${db_host}";
$dbh = DBI->connect($db, $db_user, $db_pass,{ RaiseError => 1, AutoCommit => 0 }) 

