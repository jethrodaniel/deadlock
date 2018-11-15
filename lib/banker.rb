require 'matrix'

class Banker
  # Outputs if the system is SAFE or UNSAFE
  def self.run(allocation:, max:, available:)
    puts is_safe? allocation, max, available
  end

  private

  # Decides if the system is SAFE or UNSAFE
  def self.is_safe?(allocation, max, available)
    need = allocation - max
  end
end
