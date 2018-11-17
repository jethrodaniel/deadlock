# frozen_string_literal: true

# Helper extensions
module MatrixHelper
  require 'matrix'

  refine Array do
    def to_matrix
      Matrix[*self]
    end
  end

  refine Vector do
    def lt_or_eq_all?(vector)
      zip(vector).all? { |pair| pair.first <= pair.last }
    end
  end
end
