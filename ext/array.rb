# Array extensions using refinements
module ArrayMatrixHelper
  require 'matrix'

  refine Array do
    def to_matrix
      Matrix[*self]
    end

    def less_than_all?(arr)
      flatten.zip(arr.flatten).all? { |pair| pair.first < pair.last }
    end
  end
end
