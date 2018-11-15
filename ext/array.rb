# Array extensions using refinements
module ArrayMatrixHelper
  require 'matrix'

  refine Array do
    def to_matrix
      Matrix[*self]
    end

    def lt_or_eq_all?(arr)
      flatten.zip(arr.flatten).all? { |pair| pair.first < pair.last }
    end
  end
end
