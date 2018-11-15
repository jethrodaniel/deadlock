module ArrayToMatrix
  require 'matrix'

  refine Array do
    def to_matrix
      Matrix[*self]
    end
  end
end
