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

class Parser
  attr_accessor :input, :scanner

  def initialize(input = INPUT_FILE)
    # Read the input file all at once
    input = File.open(input, 'r').read

    # Convert line endings to unix style
    @input = input.encode!(input.encoding, universal_newline: true)

    @scanner = StringScanner.new input
  end

  def parse
    @scanner.skip(/Allocation\n/)

    allocation = scanner.scan(/(Process \d: \d( \d)*\n)*/)
                        .split(/\n/)
                        .map do |process|
                          process.match(/Process (?<pid>\d):\s?(?<available>(\d )*)/)
                                 .named_captures
                        end
                        .tap do |ps|
                          ps.each do |p|
                            p['pid'] = p['pid'].to_i
                            p['available'] = p['available'].split(/\s+/)
                                                           .map(&:to_i)
                          end
                        end
  end
end
