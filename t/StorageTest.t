use Test::More tests => 4;
use Storage;

# create_object
my $storage = Storage->new();
ok($storage, "Storage object created");

# create_storage
my $id = $storage->create("Test Storage", 100);
ok($id, "Storage created successfully");

# read_storage
my $stored_data = $storage->read($id);
ok($stored_data, "Storage data read successfully");

# delete_storage
my $deleted = $storage->delete($id);
ok($deleted, "Storage deleted successfully");
