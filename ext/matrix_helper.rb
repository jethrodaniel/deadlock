# frozen_string_literal: true

# Helper extensions
module MatrixHelper
  require 'matrix'

  refine Array do
    def to_matrix
      Matrix[*self]
    end
  end

  refine Matrix do
    def set_row(index, vector)
      unless (0..row_size).cover?(index) && vector.size == rows[0]&.size
        raise ExceptionForMatrix::ErrDimensionMismatch
      end

      rows[index] = vector
    end
  end

  refine Vector do
    def lt_or_eq_all?(vector)
      raise ExceptionForMatrix::ErrDimensionMismatch unless size == vector.size

      zip(vector).all? { |pair| pair.first <= pair.last }
    end
  end
end
