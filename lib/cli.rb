require 'thor'

require_relative 'parser'
require_relative 'banker'

# The main command line interface
class CLI < Thor
  desc '[FILE]', 'Parses input [FILE], then prints deadlock information'
  def execute(file)
    Banker.run Parser.new(file).data
  end

  default_task :execute
end
