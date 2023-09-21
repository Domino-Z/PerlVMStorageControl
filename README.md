# PerlVMStorageControl
PartⅠ

- [x] create a new repository

- [x] install Postgres

PartⅡ

- [x] Create a Perl module(Don't use Moose for this exercise.)

  - [x] VirtualMachine.pm

  - primary key 

  - name

  - operating system (a set of pre-defined values)

  - storage (every server can only have a single related storage object but one storage can be related to multiple servers)

  - checksum (a md5 hash of relevant server object properties)

  - create timestamp columns

  - update timestamp columns

  - [x] Storage.pm

  - primary key 

  - name

  - capacity

  - create timestamp columns

  - update timestamp columns

  - [x] WebController.pm

- [x] Link these two objects so they can be displayed together

- [x] Create unit test for the created module

PartⅢ

- [x] install apache

- [x] Create a web application that uses the created module

- [x] Add some CSS styling

