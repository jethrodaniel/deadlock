# frozen_string_literal: true

require_relative '../ext/matrix_helper'

describe 'using MatrixHelper' do
  using MatrixHelper

  describe Array do
    describe '.to_matrix' do
      let(:arr) { [[1], [2]] }

      it 'converts the nested array to a matrix' do
        expect(arr.to_matrix).to eq(Matrix.column_vector(arr.flatten))
      end
    end
  end

  describe Matrix do
    describe '.set_row' do
      let(:matrix) { Matrix[[1, 2], [3, 4]] }
      let(:vector) { Vector[9, 9] }

      it 'sets the specified row to the vector' do
        matrix.set_row 0, vector
        expect(matrix.row_vectors.first).to eq(vector)
      end
    end
  end

  describe Vector do
    describe '.lt_or_eq_all?' do
      let(:a) { Vector[1, 2] }
      let(:b) { Vector[3, 4] }

      it 'whether each element is less than its corresponding element in arr' do
        expect(a.lt_or_eq_all?(b)).to eq(true)
      end
    end
  end
end
