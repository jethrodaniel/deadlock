# Programming Assignment 3

## Setup

This code is written in Ruby. To install Ruby, use your OS's package manager.

For example, for Ubuntu 18.04,

```
sudo apt update && sudo apt install ruby
```

will install Ruby.

## Usage

This code comes with a nice little command line interface.

```
$ ./bin/deadlock

Commands:
  deadlock help [COMMAND]  # Describe available commands or one specific command
  deadlock parse [FILE]    # Parses input [FILE], then prints deadlock information
```

To run the program on the test data
```
$ ./bin/deadlock parse spec/fixtures/sys_config.txt

TODO spec/fixtures/sys_config.txt
```

## Testing

Tests are implemented using Rspec. To setup the tests, ensure you have Ruby
installed, then install bundle to set up the Rubygem dependencies.

```
gem install bundle && bundle install
```

After that, you can run the tests by using

```
rspec
```
