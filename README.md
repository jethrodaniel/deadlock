# Programming Assignment 3

## Setup

This code is written in [Ruby](https://www.ruby-lang.org/en/), a programming
language that's pretty awesome. It should be installable via your OS's package
manager, but [rvm](https://rvm.io/) is worth checking out if you really get
into it.

For example, for Ubuntu 18.04:

```
sudo apt update && sudo apt install ruby
```

## Usage

This code comes with a nice little command line interface provided by
[thor](http://whatisthor.com/).

```
./bin/deadlock

Commands:
  deadlock [FILE]          # Parses input [FILE], then prints deadlock information
  deadlock help [COMMAND]  # Describe available commands or one specific command
```

To run the program on the test data
```
./bin/deadlock spec/fixtures/sys_config.txt

SAFE
```
```
./bin/deadlock spec/fixtures/unsafe.txt

UNSAFE
```

## Testing

Tests are implemented using [rspec](http://rspec.info/). To setup the tests,
ensure you have a local version of Ruby, then install [bundle](https://bundler.io/)
to set up development and test dependencies.

```
gem install bundle && bundle install
```

After that, you can run the tests by using

```
rspec
```
