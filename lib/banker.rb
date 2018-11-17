# frozen_string_literal: true

require 'matrix'

# Performs the Banker's algorithm on data
class Banker
  using MatrixHelper
  attr_reader :allocation, :max, :available

  def initialize(allocation:, max:, available:)
    @allocation = allocation
    @max = max
    @available = available
  end

  # Decides if the system can grant a request, if so, grants the request
  #
  # 1. Check if request <= available
  #
  #   i. If so, pretend the request was granted, then check whether or not
  #      the resulting system would be safe - if it is, then grant the request
  #      and return true, else false
  #
  #  ii. If not, the request can't be immediately granted
  def grant? request
    return false unless request.lt_or_eq_all? @available

    available = @available - request

    # Check each process to see if the request can be granted to it
    1.upto(allocation.column_size).each do |i|
      begin
        allocation.set_row(i, @allocation.row_vectors[i] + request)
        need = @need.nil? ? @max - @allocation : @need
        need.set_row(i, need.row_vectors[i] - request)
        break
      rescue ExceptionForMatrix::ErrDimensionMismatch => e
        throw ArgumentError, 'matrix dimension error'
      end
    end

    safe? allocation, max, available
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
  def safe?(allocation = @allocation, max = @max, available = @available)
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
