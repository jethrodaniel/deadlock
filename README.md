# Programming Assignment 3

## Setup

This code is written in [Ruby](https://www.ruby-lang.org/en/), a programming
language that's pretty awesome. It should be installable via your OS's package
manager, but [rvm](https://rvm.io/) is a more reliable solution.

To install ruby with rvm (from [here](https://rvm.io/rvm/install)):

```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source "$HOME/.rvm/scripts/rvm"
```

You also need so download the dependencies, which are managed by bundler.

```
gem install bundle
bundle install
```

## Usage

This code comes with a nice little command line interface provided by
[thor](http://whatisthor.com/).

```
./bin/deadlock

Commands:
  deadlock exec [FILE]     # Parses input [FILE], then prints deadlock information
  deadlock help [COMMAND]  # Describe available commands or one specific command
```

To run the program on the test data
```
./bin/deadlock exec spec/fixtures/sys_config.txt

SAFE
Request Vector: 1 0 2
GRANTED
Request Vector: 1 0 2 3
Wrong input!
Request Vector: 12 2 2
Wrong input!
Request Vector:
Exiting...
```

```
./bin/deadlock spec/fixtures/unsafe.txt

UNSAFE
```

## Testing

Tests are implemented using [rspec](http://rspec.info/).

Run the tests by calling

```
rspec
```
