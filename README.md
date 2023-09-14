# PerlVMStorageControl
PartⅠ

- [x] create a new repository

- [x] install Postgres

PartⅡ

- [x] Create a Perl module(Don't use Moose for this exercise.)

  - [ ] VirtualMachine.pm

  - primary key 

  - name

  - operating system (a set of pre-defined values)

  - storage (every server can only have a single related storage object but one storage can be related to multiple servers)

  - checksum (a md5 hash of relevant server object properties)

  - create timestamp columns

  - update timestamp columns

  - [ ] Storage.pm

  - primary key 

  - name

  - capacity

  - create timestamp columns

  - update timestamp columns

  - [ ] DBConnector.pm

  - [ ] Controller.pm

- [ ] Link these two objects so they can be displayed together

- [ ] Create unit test for the created module

PartⅢ

- [x] install apache

- [ ] Create a web application that uses the created module

- [ ] Add some CSS styling

