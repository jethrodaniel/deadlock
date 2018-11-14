require 'thor'

# The main comman line interface
class CLI < Thor
  desc 'Parse [FILE]', 'Parses input [FILE], then prints deadlock information'
  def parse(file)
    puts "TODO #{file}"
  end
end
