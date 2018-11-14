#!/usr/bin/env ruby

# An input file looks like
#
# Allocation
# Process 0: 0 1 0
# Process 1: 2 0 0
# Max
# Process 0: 7 5 3
# Process 1: 3 2 2
# Available
# 3 3 2

require 'strscan'

INPUT_FILE = 'sys_config.txt'.freeze

# Parses input
class Parser
  attr_reader :input, :scanner, :allocation, :max, :available

  def initialize(input = INPUT_FILE)
    # Read the input file all at once
    input = File.open(input, 'r').read

    # Convert line endings to unix style
    @input = input.encode!(input.encoding, universal_newline: true)

    @scanner = StringScanner.new input
  end

  # Actually parse the input
  def parse!
    @allocation = parse_process_list('Allocation', 'available')
    @max        = parse_process_list('Max', 'maximum')
    @available  = parse_list('Available')
  end

  # Parses input like
  #
  # title
  # Process n: a b c ...
  #
  # Where (n, a, b, c, ...) are integers
  #
  # Returns a hash like
  #  { :pid => n, :item => [a, b, c, ...] }
  #
  def parse_process_list(title, item)
    @scanner.skip(/#{title}\n/)

    data = scanner.scan(/(Process \d: \d( \d)*\n)*/)
                  .split(/\n/)
                  .map do |process|
                    process.match(
                      /Process (?<pid>\d):\s?(?<#{item}>\d( \d)*)/
                    ).named_captures
                  end

    data.map! do |process|
      {
        :pid => process['pid'].to_i,
        item.to_sym => process[item].split(/\s+/).map(&:to_i)
      }
    end
  end

  # Parses input like
  #
  # title
  # a, b, c, d, ...
  #
  # Where (a, b, c, ...) are integers
  #
  # Returns a list like
  #   [a, b, c, d, ...]
  #
  def parse_list(title)
    @scanner.skip(/#{title}\n/)

    data = @scanner.scan(/\d( \d)*/).split.map(&:to_i)
  end
end
