#!/usr/bin/perl
use strict;
use warnings;

# use lib '../lib'; # Using this line of code will cause vscode to report an error, as @INC reading occurs in the interpreter
use FindBin;
use lib "$FindBin::RealBin/../lib";

use Storage;
use VirtualMachine;

my $vm = VirtualMachine->new("vm1");
my $storage = Storage->new("sto1","100GB");

print "Virtual Machine Name: " . $vm->get_name() . "\n";
print "Storage Name: " . $storage->get_name() . "\n";