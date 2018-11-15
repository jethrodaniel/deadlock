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

# Parses input
class Parser
  attr_reader :input, :scanner, :allocation, :max, :available

  def initialize(input)
    # Read the input file all at once
    input = File.open(input, 'r').read

    # Convert line endings to unix style
    @input = input.encode!(input.encoding, universal_newline: true)

    @scanner = StringScanner.new input

    # Parse the data
    @allocation = parse_process_list('Allocation', 'available')
    @max        = parse_process_list('Max', 'maximum')
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
  # Returns an array of hashes like
  #  [
  #    { :pid => x, :item => [a, b, c, ...] }
  #    { :pid => y, :item => [a, b, c, ...] }
  #  ]
  #
  def parse_process_list(title, item)
    @scanner.skip(/#{title}\n/)

    @scanner.scan(/(Process \d: \d( \d)*\n)*/)
            .split(/\n/)
            .map do |process|
              process.match(
                /Process (?<pid>\d):\s?(?<#{item}>\d( \d)*)/
              ).named_captures
            end
            .tap do |hash|
              hash.map! do |process|
                {
                  :pid => process['pid'].to_i,
                  item.to_sym => process[item].split(/\s+/).map(&:to_i)
                }
              end
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

    @scanner.scan(/\d( \d)*/).split.map(&:to_i)
  end
end
