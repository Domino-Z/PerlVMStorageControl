use strict;
use warnings;
use Test::More;

use lib qw(lib);

use Storage;

my $db_type = 'Pg';
my $db_name = 'VMStorageControl';
my $db_user = 'program';
my $db_pass = 'program';
my $db_host = 'localhost';
my $db_port = '5432';

my $dsn = "DBI:$db_type:dbname=$db_name;host=$db_host;port=$db_port";
my $dbh = DBI->connect($dsn, $db_user, $db_pass, { PrintError => 0, RaiseError => 1 });

# create a Storage object
my $storage = Storage->new($dbh);

# test create
my $storage_id = $storage->create("Test Storage", 100);
is($storage_id, 1, "Create Storage");

# test read
my $retrieved_storage = $storage->read(1);
is($retrieved_storage->{name}, "Test Storage", "Retrieve Storage by ID");

# test update
$storage->update(1, "Updated Storage", 200);
$retrieved_storage = $storage->read(1);
is($retrieved_storage->{name}, "Updated Storage", "Update Storage");

# # test delete;
# $storage->delete(1);
# $retrieved_storage = $storage->read(1);
# is($retrieved_storage, undef, "Delete Storage");

done_testing();