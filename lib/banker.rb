# frozen_string_literal: true

require 'matrix'

# Performs the Banker's algorithm on data
class Banker
  using MatrixHelper

  # Outputs if the system is SAFE or UNSAFE
  def self.run(allocation:, max:, available:)
    msg = if safe?(allocation: allocation, max: max, available: available)
            'SAFE'
          else
            'UNSAFE'
          end

    puts msg
  end

  # Decides if the system is SAFE or UNSAFE
  #
  # 1. Set up work and finish
  #
  # 2. Find index i such that
  #    - finish[i] == false
  #    - need_i <= work
  #
  #    If no such i exists, go to step 4
  #
  # 3. work = work + allocation_i
  #    finish[i] = true
  #
  #    Go to step 2
  #
  # 4. if finish[i] istrue for all i, then safe
  def self.safe?(allocation:, max:, available:)
    need   = max - allocation
    work   = available
    finish = [false] * need.row_size

    loop do
      found_i = finish.find_index.with_index do |_e, i|
        finish[i] == false && need.row_vectors[i].lt_or_eq_all?(work)
      end

      return finish.all? unless found_i

      work += allocation.row_vectors[found_i]
      finish[found_i] = true
      next
    end
  end
end
