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

  # Decides if the system can grant a request to any of its processes
  def grant?(request)
    (0..@allocation.column_count).any? do |i|
      _grant? request: request, process: i
    end
  end

  # Decides if the system can grant a request to a process
  #
  # 1. Check if request_i <= need_i, move to step #2 or return false if not
  #
  # 2. Check if request_i <= available, move to step #3 or return false if not
  #
  # 3. Pretend the request was granted, then return whether or not the
  #    resulting system would be safe
  #
  # @param  request  a request vector
  # @param  process  the index of the process which is requesting resources
  def _grant?(request:, process:)
    allocation = @allocation.clone
    available  = @available.clone
    need       = @max - @allocation

    # process has exceeded its maximum claim
    return false unless request.lt_or_eq_all? need.row_vectors[process]

    # process must wait, since resources are unavailable
    return false unless request.lt_or_eq_all? @available

    # simulate granting the request
    available -= request
    allocation.set_row(process, allocation.row_vectors[process] + request)
    need.set_row(process, need.row_vectors[process] - request)

    # whether granting the request would result in a safe state
    _safe? allocation: allocation,
           max: @max,
           available: available,
           need: need
  end

  def safe?
    _safe? allocation: @allocation, max: @max, available: @available
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
  def _safe?(allocation:, max:, available:, need: nil)
    need ||= max - allocation
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
