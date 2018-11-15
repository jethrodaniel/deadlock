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
require 'matrix'

require_relative '../ext/array'

# Parses input
class Parser
  using ArrayToMatrix

  attr_reader :input, :scanner, :allocation, :max, :available

  def initialize(input)
    # Read the input file all at once
    input = File.open(input, 'r').read

    # Convert line endings to unix style
    @input = input.encode!(input.encoding, universal_newline: true)

    @scanner = StringScanner.new input

    # Parse the data
    @allocation = parse_process_list('Allocation', 'available').to_matrix
    @max        = parse_process_list('Max', 'maximum').to_matrix
    @available  = parse_list 'Available'
  end

  def data
    { allocation: @allocation, max: @max, available: @available }
  end

  private

  # Parses input like
  #
  # title
  # Process x: a b c ...
  # Process y: a b c ...
  #   ...
  #
  # Where (x, y, a, b, c, ...) are integers
  #
  # Returns an array of arrays like
  #  [
  #    [x, a, b, c, ...],
  #    [y, a, b, c, ...]
  #  ]
  #
  def parse_process_list(title, item)
    @scanner.skip(/#{title}\n/)

    @scanner.scan(/(Process \d: \d( \d)*\n)*/)
            .split(/\n/)
            .map { |process| process.scan(/\d/).map(&:to_i) }
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

    @scanner.scan(/\d( \d)*/).split.map(&:to_i)
  end
end
