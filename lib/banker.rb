require 'matrix'

# Performs the Banker's algorithm on data
class Banker
  # Outputs if the system is SAFE or UNSAFE
  def self.run(allocation:, max:, available:)
    puts safe? allocation, max, available
  end

  # Decides if the system is SAFE or UNSAFE
  #
  # Find index i such that
  # 1. finish[i] == false
  # 2. need_i <= work
  def self.safe?(allocation:, max:, available:)
    need = allocation - max

    work   = available
    finish = [false] * need.row_size

    # finish.each_with_index do |e, i|
    #  if finish[i] &&
    #
    # end
    true
  end
end
