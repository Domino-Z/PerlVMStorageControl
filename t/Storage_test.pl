use strict;
use warnings;

use FindBin;
use lib "$FindBin::RealBin/../lib";
use Controller;


print "which methods do you want?(from cmd)\n";
my $request_type = $ARGV[0];

# create_storage
if ($request_type eq 'create_storage'){
    my ($name, $capacity) = @ARGV[1, 2];
    Controller::create_storage($name, $capacity);
}
