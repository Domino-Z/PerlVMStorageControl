use strict;
use warnings;
use Test::More;

use lib 'lib';
use VirtualMachine;

my $db_type = 'Pg';
my $db_name = 'VMStorageControl';
my $db_user = 'program';
my $db_pass = 'program';
my $db_host = 'localhost';
my $db_port = '5432';

my $dsn = "DBI:$db_type:dbname=$db_name;host=$db_host;port=$db_port";
my $dbh = DBI->connect($dsn, $db_user, $db_pass, { PrintError => 0, RaiseError => 1 });

# # create a VirtualMachine object
my $vm = VirtualMachine->new($dbh);

# test create
my $vm_id = $vm->create("Test VM", "Linux", 1);
is($vm_id, 1, "Create VM");

# test read
my $retrieved_vm = $vm->read(1);
is($retrieved_vm->{name}, "Test VM", "Retrieve VM by ID");

# test update
$vm->update(1, "Updated VM", "Windows", 2);
$retrieved_vm = $vm->read(1);
is($retrieved_vm->{name}, "Updated VM", "Update VM");

# # test delete
# $vm->delete(1);
# $retrieved_vm = $vm->read(1);
# is($retrieved_vm, undef, "Delete VM");

done_testing();