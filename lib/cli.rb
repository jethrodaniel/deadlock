# frozen_string_literal: true

require 'thor'

require_relative 'parser'
require_relative 'banker'

# Handle interrupts to exit gracefully
module CleanExit
  %w[SIGINT INT].each do |signal|
    trap(signal) do
      Thor::Shell::Basic.new.say "\nExiting...", :cyan
      exit
    end
  end
end

# The main command line interface
class CLI < Thor
  include CleanExit

  # The command to run an input file
  desc 'exec [FILE]', 'Parses input [FILE], then prints deadlock info'
  def exec(file)
    data = Parser.new(file).data
    banker = Banker.new(**data)

    # Output whether the system is in a safe state
    if banker.safe?
      say 'SAFE', :green, :bold
    else
      say 'UNSAFE', :red, :bold
    end

    # Continually ask for a request vector, granting the request
    # if it can be granted.
    loop do
      input = ask 'Request Vector:', :yellow

      unless input.match?(/\A\d( \d){#{banker.allocation.column_count - 1}}\z/)
        say 'Wrong input!', :red
        next
      end

      if banker.grant? Vector[*input.split.map(&:to_i)]
        say 'GRANTED', :green, :bold
      else
        say 'NOT GRANTED', :red, :bold
      end
    end
  end
end
