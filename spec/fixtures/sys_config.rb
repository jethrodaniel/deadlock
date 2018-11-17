require 'matrix'

class SysConfig
  def self.allocation
    Matrix[ [0, 1, 0],
            [2, 0, 0],
            [3, 0, 2],
            [2, 1, 1],
            [0, 0, 2] ]
  end

  def self.max
    Matrix[ [7, 5, 3],
            [3, 2, 2],
            [9, 0, 2],
            [2, 2, 2],
            [4, 3, 3] ]
  end

  def self.available
    Vector[3, 3, 2]
  end
end