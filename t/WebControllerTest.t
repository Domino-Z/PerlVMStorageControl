use strict;
use warnings;
use Test::More;
use CGI;
use lib 'lib';
use Storage;
use VirtualMachine;
use WebController;

# Create a storage and vm object for testing
my $storage = Storage->new();
my $vm = VirtualMachine->new();

# Create a CGI object for testing
my $cgi = CGI->new();

# Create a WebController object for testing
my $controller = WebController->new($cgi, $storage, $vm);

# Test the display_objects method
{
    $controller->display_objects;
    my $response_content = $controller->get_response_content;

    my $expected_output = <<'HTML';
<!DOCTYPE html>
<html>
<head>
    <title>Object List</title>
</head>
<body>
    <h1>Object List</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Capacity/OS</th>
            <th>Actions</th>
        </tr>
    </table>
</body>
</html>
HTML

    is($response_content, $expected_output, 'display_objects test');
}

# Test the show_error_page method
{
    $controller->show_error_page;
    my $response_content = $controller->get_response_content;

    my $expected_output = <<'HTML';
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
</head>
<body>
    <h1>Oops! An Error Occurred</h1>
    <p>An error occurred.</p>
    <a href="/">Back to Home</a>
</body>
</html>
HTML

    is($response_content, $expected_output, 'show_error_page test');
}

done_testing;